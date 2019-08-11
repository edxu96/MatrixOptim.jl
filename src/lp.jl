# Linear programming in matrix form
# Version: 6.0
# Author: Edward J. Xu, edxu96@outlook.com
# Date: August 11, 2019

"""
        lp(n_x, vec_c, vec_b, mat_a)

Linear Programming in Matrix Form

# Arguments
- vec_c: [column vector] coefficient vector in objective function
- vec_b: [column vector] right-hand-side coefficient vector in constraint
- mat_a: Coefficient Matrix
"""
function lp(n_x, vec_c, vec_b, mat_a)
    model = Model(solver = GLPKSolverLP())
    @variable(model, vec_x[1: n_x] >= 0)
    @objective(model, Min, (transpose(vec_c) * vec_x)[1])
    constraintsForDual = @constraint(model, mat_a * vec_x .>= vec_b)
    solve(model)
    vec_result_u = getdual(constraintsForDual)
    obj = getobjectivevalue(model)
    vec_result_x = getvalue(vec_x)
    return (obj, vec_result_x, vec_result_u)
end
