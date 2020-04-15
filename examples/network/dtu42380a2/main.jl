## DTU42380a2: Supply Networks and Inventory
## Edward J. Xu
## April 10, 2020
## cd ~/GitHub/MatrixOptim.jl/examples/network/dtu42380a2

using JuMP, Gurobi, CSV
include("./func.jl")


function solve_mod(demands, costs_ship, costs_fix, cost_var, q, e, num_p)
  num_s = 3
  num_l = 5
  num_v = 6
  num_w = 2

  model = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0));

  @variable(model, x[1:num_s, 1:num_l, 1:num_v] >= 0, Int)
  @variable(model, y[1:num_p, 1:num_l, 1:num_w], Bin)
  @variable(model, z[1:num_s, 1:num_l, 1:num_w], Bin)

  @objective(model, Max,
    - sum(costs_fix[l, w] *  sum(e[p, s] * y[p, l, w] for p = 1:num_p) for
      l = 1:num_l, s = 1:num_s, w = 1:num_w) +
    - 475000 * sum(z[s, l, w] for s = 1:num_s, l = 1:num_l, w = 1:num_w) +
    - (0.165 + cost_var) * sum(x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v) +
    - sum(costs_ship[l, v] * x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v) +
    sum(demands) * 0.75  # customer fee income
    )

  @constraint(model, [l = 1:num_l, s = 1:num_s], sum(x[s, l, v] for
    v = 1:num_v) <= sum(q[w] * z[s, l, w] for w = 1:num_w))
  @constraint(model, [l = 1:num_l, w = 1:num_w], sum(y[p, l, w] for
    p = 1:num_p) == 1)
  @constraint(model, [l = 1:num_l, w = 1:num_w, s = 1:num_s],
    z[s, l, w] <= sum(e[p, s] * y[p, l, w] for p = 1:num_p))
  @constraint(model, [s = 1:num_s, v = 1:num_v],
    sum(x[s, l, v] for l = 1:num_l) == demands[s, v])

  optimize!(model)

  return model, x, y, z, e, q
end


function solve_mod_flex(demands, costs_ship, costs_fix, cost_var, q, e, num_p)
  num_s = 3
  num_l = 5
  num_v = 6
  num_w = 2

  model = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0));

  @variable(model, x[1:num_s, 1:num_l, 1:num_v] >= 0, Int)
  @variable(model, y[1:num_p, 1:num_l, 1:num_w], Bin)
  @variable(model, z[1:num_s, 1:num_l, 1:num_w] >= 0, Int)
  @variable(model, t[1:num_s, 1:num_l, 1:num_w] >= 0, Int)

  @objective(model, Max,
    - sum(costs_fix[l, w] * t[s, l, w] * sum(e[p, s] * y[p, l, w] for p = 1:num_p) for
      l = 1:num_l, s = 1:num_s, w = 1:num_w) +
    - 475000 * sum(z[s, l, w] for s = 1:num_s, l = 1:num_l, w = 1:num_w) +
    - (0.165 + cost_var) * sum(x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v) +
    - sum(costs_ship[l, v] * x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v) +
    sum(demands) * 0.75  # customer fee income
    )

  @constraint(model, [l = 1:num_l, s = 1:num_s], sum(x[s, l, v] for
    v = 1:num_v) <= sum(q[w] * z[s, l, w] for w = 1:num_w))
  @constraint(model, [l = 1:num_l, w = 1:num_w], sum(y[p, l, w] for
    p = 1:num_p) == 1)
  @constraint(model, [l = 1:num_l, w = 1:num_w, s = 1:num_s],
    z[s, l, w] <= t[s, l, w] * sum(e[p, s] * y[p, l, w] for p = 1:num_p))
  @constraint(model, [s = 1:num_s, v = 1:num_v],
    sum(x[s, l, v] for l = 1:num_l) == demands[s, v])

  optimize!(model)

  return model, x, y, z, e, q
end


