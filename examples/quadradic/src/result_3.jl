
function print_result_3(
    result_h_t, result_y_i, result_y_j, result_y_paper, result_z_ik,
    result_z_jk, result_z_paper_k, result_h_nmt, result_y_nmi, result_y_nmj,
    result_y_paper_nm, result_z_nmik, result_z_nmjk, result_z_paper_nmk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm, result_x_saw_nm,
    result_x_plywood_nm, result_x_nmj, result_x_paper_nm)

  h_t = result_h_t
  y_i = result_y_i
  y_j = result_y_j
  y_paper = result_y_paper
  z_ik = result_z_ik
  z_jk = result_z_jk
  z_paper_k = result_z_paper_k
  h_nmt = result_h_nmt
  y_nmi = result_y_nmi
  y_nmj = result_y_nmj
  y_paper_nm = result_y_paper_nm
  z_nmik = result_z_nmik
  z_nmjk = result_z_nmjk
  z_paper_nmk = result_z_paper_nmk
  x_saw_nm = result_x_saw_nm
  x_plywood_nm = result_x_plywood_nm
  x_nmj = result_x_nmj
  x_paper_nm = result_x_paper_nm

  cal_dis_profit_3_first_year(h_t, y_i, y_j, y_paper, z_ik,
    z_jk, z_paper_k, h_nmt, y_nmi, y_nmj,
    y_paper_nm, z_nmik, z_nmjk, z_paper_nmk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm, x_saw_nm,
    x_plywood_nm, x_nmj, x_paper_nm)

  cal_dis_profit_3_second_year(h_t, y_i, y_j, y_paper, z_ik,
    z_jk, z_paper_k, h_nmt, y_nmi, y_nmj,
    y_paper_nm, z_nmik, z_nmjk, z_paper_nmk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm, x_saw_nm,
    x_plywood_nm, x_nmj, x_paper_nm)

  cal_dis_profit_3_third_year(h_t, y_i, y_j, y_paper, z_ik,
    z_jk, z_paper_k, h_nmt, y_nmi, y_nmj,
    y_paper_nm, z_nmik, z_nmjk, z_paper_nmk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm, x_saw_nm,
    x_plywood_nm, x_nmj, x_paper_nm)
end


function cal_dis_profit_3_first_year(h_t, y_i, y_j, y_paper, z_ik,
    z_jk, z_paper_k, h_nmt, y_nmi, y_nmj,
    y_paper_nm, z_nmik, z_nmjk, z_paper_nmk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm, x_saw_nm,
    x_plywood_nm, x_nmj, x_paper_nm)

  dis_profit =
    ## Objective fucntions regarding here-and-now decision variables.
    -sum(alpha_t[t] * h_t[t] + beta_t[t] * h_t[t]^2 for t = 1:6) +
    -sum(c_i[i] * y_i[i] for i=1:5) +
    -sum(c_j[j] * y_j[j] for j=1:2) - c_paper * y_paper +
    sum(alpha_t[t] * (
      h_t[t] - sum(a_i[i] * y_i[i] for i in i_t1[t])
      ) for t=1:3) +
    alpha_t[4] * (h_t[4] + sum(b_i[i] * y_i[i] for i in
      i_t2[1]) - sum(a_j[j] * y_j[j] for j in j_t2[1]) -
      a_paper_t[1] * y_paper) +
    alpha_t[6] * (h_t[6] + sum(b_i[i] * y_i[i] for i in
      i_t2[3]) - sum(a_j[j] * y_j[j] for j in j_t2[3]) -
      a_paper_t[3] * y_paper) +
    ## when t = 5
    alpha_t[5] * (h_t[5] + sum(b_i[i] * y_i[i] for i in
      i_t2[2]) - a_paper_t[2] * y_paper) +
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
    - (o_saw * (x_saw_nm[1, 2] - r_saw) +
      o_plywood * (x_plywood_nm[1, 2] - r_plywood) +
      sum(o_j[j] * (x_nmj[1, 2, j] - r_j[j]) for j=1:2) +
      o_paper * (x_paper_nm[1, 2] - r_paper))
end


function cal_dis_profit_3_second_year(h_t, y_i, y_j, y_paper, z_ik,
    z_jk, z_paper_k, h_nmt, y_nmi, y_nmj,
    y_paper_nm, z_nmik, z_nmjk, z_paper_nmk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm, x_saw_nm,
    x_plywood_nm, x_nmj, x_paper_nm)
  m = 2

  dis_profit = sum(pi_n[n] * (sigma^(m-1) * (
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
      j_t2[t-3]) - a_paper_t[t-3] * y_paper_nm[n, m]) for t in [4, 6]) +
    ## when t = 5
    alpha_t[5] * (h_nmt[n, m, 5] + sum(b_i[i] * y_nmi[n, m, i]
      for i in i_t2[2]) - a_paper_t[2] * y_paper_nm[n, m]) +
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
    ) +

    ## Cost of capacity expansion in the third year
    - sigma * (
      o_saw * (x_saw_nm[1, 3] - x_saw_nm[1, 2]) +
      o_plywood * (x_plywood_nm[1, 3] - x_plywood_nm[1, 2]) +
      sum(o_j[j] * (x_nmj[1, 3, j] - x_nmj[1, 2, j]) for j=1:2) +
      o_paper * (x_paper_nm[1, 3] - x_paper_nm[1, 2]))
    ) for n=1:4)
end

function cal_dis_profit_3_third_year(h_t, y_i, y_j, y_paper, z_ik,
    z_jk, z_paper_k, h_nmt, y_nmi, y_nmj,
    y_paper_nm, z_nmik, z_nmjk, z_paper_nmk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm, x_saw_nm,
    x_plywood_nm, x_nmj, x_paper_nm)
  m = 3

  ## Objective fucntions regarding wait-and-see decision variables.
  sum(
    pi_n[n] * (
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
          j_t2[t-3]) - a_paper_t[t-3] * y_paper_nm[n, m]) for t in [4, 6]) +
        ## when t = 5
        alpha_t[5] * (h_nmt[n, m, 5] + sum(b_i[i] * y_nmi[n, m, i]
          for i in i_t2[2]) - a_paper_t[2] * y_paper_nm[n, m]) +
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
        )
      ) for n=1:4
    )
end
