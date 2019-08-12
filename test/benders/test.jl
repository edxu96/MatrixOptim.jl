# Functions to Test `solveBendersMilp`
# Edward J. Xu, edxu96@outlook.com
# Aug 11, 2019


"Test 1: mat_a and mat_b being column vector"
function do_test_1()
    n_x = 1
    n_y = 1
    vec_min_y = hcat([0])
    vec_max_y = hcat([10])
    vec_c = hcat([5])
    vec_f = hcat([-3])
    vec_b = hcat([4; 0; -13])
    mat_a = hcat([1; 2; 1])
    mat_b = hcat([2; -1; -3])
    solveBendersMilp(n_x, n_y, vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_a, mat_b)
end


"Test 2: mat_a and mat_b being matrix"
function do_test_2()
    n_x_2 = 2
    n_y_2 = 2
    vec_min_y_2 = hcat([0; 0])
    vec_max_y_2 = hcat([10; 10])
    vec_c_2 = hcat([5; 3])
    vec_f_2 = hcat([-3; 1])
    vec_b_2 = hcat([4; 0; -13])
    mat_a_2 = [1 3; 2 1; 1 -5]
    mat_b_2 = [2 -4; -1 2; -3 1]
    solveBendersMilp(n_x, n_y, vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_a, mat_b)
end


"Test 3: sub and ray problem"
function do_test_3()
    n_x_3 = 2
    n_y_3 = 2
    vec_min_y_3 = hcat([0; 0])
    vec_max_y_3 = hcat([2; 2])
    vec_c_3 = hcat([2; 6])
    vec_f_3 = hcat([2; 3])
    vec_b_3 = hcat([5; 4])
    mat_a_3 = [-1 2; 1 -3]
    mat_b_3 = [3 -1; 2 2]
    solveBendersMilp(n_x, n_y, vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_a, mat_b)
end


function test_benders()
    do_test_1()
    do_test_2()
    do_test_3()
    return 0
end
