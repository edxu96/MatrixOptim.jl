# Test Benders Algorithm for Mixed Integer Linear Programming
# Edward J. Xu, edxu96@outlook.com
# April 5th, 2019
# ---------------------------------------------------------------------------
push!(LOAD_PATH, "$(homedir())/Desktop/Benders Decomposition, MILP")
cd("$(homedir())/Desktop/Benders Decomposition, MILP")
using Benders
# ---------------------------------------------------------------------------
# Test Example 1: mat_a and mat_b being column vector
n_x = 1
n_y = 1
vec_min_y = hcat([0])
vec_max_y = hcat([10])
vec_c = hcat([5])
vec_f = hcat([-3])
vec_b = hcat([4; 0; -13])
mat_a = hcat([1; 2; 1])
mat_b = hcat([2; -1; -3])
Benders.milp(n_x = n_x,
             n_y = n_y,
             vec_min_y = vec_min_y,
             vec_max_y = vec_max_y,
             vec_c = vec_c,
             vec_f = vec_f,
             vec_b = vec_b,
             mat_a = mat_a,
             mat_b = mat_b,
             epsilon = 0,
             timesIterationMax = 5)
# ---------------------------------------------------------------------------
# Test Example 2: mat_a and mat_b being matrix
n_x_2 = 2
n_y_2 = 2
vec_min_y_2 = hcat([0; 0])
vec_max_y_2 = hcat([10; 10])
vec_c_2 = hcat([5; 3])
vec_f_2 = hcat([-3; 1])
vec_b_2 = hcat([4; 0; -13])
mat_a_2 = [1 3; 2 1; 1 -5]
mat_b_2 = [2 -4; -1 2; -3 1]
Benders.milp(n_x = n_x_2,
             n_y = n_y_2,
             vec_min_y = vec_min_y_2,
             vec_max_y = vec_max_y_2,
             vec_c = vec_c_2,
             vec_f = vec_f_2,
             vec_b = vec_b_2,
             mat_a = mat_a_2,
             mat_b = mat_b_2,
             epsilon = 0.000001,
             timesIterationMax = 10)
# ---------------------------------------------------------------------------
# Test Example 3: sub and ray problem
n_x_3 = 2
n_y_3 = 2
vec_min_y_3 = hcat([0; 0])
vec_max_y_3 = hcat([2; 2])
vec_c_3 = hcat([2; 6])
vec_f_3 = hcat([2; 3])
vec_b_3 = hcat([5; 4])
mat_a_3 = [-1 2; 1 -3]
mat_b_3 = [3 -1; 2 2]
Benders.milp(n_x = n_x_3,
             n_y = n_y_3,
             vec_min_y = vec_min_y_3,
             vec_max_y = vec_max_y_3,
             vec_c = vec_c_3,
             vec_f = vec_f_3,
             vec_b = vec_b_3,
             mat_a = mat_a_3,
             mat_b = mat_b_3,
             epsilon = 0.000001,
             timesIterationMax = 10)
