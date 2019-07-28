# Linear programming in matrix
# Version: 5.1
# Author: Edward J. Xu, edxu96@outlook.com
# Date: April 5th, 2019
# ----------------------------------------------------------------------------------------------------------------------
# using JuMP
# using GLPKMathProgInterface
function lp(n_x, vec_c, vec_b, mat_a)
    # Linear Programming in Matrix Form
    # vec_c: [column vector] coefficient vector in objective function
    # vec_b: [column vector] right-hand-side coefficient vector in constraint
    # mat_a:
    # Edward J. Xu, 190405
    println("-------------------------------------------------------------------------\n",
            "------------------------ 1/2. Begin Optimization ------------------------\n",
            "-------------------------------------------------------------------------\n")
    model = Model(solver = GLPKSolverLP())
    @variable(model, vec_x[1: n_x] >= 0)
    @objective(model, Min, (transpose(vec_c) * vec_x)[1])
    constraintsForDual = @constraint(model, mat_a * vec_x .>= vec_b)
    solve(model)
    vec_result_u = getdual(constraintsForDual)
    obj = getobjectivevalue(model)
    vec_result_x = getvalue(vec_x)
    println("-------------------------------------------------------------------------\n",
            "-------------------------- 2/2. Nominal Ending --------------------------\n",
            "-------------------------------------------------------------------------\n")
    return (obj, vec_result_x, vec_result_u)
end
