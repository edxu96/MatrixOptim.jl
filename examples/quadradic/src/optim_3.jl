## Metsa-Oy Forest Products Supply Chain
## Edward J. Xu <edxu96@outlook.com>
## Jan 23rd, 2020


function optim_3(alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm)

  println("Optimize model 3.")
  mod = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0))

  ## Here-and-now decision variables in the first year.
  @variable(mod, h_t[1:6]>=0, integer=true)
  @variable(mod, y_i[1:5]>=0)
  @variable(mod, y_j[1:2]>=0)
  @variable(mod, y_paper>=0)
  @variable(mod, z_ik[1:5, 1:4]>=0)
  @variable(mod, z_jk[1:2, 1:4]>=0)
  @variable(mod, z_paper_k[1:4]>=0)

  ## Capacities for the second year are here-and-now decision variables.
  @variable(mod, 0 <= x_saw_nm[1:4, 2:3] <= r_saw * nu_saw)
  @variable(mod, 0 <= x_plywood_nm[1:4, 2:3] <= r_plywood * nu_plywood)
  @variable(mod, x_nmj[1:4, 2:3, 1:2] >= 0)
  @constraint(mod, [n=1:4, m=2:3, j=1:2], x_nmj[n, m, j] <= r_j[j] * nu_j[j])
  @variable(mod, 0 <= x_paper_nm[1:4, 2:3] <= r_paper * nu_paper)

  @constraint(mod, [n=2:4], x_saw_nm[1, 2] == x_saw_nm[n, 2])
  @constraint(mod, [n=2:4], x_plywood_nm[1, 2] == x_plywood_nm[n, 2])
  @constraint(mod, [n=2:4, j=1:2], x_nmj[1, 2, j] == x_nmj[n, 2, j])
  @constraint(mod, [n=2:4], x_paper_nm[1, 2] == x_paper_nm[n, 2])

  ## Wait-and-see decisions variables in the second and third year.
  @variable(mod, h_nmt[1:4, 2:3, 1:6]>=0, integer=true)
  @variable(mod, y_nmi[1:4, 2:3, 1:5]>=0)
  @variable(mod, y_nmj[1:4, 2:3, 1:2]>=0)
  @variable(mod, y_paper_nm[1:4, 2:3]>=0)
  @variable(mod, z_nmik[1:4, 2:3, 1:5, 1:4]>=0)
  @variable(mod, z_nmjk[1:4, 2:3, 1:2, 1:4]>=0)
  @variable(mod, z_paper_nmk[1:4, 2:3, 1:4]>=0)

  @objective(mod, Max,
    ## Objective fucntions regarding here-and-now decision variables.
    -sum(alpha_t[t] * h_t[t] + beta_t[t] * h_t[t]^2 for t = 1:6) +
    -sum(c_i[i] * y_i[i] for i=1:5) +
    -sum(c_j[j] * y_j[j] for j=1:2) - c_paper * y_paper +
    sum(alpha_t[t] * (
      h_t[t] - sum(a_i[i] * y_i[i] for i in i_t1[t])
      ) for t=1:3) +
    sum(alpha_t[t] * (
      h_t[t] + sum(b_i[i] * y_i[i] for i in i_t2[t-3]) -
      sum(a_j[j] * y_j[j] for j in j_t2[t-3]) -
        a_paper_t[t-3] * y_paper) for t=4:6) +
    sum(e_i[i] * y_i[i] for i=1:5) * p_fuel +
    sum(gamma_ik[i, k] * z_ik[i, k] - delta_ik[i, k] * z_ik[i, k]^2
      for i=1:5, k=1:4) +
    sum(gamma_jk[j, k] * z_jk[j, k] - delta_jk[j, k] * z_jk[j, k]^2
      for j=1:2, k=1:4) +
    sum(gamma_paper_k[k] * z_paper_k[k] -
      delta_paper_k[k] * z_paper_k[k]^2
      for k=1:4) +

    ## here-and-now capacity in the second year.
    ## those in the first scenario are used because they are the same.
    o_saw * (x_saw_nm[1, 2] - r_saw) +
      o_plywood * (x_plywood_nm[1, 2] - r_plywood) +
      sum(o_j[j] * (x_nmj[1, 2, j] - r_j[j]) for j=1:2) +
      o_paper * (x_paper_nm[1, 2] - r_paper) +

    ## Objective fucntions regarding wait-and-see decision variables.
    sum(
      pi_n[n] * (
        sum(
          sigma^(m-1) * (
            ## 1, cost of timber procurement
            -sum(alpha_t[t] * h_nmt[n, m, t] + beta_t[t] * h_nmt[n, m, t]^2
              for t = 1:6) +
            ## 2, cost of wood production
            -sum(c_i[i] * y_nmi[n, m, i] for i=1:5) +
            ## 3, cost of pulp and paper production
            -sum(c_j[j] * y_nmj[n, m, j] for j=1:2) +
            -c_paper * y_paper_nm[n, m] +
            ## 4, profit of left timbers selling
            sum(alpha_t[t] * (h_nmt[n, m, t] - sum(a_i[i] * y_nmi[n, m, i]
              for i in i_t1[t])) for t=1:3) +
            sum(alpha_t[t] * (h_nmt[n, m, t] + sum(b_i[i] * y_nmi[n, m, i]
              for i in i_t2[t-3]) - sum(a_j[j] * y_nmj[n, m, j] for j in
              j_t2[t-3]) - a_paper_t[t-3] * y_paper_nm[n, m]) for t=4:6) +
            ## 5, profit of fuel wood selling
            p_fuel * sum(e_i[i] * y_nmi[n, m, i] for i=1:5) +
            ## 6, profit of wood selling
            sum(omega_i[i]^(m-1) * rho_nm[n, m] * gamma_ik[i, k] *
              z_nmik[n, m, i, k] - omega_i[i]^(m-1) * rho_nm[n, m] *
              delta_ik[i, k] * z_nmik[n, m, i, k]^2 for i=1:5, k=1:4) +
            ## 7, profit of pulp selling
            sum(omega_j[j]^(m-1) * rho_nm[n, m] * gamma_jk[j, k] *
              z_nmjk[n, m, j, k] - omega_j[j]^(m-1) * rho_nm[n, m] *
              delta_jk[j, k] * z_nmjk[n, m, j, k]^2 for j=1:2, k=1:4) +
            ## 8, profit of paper selling
            sum(omega_paper^(m-1) * rho_nm[n, m] * gamma_paper_k[k] *
              z_paper_nmk[n, m, k] - omega_paper^(m-1) * rho_nm[n, m] *
              delta_paper_k[k] * z_paper_nmk[n, m, k]^2 for k=1:4)
            ) for m = 2:3
          ) +

        ## Cost of capacity expansion in the third year
        sigma * (
          o_saw * (x_saw_nm[n, 3] - x_saw_nm[1, 2]) +
          o_plywood * (x_plywood_nm[n, 3] - x_plywood_nm[1, 2]) +
          sum(o_j[j] * (x_nmj[n, 3, j] - x_nmj[1, 2, j]) for j=1:2) +
          o_paper * (x_paper_nm[n, 3] - x_paper_nm[n, 2])
          )

        ) for n=1:4
      )
    )

  ## Constraints for here-and-now decision variables
  @constraint(mod, [t=1:3],
    h_t[t] >= sum(a_i[i] * y_i[i] for i in i_t1[t]))
  @constraint(mod, [t=4:6],
    h_t[t] + sum(b_i[i] * y_i[i] for i in i_t2[t-3]) >=
    sum(a_j[j] * y_j[j] for j in j_t2[t-3]) + a_paper_t[t-3] * y_paper)
  @constraint(mod, [j=1:2],
    y_j[j] >= b_paper_j[j] * y_paper)
  @constraint(mod, [i=1:5],
    y_i[i] >= sum(z_ik[i, k] for k=1:4))
  @constraint(mod, [j=1:2],
    y_j[j] - b_paper_j[j] * y_paper >= sum(z_jk[j, k] for k=1:4))
  @constraint(mod, y_paper >= sum(z_paper_k[k] for k=1:4))
  @constraint(mod, sum(y_i[i] for i=1:3) <= r_saw)
  @constraint(mod, sum(y_i[i] for i=4:5) <= r_plywood)
  @constraint(mod, [j=1:2], y_j[j] <= r_j[j])
  @constraint(mod, y_paper <= r_paper)

  ## Constraints for wait-and-see decision variables.
  @constraint(mod, [n=1:4, t=1:3, m=2:3],
    h_nmt[n, m, t] >= sum(a_i[i] * y_nmi[n, m, i] for i in i_t1[t]))
  @constraint(mod, [n=1:4, t=4:6, m=2:3],
    h_nmt[n, m, t] + sum(b_i[i] * y_nmi[n, m, i] for i in i_t2[t-3]) >=
    sum(a_j[j] * y_nmj[n, m, j] for j in j_t2[t-3]) +
    a_paper_t[t-3] * y_paper_nm[n, m])
  @constraint(mod, [n=1:4, j=1:2, m=2:3],
    y_nmj[n, m, j] >= b_paper_j[j] * y_paper_nm[n, m])
  @constraint(mod, [n=1:4, i=1:5, m=2:3],
    y_nmi[n, m, i] >= sum(z_nmik[n, m, i, k] for k=1:4))
  @constraint(mod, [n=1:4, j=1:2, m=2:3], y_nmj[n, m, j] -
    b_paper_j[j] * y_paper_nm[n, m] >= sum(z_nmjk[n, m, j, k] for k=1:4))
  @constraint(mod, [n=1:4, m=2:3],
    y_paper_nm[n, m] >= sum(z_paper_nmk[n, m, k] for k=1:4))
  @constraint(mod, [n=1:4, m=2:3],
    sum(y_nmi[n, m, i] for i=1:3) <= x_saw_nm[n, m])
  @constraint(mod, [n=1:4, m=2:3],
    sum(y_nmi[n, m, i] for i=4:5) <= x_plywood_nm[n, m])
  @constraint(mod, [n=1:4, j=1:2, m=2:3], y_nmj[n, m, j] <= x_nmj[n, m, j])
  @constraint(mod, [n=1:4, m=2:3], y_paper_nm[n, m] <= x_paper_nm[n, m])

  ## relation between capacities
  @constraint(mod, [n=1:4], x_saw_nm[n, 2] <= x_saw_nm[n, 3])
  @constraint(mod, [n=1:4], x_plywood_nm[n, 2] <= x_plywood_nm[n, 3])
  @constraint(mod, [n=1:4, j=1:2], x_nmj[n, 2, j] <= x_nmj[n, 3, j])
  @constraint(mod, [n=1:4], x_paper_nm[n, 2] <= x_paper_nm[n, 3])

  @constraint(mod, r_saw <= x_saw_nm[1, 2])
  @constraint(mod, r_plywood <= x_plywood_nm[1, 2])
  @constraint(mod, [j=1:2], r_j[j] <= x_nmj[1, 2, j])
  @constraint(mod, r_paper <= x_paper_nm[1, 2])

  optimize!(mod)

  # result_h_mt = value_mat(h_mt)
  # result_y_mi = value_mat(y_mi)
  # result_y_mj = value_mat(y_mj)
  # result_y_paper_m = value_vec(y_paper_m)
  # result_z_mik = value_mat3(z_mik)
  # result_z_mjk = value_mat3(z_mjk)
  # result_z_paper_mk = value_mat(z_paper_mk)
  result_obj = objective_value(mod)

  # println(result_h_mt)
  # println(result_y_mi)
  # println(result_y_mj)
  # println(result_y_paper_m)
  # println(result_z_mik)
  # println(result_z_mjk)
  # println(result_z_paper_mk)
  println(result_obj)
end
