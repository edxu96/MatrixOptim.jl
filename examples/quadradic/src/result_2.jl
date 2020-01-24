## Metsa-Oy Forest Products Supply Chain
## Edward J. Xu <edxu96@outlook.com>
## Jan 24th, 2020


function cal_dis_profit_2(h_mt, y_mi, y_mj, y_paper_m, z_mik, z_mjk, z_paper_mk,
    alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j,
    c_j, r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik,
    gamma_jk, delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i,
    omega_j, omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood,
    o_j, o_paper, i_t1, i_t2, j_t2, x_saw_m, x_plywood_m, x_mj, x_paper_m; m)

  dis_profit =
    sigma^(m-1) * (
      -sum(alpha_t[t] * h_mt[m, t] + beta_t[t] * h_mt[m, t]^2
        for t = 1:6) +
      -sum(c_i[i] * y_mi[m, i] for i=1:5) +
      -sum(c_j[j] * y_mj[m, j] for j=1:2) -
      c_paper * y_paper_m[m] +
      sum(alpha_t[t] * (h_mt[m, t] - sum(a_i[i] * y_mi[m, i] for i in
        i_t1[t])) for t=1:3) +
      sum(alpha_t[t] * (h_mt[m, t] + sum(b_i[i] * y_mi[m, i] for i in
        i_t2[t-3]) - sum(a_j[j] * y_mj[m, j] for j in j_t2[t-3]) -
        a_paper_t[t-3] * y_paper_m[m]) for t in [4, 6]) +
      ## when t = 5
      alpha_t[5] * (h_mt[m, 5] + sum(b_i[i] * y_mi[m, i] for i in
        i_t2[2]) - a_paper_t[2] * y_paper_m[m]) +
      p_fuel * sum(e_i[i] * y_mi[m, i] for i=1:5) +
      sum(omega_i[i]^(m-1) * gamma_ik[i, k] * z_mik[m, i, k] -
        omega_i[i]^(m-1) * delta_ik[i, k] * z_mik[m, i, k]^2
        for i=1:5, k=1:4) +
      sum(omega_j[j]^(m-1) * gamma_jk[j, k] * z_mjk[m, j, k] -
        omega_j[j]^(m-1) * delta_jk[j, k] * z_mjk[m, j, k]^2
        for j=1:2, k=1:4) +
      sum(omega_paper^(m-1) * gamma_paper_k[k] * z_paper_mk[m, k] -
        omega_paper^(m-1) * delta_paper_k[k] * z_paper_mk[m, k]^2
        for k=1:4)
      )

  if m <= 2
    m += 1
    dis_profit += - sigma^(m-2) * (o_saw * (x_saw_m[m] - x_saw_m[m - 1]) +
      o_plywood * (x_plywood_m[m] - x_plywood_m[m-1]) +
      sum(o_j[j] * (x_mj[m, j] - x_mj[m-1, j]) for j=1:2) +
      o_paper * (x_paper_m[m] - x_paper_m[m-1]))
  end

  println("dis_profit = $(round(dis_profit; digits=4)) ;")
end


function print_result_2(result_h_mt, result_y_mi, result_y_mj, result_y_paper_m,
    result_z_mik, result_z_mjk, result_z_paper_mk, alpha_t, beta_t, a_i, b_i,
    e_i, c_i, r_saw, r_plywood, a_j, c_j, r_j, a_paper_t, b_paper_j, c_paper,
    r_paper, gamma_ik, delta_ik, gamma_jk, delta_jk, gamma_paper_k,
    delta_paper_k, p_fuel, sigma, omega_i, omega_j, omega_paper, nu_saw,
    nu_plywood, nu_j, nu_paper, o_saw, o_plywood, o_j, o_paper, i_t1, i_t2,
    j_t2, result_x_saw_m, result_x_plywood_m, result_x_mj, result_x_paper_m)

  h_mt = result_h_mt
  y_mi = result_y_mi
  y_mj = result_y_mj
  y_paper_m = result_y_paper_m
  z_mik = result_z_mik
  z_mjk = result_z_mjk
  z_paper_mk = result_z_paper_mk
  x_saw_m = result_x_saw_m
  x_plywood_m = result_x_plywood_m
  x_mj = result_x_mj
  x_paper_m = result_x_paper_m

  ## Sales distribution
  for m=1:3
    println("m = $m ;")

    for i=1:5
      println(round.(result_z_mik[m, i, :] / sum(result_z_mik[m, i, :]) * 100;
        digits=2))
    end

    for j=1:2
      println(round.(result_z_mjk[m, j, :] / sum(result_z_mjk[m, j, :]) * 100;
        digits=2))
    end

    println(round.(result_z_paper_mk[m, :] / sum(result_z_paper_mk[m, :]) * 100;
      digits=2))

    ## discounted profits
    cal_dis_profit_2(h_mt, y_mi, y_mj, y_paper_m, z_mik, z_mjk, z_paper_mk,
      alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j, c_j, r_j,
      a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik, gamma_jk,
      delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i, omega_j,
      omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood, o_j,
      o_paper, i_t1, i_t2, j_t2, x_saw_m, x_plywood_m, x_mj, x_paper_m, m=m)

    ## capacities
    println(round.(x_saw_m[m]; digits=2))
    println(round.(x_plywood_m[m]; digits=2))
    println(round.(x_mj[m, :]; digits=2))
    println(round.(x_paper_m[m]; digits=2))
  end
end
