

"Get parameters for model 3."
function get_para()
  alpha_t = [190, 150, 120, 180, 150, 150]
  beta_t = [1, 0.5, 3, 0.2, 0.3, 0.2]
  a_i = [2, 2, 2, 2.8, 2.8]
  b_i = [0.8, 0.8, 0.8, 1.6, 1.6]
  e_i = [0.2, 0.2, 0.2, 0.2, 0.2]
  c_i = [550, 500, 450, 2500, 2600]
  r_saw = 200
  r_plywood = 90
  a_j = [4.8, 4.2]
  c_j = [820, 800]
  r_j = [220, 180]
  a_paper_t = [0, 1, 0]
  b_paper_j = [0.2, 0.2]
  c_paper = 1700
  r_paper = 80
  gamma_ik = [
    1600 1300 1400 1500;
    1400 1200 1300 1400;
    1300 1400 1500 1600;
    4400 3800 3600 3500;
    4300 4100 3900 3800
    ]
  delta_ik = [
    4 5 12 15;
    2 10 12 15;
    14 20 24 25;
    4 10 12 18;
    4 7 12 15
    ]
  gamma_jk = [
    2300 2500 2300 2600;
    2500 2800 2300 2500
    ]
  delta_jk = [
    1 4 5 6;
    3 2 6 7
    ]
  gamma_paper_k = [4500, 4700, 4300, 4800]
  delta_paper_k = [7, 10, 12, 15]
  p_fuel = 40

  i_t1 = [[1], [2, 4], [3, 5]]
  i_t2 = [[1], [2, 4], [3, 5]]
  j_t2 = [[1], [], [2]]

  ## Extra parameters in model 2
  sigma = 0.95
  omega_i = [1.010, 1.008, 1.015, 1.015, 1.020]
  omega_j = [1.025, 1.030]
  omega_paper = 1.035
  nu_saw = 1.5
  nu_plywood = 1.5
  nu_j = [2, 2]
  nu_paper = 2
  o_saw = 100
  o_plywood = 300
  o_j = [500, 500]
  o_paper = 700

  ## Extra parameters in model 3
  pi_n = [0.5, 0.5, 0.5, 0.5]
  rho_nm = [
    1 1.05 1.07;
    1 1.05 0.95;
    1 0.95 1.05;
    1 0.95 0.93
    ]

  return alpha_t, beta_t, a_i, b_i, e_i, c_i, r_saw, r_plywood, a_j, c_j,
    r_j, a_paper_t, b_paper_j, c_paper, r_paper, gamma_ik, delta_ik, gamma_jk,
    delta_jk, gamma_paper_k, delta_paper_k, p_fuel, sigma, omega_i, omega_j,
    omega_paper, nu_saw, nu_plywood, nu_j, nu_paper, o_saw, o_plywood, o_j,
    o_paper, i_t1, i_t2, j_t2, pi_n, rho_nm
end
