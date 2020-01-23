## Metsa-Oy Forest Products Supply Chain
## Edward J. Xu <edxu96@outlook.com>
## Jan 23rd, 2020


function optim_2(alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2)

  mod = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0))

  @variable(mod, h_mt[1:3, 1:6]>=0, integer=true)
  @variable(mod, y_mi[1:3, 1:5]>=0)
  @variable(mod, y_mj[1:3, 1:2]>=0)
  @variable(mod, y_paper_m[1:3]>=0)
  @variable(mod, z_mik[1:3, 1:5, 1:4]>=0)
  @variable(mod, z_mjk[1:3, 1:2, 1:4]>=0)
  @variable(mod, z_paper_mk[1:3, 1:4]>=0)
  @variable(mod, 0 <= x_saw_m[1:3] <= r_saw * nu_saw)
  @variable(mod, 0 <= x_plywood_m[1:3] <= r_plywood * nu_plywood)
  @variable(mod, x_mj[1:3, 1:2] >= 0)
  @variable(mod, 0 <= x_paper_m[1:3] <= r_paper * nu_paper)

  @objective(mod, Max,
    sum(
      (-sum(alpha_t[t] * h_mt[m, t] + beta_t[t] * h_mt[m, t]^2
        for t = 1:6) +
      -sum(c_i[i] * y_mi[m, i] for i=1:5) +
      -sum(c_j[j] * y_mj[m, j] for j=1:2) - c_paper * y_paper_m[m] +
      sum(alpha_t[t] * (
        h_mt[m, t] - sum(a_i[i] * y_mi[m, i] for i in i_t1[t])
        ) for t=1:3) +
      sum(alpha_t[t] * (h_mt[m, t] + sum(b_i[i] * y_mi[m, i] for i
        in i_t2[t-3]) - sum(a_j[j] * y_mj[m, j] for j in j_t2[t-3]) -
        a_paper_t[t-3] * y_paper_m[m]) for t=4:6) +
      p_fuel * sum(e_i[i] * y_mi[m, i] for i=1:5) +
      sum(omega_i[i]^(m-1) * gamma_ik[i, k] * z_mik[m, i, k] -
        omega_i[i]^(m-1) * delta_ik[i, k] * z_mik[m, i, k]^2
        for i=1:5, k=1:4) +
      sum(omega_j[j]^(m-1) * gamma_jk[j, k] * z_mjk[m, j, k] -
        omega_j[j]^(m-1) * delta_jk[j, k] * z_mjk[m, j, k]^2
        for j=1:2, k=1:4) +
      sum(omega_paper^(m-1) * gamma_paper_k[k] * z_paper_mk[m, k] -
        omega_paper^(m-1) * delta_paper_k[k] * z_paper_mk[m, k]^2
        for k=1:4)) * sigma^(m-1) for m = 1:3
      ) +

    ## cost of capacity expansion
    -sum(
      (o_saw * (x_saw_m[m] - x_saw_m[m - 1]) +
        o_plywood * (x_plywood_m[m] - x_plywood_m[m-1]) +
        sum(o_j[j] * (x_mj[m, j] - x_mj[m-1, j]) for j=1:2) +
        o_paper * (x_paper_m[m] - x_paper_m[m-1])
        ) * sigma^(m-2) for m = 2:3
      )
    )

  @constraint(mod, mat_cons_1[t=1:3, m=1:3],
    h_mt[m, t] >= sum(a_i[i] * y_mi[m, i] for i in i_t1[t]))
  @constraint(mod, mat_cons_2[t=4:6, m=1:3],
    h_mt[m, t] + sum(b_i[i] * y_mi[m, i] for i in i_t2[t-3]) >=
    sum(a_j[j] * y_mj[m, j] for j in j_t2[t-3]) +
    a_paper_t[t-3] * y_paper_m[m])
  @constraint(mod, mat_cons_3[j=1:2, m=1:3],
    y_mj[m, j] >= b_paper_j[j] * y_paper_m[m])
  @constraint(mod, mat_cons_4[i=1:5, m=1:3],
    y_mi[m, i] >= sum(z_mik[m, i, k] for k=1:4))
  @constraint(mod, mat_cons_5[j=1:2, m=1:3],
    y_mj[m, j] - b_paper_j[j] * y_paper_m[m] >= sum(z_mjk[m, j, k] for k=1:4))
  @constraint(mod, vec_cons_6[m=1:3],
    y_paper_m[m] >= sum(z_paper_mk[m, k] for k=1:4))
  @constraint(mod, vec_cons_7[m=1:3],
    sum(y_mi[m, i] for i=1:3) <= x_saw_m[m])
  @constraint(mod, vec_cons_8[m=1:3],
    sum(y_mi[m, i] for i=4:5) <= x_plywood_m[m])
  @constraint(mod, mat_cons_9[j=1:2, m=1:3],
    y_mj[m, j] <= x_mj[m, j])
  @constraint(mod, vec_cons_10[m=1:3],
    y_paper_m[m] <= x_paper_m[m])

  ## relation between capacities
  @constraint(mod, vec_cons_11[m=2:3],
    x_saw_m[m-1] <= x_saw_m[m])
  @constraint(mod, vec_cons_12[m=2:3],
    x_plywood_m[m-1] <= x_plywood_m[m])
  @constraint(mod, mat_cons_13[m=2:3, j=1:2],
    x_mj[m-1, j] <= x_mj[m, j])
  @constraint(mod, vec_cons_14[m=2:3],
    x_paper_m[m-1] <= x_paper_m[m])
  @constraint(mod, mat_cons_15[m=2:3, j=1:2],
    x_mj[m, j] <= r_j[j] * nu_j[j])
    # the result of max constraints are set when defining the variables.
  @constraint(mod, x_saw_m[1] == r_saw)
  @constraint(mod, x_plywood_m[1] == r_plywood)
  @constraint(mod, vec_cons_16[j=1:2], x_mj[1, j] == r_j[j])
  @constraint(mod, x_paper_m[1] == r_paper)

  optimize!(mod)

  result_h_mt = value_mat(h_mt)
  result_y_mi = value_mat(y_mi)
  result_y_mj = value_mat(y_mj)
  result_y_paper_m = value_vec(y_paper_m)
  result_z_mik = value_mat3(z_mik)
  result_z_mjk = value_mat3(z_mjk)
  result_z_paper_mk = value_mat(z_paper_mk)
  result_x_saw_m = value_vec(x_saw_m)
  result_x_plywood_m = value_vec(x_plywood_m)
  result_x_mj = value_mat(x_mj)
  result_x_paper_m = value_vec(x_paper_m)
  result_obj = objective_value(mod)

  println("result_obj = $result_obj ;")
  # println(result_h_mt)
  # println(result_y_mi)
  # println(result_y_mj)
  # println(result_y_paper_m)

  print_result_2(result_h_mt, result_y_mi, result_y_mj, result_y_paper_m,
    result_z_mik, result_z_mjk, result_z_paper_mk, alpha_t, beta_t, a_i, b_i,
    e_i, c_i, r_saw, r_plywood, a_j, c_j, r_j, a_paper_t, b_paper_j, c_paper,
    r_paper, gamma_ik, delta_ik, gamma_jk, delta_jk, gamma_paper_k,
    delta_paper_k, p_fuel, sigma, omega_i, omega_j, omega_paper, nu_saw,
    nu_plywood, nu_j, nu_paper, o_saw, o_plywood, o_j, o_paper, i_t1, i_t2,
    j_t2, result_x_saw_m, result_x_plywood_m, result_x_mj, result_x_paper_m)
end
