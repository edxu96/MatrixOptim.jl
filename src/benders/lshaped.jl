## L-Shaped Benders Decomposition for Stochastic Programming
## Edward J. Xu <edxu96@outlook.com>
## August 11, 2019


"MILP model for L-Shaped Benders decomposition (LSBD) in matrix form."
mutable struct ModelLSBD
  n_x
  vec_min_y
  vec_max_y
  vec_c
  vec_f
  vec_b
  mat_aCap
  mat_bCap
  solution::Union{Solution, Missing}

  function ModelLSBD(
      vec_min_y::Array{Int64,1}, vec_max_y::Array{Int64,1},
      vec_c::Array{Int64,2}, vec_b::Array{Int64,2},
      vec_f::Array{Int64,2}, mat_aCap::Array{Int64,2},
      mat_bCap::Array{Int64,2}
      )
    checkListLength(vec_min_y, vec_max_y, 'vec_min_y', 'vec_max_y')
    checkColVec(vec_c, "vec_c")
    checkColVec(vec_f, "vec_f")
    checkColVec(vec_b, "vec_b")
    checkMatrixMatch(vec_c, mat_aCap, row, col, "vec_c", "mat_aCap")
    checkMatrixMatch(vec_f, mat_bCap, row, col, "vec_f", "mat_bCap")
    checkMatrixMatch(mat_aCap, mat_bCap, row, row, "mat_aCap", "mat_bCap")
    checkMatrixMatch(mat_aCap, vec_b, row, row, "mat_aCap", "vec_b")
    new(vec_c, mat_aCap, vec_f, mat_bCap, vec_b, missing)
  end
end


"First two variables are updated."
function solve_master!(obj_mas, model_mas, e1_mat, e2, opt_cut::Bool)
  if opt_cut
    @constraint(model_mas, (e1_mat * vec_y)[1] + q >= e2)
  else
    ## Add feasible cut Constraints
    @constraint(model_mas, (e1_mat * vec_y)[1] >= e2)
    @constraint(model_mas, (e1_mat * vec_y)[1] + q >= e2)
  end

  optimize!(model_mas)
  obj_mas = objective_value(model_mas)
end


"First two variables are updated."
function solve_sub!(vec_ubar, obj_sub, vec_ybar, n_constraint, vec_h , mat_t,
    mat_w, vec_c)

  model_sub = Model(with_optimizer(GLPK.Optimizer))
  @variable(model_sub, vec_u[1: n_constraint] >= 0)
  @objective(model_sub, Max, (transpose(vec_h - mat_t * vec_ybar) * vec_u)[1])
  cons_dual = @constraint(model_sub, transpose(mat_w) * vec_u .<= vec_c)
  sol = optimize!(model_sub)

  print("  Sub Problem")
  vec_ubar = value.(vec_u)
  if sol == :OPTIMAL
    bool_sub = true
    obj_sub = objective_value(model_sub)
    vec_result_x = dual(cons_dual)
  elseif sol == :DUAL_INFEASIBLE # ???
    print("Not solved optimally because the feasible set is unbounded.\n")
    bool_sub = false
    obj_sub = objective_value(model_sub)
    vec_result_x = repeat([NaN], length(vec_c))
  elseif sol == :INFEASIBLE
    print("Not solved optimally because of infeasibility. Something is ",
      "wrong.\n")
    bool_sub = false
    obj_sub = NaN
    vec_ubar = hcat(vec_ubar)
    vec_result_x = hcat(repeat([NaN], length(vec_c)))
  end

  return bool_sub, vec_result_x
end


"""
Solve the sub-problem with ray.
  First two variables are updated.
"""
function solve_ray!(vec_ubar, obj_ray, vec_ybar, n_constraint, vec_h, mat_t,
    mat_w)

  model_ray = Model(with_optimizer(GLPK.Optimizer))
  @variable(model_ray, vec_u[1: n_constraint] >= 0)
  @objective(model_ray, Max, 1)
  @constraint(model_ray, (transpose(vec_h - mat_t * vec_ybar) * vec_u)[1] == 1)
  @constraint(model_ray, transpose(mat_w) * vec_u .<= 0)
  optimize!(model_ray)

  print("  Ray Problem\n")
  vec_ubar = value.(vec_u)
  obj_ray = objective_value(model_ray)
end


