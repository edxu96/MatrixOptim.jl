# Test `getModel` and `solveModel!`


function test_milp()
    c = hcat([3; 5])
    a = [1 0; 0 2; 3 2]
    b = hcat([4; 12; 18])

    model = ModelMilp(vec_c, a, b)
    solve!(model)

    return model.solution.obj
end


@test test_milp() == 42
