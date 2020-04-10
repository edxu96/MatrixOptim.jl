## DTU42380a2: Supply Networks and Inventory
## Edward J. Xu
## April 10, 2020
## cd ~/GitHub/MatrixOptim.jl/examples/network/dtu42380a2

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

  @objective(model, Max,
    - sum(costs_fix[l, w] *  sum(e[p, s] * y[p, l, w] for p = 1:num_p) for
      l = 1:num_l, s = 1:num_s, w = 1:num_w) +
    -475000 * sum(z[s, l, w] for s = 1:num_s, l = 1:num_l, w = 1:num_w) +
    -(0.165 + cost_var) * sum(x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v) +
    -sum(costs_ship[l, v] * x[s, l, v] for s = 1:num_s, l = 1:num_l,
      v = 1:num_v) +
    13915125  # customer fee income
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

  return model, x, y, z, e
end


function analyze(model, x, y, z, e)
  num_s = 3
  num_l = 5
  num_v = 6
  num_p = 5
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
  for s = 1:num_s, l = 1:num_l
    through = sum(x_opt[s, l, v] for v = 1:num_v)
    if through >= 0.01
      println("x = $(round(through, digits=3)) when s = $(s) and l = $(l).")
    end
  end
end


model, x, y, z, e = solve_mod_1()
analyze(model, x, y, z, e)