"""
L-Shaped Benders Decomposition for Stochastic Programming without Integer
  Variables in Second Stage.
"""
function lshaped(; n_x, vec_min_y, vec_max_y, vec_f, vec_pi, mat_c, mat_h,
    mat3_t, mat3_w, epsilon=1e-6, timesIterationMax=100)

  println("Begin L-Shaped Benders Decomposition")
  n_y = length(vec_min_y)
  num_s = length(mat3_t[:, 1, 1])
  n_constraint = length(mat3_w[1, :, 1])
  mod_mas = set_mod_mas(n_y, vec_min_y, vec_max_y)

  let
    ub = Inf  # upper bound
    lb = - Inf  # lower bound

    # initial value of master variables
    mat_uBar = zeros(num_s, n_constraint, 1)
    vec_ybar = zeros(n_y, 1)
    vec_result_x = zeros(num_s, Int8(n_x / num_s), 1)
    obj_sub = 0
    obj_sub_s = zeros(num_s)
    timesIteration = 1

    dict_obj_mas = Dict()
    dict_q = Dict()
    dict_obj_sub = Dict()
    dict_obj_ray = Dict()
    dict_ub = Dict()
    dict_lb = Dict()

    # Must make sure "result_q == obj_sub" in the final iteration
    # while ((ub - lb > epsilon) && (timesIteration <= timesIterationMax))  !!!
    while check_whe_continue(ub, lb, epsilon, result_q, obj_sub,
        timesIteration, timesIterationMax)
      ## 1. Solve sub/ray problem for each scenario
      bool_sub_s = trues(num_s)
      for s = 1: num_s
        bool_sub_s[s], vec_result_x[s, :, :] = solve_sub!(mat_uBar[s, :, :],
          obj_sub_s[s], vec_ybar, n_constraint, mat_h[s, :, :], mat3_t[s, :, :],
          mat3_w[s, :, :], mat_c[s, :, :])
        if !(bool_sub_s[s])
          solve_ray!(mat_uBar[s, :, :], obj_sub_s[s], vec_ybar, n_constraint,
            mat_h[s, :, :], mat3_t[s, :, :], mat3_w[s, :, :])
        end
      end
      obj_sub = (transpose(vec_pi) * obj_sub_s)[1]
      ub = min(ub, obj_sub + (transpose(vec_f) * vec_ybar)[1])

      ## 2. Add optimal cut to master problem
      e1_mat = sum(vec_pi[s] * (transpose(mat_uBar[s, :]) * mat3_t[s, :, :])[1]
        for s = 1: num_s)
      e2 = sum(vec_pi[s] * (transpose(mat_uBar[s, :]) * mat_h[s, :])[1] for
        s = 1: num_s)

      solve_master!(obj_mas, e1_mat, e2, bool_sub_s[1])
      vec_ybar = value.(vec_y)

      ## 3. Compare the bounds and decide whether to stop
      lb = max(lb, obj_mas)
      result_q = value.(q)

      dict_ub[timesIteration] = ub
      dict_lb[timesIteration] = lb
      dict_obj_mas[timesIteration] = obj_mas
      dict_obj_sub[timesIteration] = obj_sub
      dict_q[timesIteration] = result_q

      if bool_sub_s[1]
        println("------------------ Result in $(timesIteration)-th Iteration with Sub ",
            "-------------------\n", "ub: $(round(ub, digits = 5)), ",
            "lb: $(round(lb, digits = 5)), obj_mas: $(round(obj_mas, digits = 5)), ",
            "q: $result_q, obj_sub: $(round(obj_sub, digits = 5)).")
      else
        println("------------------ Result in $(timesIteration)-th Iteration with Ray ",
            "-------------------\n", "ub: $(round(ub, digits = 5)), ",
            "lb: $(round(lb, digits = 5)), obj_mas: $(round(obj_mas, digits = 5)), ",
            "q: $result_q, obj_ray: $(round(obj_ray, digits = 5)).")
      end
      timesIteration += 1
    end

    println("obj_mas: $(objective_value(model_mas))")
    println("-------------------------------------------------------------------------\n",
        "------------------------------ 2/4. Result ------------------------------\n",
        "-------------------------------------------------------------------------")
    println("ub: $(round(ub, digits = 5)), lb: $(round(lb, digits = 5)), ",
        "difference: $(round(ub - lb, digits = 5))")
    println("vec_x: $vec_result_x")
    vec_result_y = value.(vec_y)
    result_q = value.(q)
    println("vec_y: $vec_result_y")
    println("result_q: $result_q")

    println("-------------------------------------------------------------------------\n",
        "------------------------- 3/4. Iteration Result -------------------------\n",
        "-------------------------------------------------------------------------")
    # Initialize
    seq_timesIteration = collect(1: (timesIteration - 1))
    vec_ub = zeros(timesIteration - 1)
    vec_lb = zeros(timesIteration - 1)
    obj_sub_sRay = zeros(timesIteration - 1)
    vec_obj_mas = zeros(timesIteration - 1)
    vec_q = zeros(timesIteration - 1)
    vec_type = repeat(["ray"], (timesIteration - 1))

    #
    for i = 1: (timesIteration - 1)
      vec_obj_mas[i] = round(dict_obj_mas[i], digits = 5)
      vec_ub[i] = round(dict_ub[i], digits = 5)
      vec_lb[i] = round(dict_lb[i], digits = 5)
      vec_q[i] = round(dict_q[i], digits = 5)
      if haskey(dict_obj_sub, i)
        vec_type[i] = "sub"
        obj_sub_sRay[i] = round(dict_obj_sub[i], digits = 5)
      else
        obj_sub_sRay[i] = round(dict_obj_ray[i], digits = 5)
      end
    end
    table_iterationResult = hcat(seq_timesIteration, vec_ub, vec_lb,
      vec_obj_mas, vec_q, vec_type, obj_sub_sRay)
    pretty_table(table_iterationResult,
      ["Seq", "ub", "lb", "obj_mas", "q", "sub/ray", "obj_sub/ray"],
      compact; alignment=:l)
  end

  println("-------------------------------------------------------------------------\n",
      "-------------------------- 4/4. Nominal Ending --------------------------\n",
      "-------------------------------------------------------------------------\n")
end