function solve_mod_flex_milp(demands, costs_ship, costs_fix, cost_var, q,
    e, num_p)

  num_s = 3
  num_l = 5
  num_v = 6
  num_w = 2

  model = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0));

  @variable(model, x[1:num_s, 1:num_l, 1:num_v] >= 0, Int)
  @variable(model, y[1:num_p, 1:num_l, 1:num_w], Bin)
  @variable(model, z[1:num_s, 1:num_l, 1:num_w] >= 0, Int)
  @variable(model, t[1:num_s, 1:num_l, 1:num_w] >= 0, Int)

  @objective(model, Max,
    - sum(costs_fix[l, w] * t[s, l, w] for l = 1:num_l, s = 1:num_s,
      w = 1:num_w) - 475000 * sum(z[s, l, w] for s = 1:num_s, l = 1:num_l,
      w = 1:num_w) - (0.165 + cost_var) * sum(x[s, l, v] for s = 1:num_s,
      l = 1:num_l, v = 1:num_v) - sum(costs_ship[l, v] * x[s, l, v] for
      s = 1:num_s, l = 1:num_l, v = 1:num_v) +
    sum(demands) * 0.75  # customer fee income
    )

  @constraint(model, [l = 1:num_l, s = 1:num_s], sum(x[s, l, v] for
    v = 1:num_v) <= sum(q[w] * z[s, l, w] for w = 1:num_w))
  @constraint(model, [l = 1:num_l, w = 1:num_w], sum(y[p, l, w] for
    p = 1:num_p) == 1)
  @constraint(model, [l = 1:num_l, w = 1:num_w, s = 1:num_s],
    z[s, l, w] <= t[s, l, w])
  @constraint(model, [l = 1:num_l, w = 1:num_w, s = 1:num_s],
    t[s, l, w] <= 100 * sum(e[p, s] * y[p, l, w] for p = 1:num_p))
  @constraint(model, [l = 1:num_l, w = 1:num_w, s = 1:num_s],
    t[s, l, w] >= sum(e[p, s] * y[p, l, w] for p = 1:num_p))
  @constraint(model, [s = 1:num_s, v = 1:num_v],
    sum(x[s, l, v] for l = 1:num_l) == demands[s, v])

  optimize!(model)

  return model, x, y, z, e, q, t
end


function analyze(model, x, y, z, e, q, num_p)
  num_s = 3
  num_l = 5
  num_v = 6
  num_w = 2

  y_raw = value_mat3(y)
  y_raw[abs.(y_raw) .< 0.001] .= 0
  y_opt_small = zeros(num_s, num_l)
  y_opt_large = zeros(num_s, num_l)
  for s = 1:num_s, l = 1:num_l
    y_opt_small[s, l] = sum(e[p, s] * y_raw[p, l, 1] for p = 1:num_p)
    y_opt_large[s, l] = sum(e[p, s] * y_raw[p, l, 2] for p = 1:num_p)
  end

  z_raw = value_mat3(z)
  z_raw[abs.(z_raw) .< 0.001] .= 0
  z_opt_small = z_raw[:, :, 1]
  z_opt_large = z_raw[:, :, 2]

  @show objective_value(model)
  display(y_opt_small)
  display(y_opt_large)
  display(z_opt_small)
  display(z_opt_large)

  x_opt = value_mat3(x)
  ths = zeros(3, 5) # matrix for throughs
  exs = zeros(3, 5) # matrix for excess capacities
  for s = 1:num_s, l = 1:num_l
    through = sum(x_opt[s, l, v] for v = 1:num_v)
    if through >= 0.01
      # println("x = $(round(through, digits=3)) when s = $(s) and l = $(l).")
      excess = sum(z_raw[s, l, w] * q[w] for w = 1:2) - through
      # println("Excess capacity equals $(round(excess, digits = 3)).")
      ths[s, l] = round(through, digits = 3)
      exs[s, l] = round(excess, digits = 3)
    end
  end

  println("\nThroughs and excess capacities.")
  display(ths)
  display(exs)
end


function analyze_flex(t)
  t_raw = value_mat3(t)
  t_raw[abs.(t_raw) .< 0.001] .= 0
  t_opt_small = t_raw[:, :, 1]
  t_opt_large = t_raw[:, :, 2]

  display(t_opt_small)
  display(t_opt_large)
end


function main()
  demands, costs_ship, costs_fix, cost_var, q, e = get_data()

  ## Model for Task 1
  # num_p = 5
  # model, x, y, z, e, q = solve_mod(demands, costs_ship, costs_fix,
  #   cost_var, q, e, num_p)

  ## Model 3 for Task 3
  # num_p = 5
  # model, x, y, z, e, q = solve_mod_flex(demands, costs_ship, costs_fix,
  #   cost_var, q, e, num_p)

  ## Model 4 for Task 3
  # num_p = 5
  # model, x, y, z, e, q, t = solve_mod_flex_milp(demands, costs_ship, costs_fix,
  #   cost_var, q, e, num_p)
  # analyze_flex(t)

  ## Model 2 for Task 3
  e = [
    1 1 0;
    0 1 1;
    1 1 1;
    0 0 1;
    0 0 0;
    1 0 0;
    0 1 0
    ]  # e[p, s]
  num_p = 7
  model, x, y, z, e, q = solve_mod(demands, costs_ship, costs_fix, cost_var,
    q, e, num_p)

  analyze(model, x, y, z, e, q, num_p)
end


main()
