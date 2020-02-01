## Metsa-Oy Forest Products Supply Chain
## Edward J. Xu <edxu96@outlook.com>
## Feb 1st, 2020


function optim_1(alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j, c_j,
  r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik, gamma_jk,
  delta_jk, gamma_paper_k, delta_paper_k, p_fuel)

  mod = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0))

  @variable(mod, h_t[1:6]>=0, integer=true)
  @variable(mod, y_i[1:5]>=0)
  @variable(mod, y_j[1:2]>=0)
  @variable(mod, y_paper>=0)
  @variable(mod, z_ik[1:5, 1:4]>=0)
  @variable(mod, z_jk[1:2, 1:4]>=0)
  @variable(mod, z_paper_k[1:4]>=0)

  i_t1 = [[1], [2, 4], [3, 5]]
  i_t2 = [[1], [2, 4], [3, 5]]
  j_t2 = [[1], [], [2]]

  @objective(mod, Max,
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
      for k=1:4)
    )

  @constraint(mod, vec_cons_1[t=1:3],
    h_t[t] >= sum(a_i[i] * y_i[i] for i in i_t1[t]))
  @constraint(mod, vec_cons_2[t=4:6],
    h_t[t] + sum(b_i[i] * y_i[i] for i in i_t2[t-3]) >=
    sum(a_j[j] * y_j[j] for j in j_t2[t-3]) + a_paper_t[t-3] * y_paper)
  @constraint(mod, vec_cons_3[j=1:2],
    y_j[j] >= b_paper_j[j] * y_paper)
  @constraint(mod, vec_cons_4[i=1:5],
    y_i[i] >= sum(z_ik[i, k] for k=1:4))
  @constraint(mod, vec_cons_5[j=1:2],
    y_j[j] - b_paper_j[j] * y_paper >= sum(z_jk[j, k] for k=1:4))
  @constraint(mod, y_paper >= sum(z_paper_k[k] for k=1:4))
  @constraint(mod, sum(y_i[i] for i=1:3) <= r_saw)
  @constraint(mod, sum(y_i[i] for i=4:5) <= r_plywood)
  @constraint(mod, vec_cons_6[j=1:2], y_j[j] <= r_j[j])
  @constraint(mod, y_paper <= r_paper)

  optimize!(mod)

  result_h_t = value_vec(h_t)
  result_y_i = value_vec(y_i)
  result_y_j = value_vec(y_j)
  result_y_paper = value(y_paper)
  result_z_ik = value_mat(z_ik)
  result_z_jk = value_mat(z_jk)
  result_z_paper_k = value_vec(z_paper_k)
  result_obj = objective_value(mod)

  println(result_h_t)
  println(result_y_i)
  println(result_y_j)
  println(result_y_paper)
  println(result_z_ik)
  println(result_z_jk)
  println(result_z_paper_k)
  println(result_obj)

  # return result_h_t, result_y_i, result_y_j, result_y_paper, result_z_ik,
  #   result_z_jk, result_z_paper_k, result_obj
end
