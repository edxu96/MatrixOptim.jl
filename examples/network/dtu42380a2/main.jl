using JuMP, Gurobi, CSV
include("./func.jl")


function solve_mod_1()
  demands, costs_ship, costs_fix, cost_var, q, e = get_data()

  num_s = 3
  num_l = 5
  num_v = 6
  num_p = 5
  num_w = 2

  model = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0));

  @variable(model, x[1:num_s, 1:num_l, 1:num_v] >= 0, Int)
  @variable(model, y[1:num_p, 1:num_l, 1:num_w], Bin)
  @variable(model, z[1:num_s, 1:num_l, 1:num_w], Bin)

  @objective(model, Min,
    sum(costs_fix[l, w] *  sum(e[p, s] * y[p, l, w] for p = 1:num_p) for
      l = 1:num_l, s = 1:num_s, w = 1:num_w) +
    475000 * sum(z[s, l, w] for s = 1:num_s, l = 1:num_l, w = 1:num_w) +
    (0.165 + cost_var) * sum(x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v) +
    sum(costs_ship[l, v] * x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v)
    )

  @constraint(model, [l = 1:num_l, s = 1:num_s], sum(x[s, l, v] for
    v = 1:num_v) <= sum(q[w] * z[s, l, w] for w = 1:num_w))
  @constraint(model, [l = 1:num_l, w = 1:num_w], sum(y[p, l, w] for
    p = 1:num_p) == 1)
  @constraint(model, [l = 1:num_l, w = 1:num_w, s = 1:num_s],
    z[s, l, w] <= sum(e[p, s] * y[p, l, w] for p = 1:num_p))
  @constraint(model, [s = 1:num_s, v = 1:num_v],
    sum(x[s, l, v] for l = 1:num_l) >= demands[s, v])

  optimize!(model)


  y_raw = value_mat3(y)
  y_opt = zeros(num_s, num_l, num_w)
  for s = 1:num_s, l = 1:num_l, w= 1:num_w
    y_opt[s, l, w] = sum(e[p, s] * y_raw[p, l, w] for p = 1:num_p)
  end

  @show x_opt = value_mat3(x)
  @show z_opt = value_mat3(z)
  @show y_opt
end


solve_mod_1()
