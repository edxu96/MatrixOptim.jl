# Functions to Test `getModel` and `solveModel!`
# Edward J. Xu, edxu96@outlook.com
# Aug 11, 2019


function test_milp()
    vec_c = hcat([3; 5])
    mat_aCap = [1 0; 0 2; 3 2]
    vec_b = hcat([4; 12; 18])

    model = getModel(vec_c, mat_aCap, vec_b)
    solveModel!(model)

    return model.solution.obj
end
