# Functions for linear programming
# Version: 1.0
# Author: Edward J. Xu, edxu96@outlook.com
# Date: August 11, 2019


"""
Solution for Model
"""
mutable struct Solution
    obj::Float64
    vec_result_x::Array{Float64,2}
    vec_result_u::Array{Float64,2}
end


"""
Model for Mixed Integer Linear Programming
"""
mutable struct ModelMix
    vec_c    # the coefficient vector for linear variables in the objective function
    mat_aCap #
    vec_f    # the coefficient vector for integer variables in the objective function
    mat_bCap
    vec_b
    solution::Union{Solution, Missing}

    function ModelMix(vec_c::Array{Int64,2}, mat_aCap::Array{Int64,2}, vec_b::Array{Int64,2}, vec_f::Array{Int64,2},
        mat_bCap::Array{Int64,2})
        checkColVec(vec_c, "vec_c")
        checkColVec(vec_f, "vec_f")
        checkColVec(vec_b, "vec_b")
        checkMatrixMatch(vec_c, mat_aCap, row, col, "vec_c", "mat_aCap")
        checkMatrixMatch(vec_f, mat_bCap, row, col, "vec_f", "mat_bCap")
        checkMatrixMatch(mat_aCap, mat_bCap, row, row, "mat_aCap", "mat_bCap")
        checkMatrixMatch(mat_aCap, vec_b, row, row, "mat_aCap", "vec_b")
        new(vec_c, mat_aCap, vec_f, mat_bCap, vec_b, missing)
    end
end


"""
Model for Linear Programming
"""
mutable struct ModelLinear
    vec_c    # the coefficient vector for linear variables in the objective function
    mat_aCap #
    vec_b
    solution::Union{Solution, Missing}

    function ModelLinear(vec_c::Array{Int64,2}, mat_aCap::Array{Int64,2}, vec_b::Array{Int64,2})
        checkColVec(vec_c, "vec_c")
        checkColVec(vec_b, "vec_b")
        checkMatrixMatch(vec_c, mat_aCap, row, col, "vec_c", "mat_aCap")
        checkMatrixMatch(mat_aCap, vec_b, row, row, "mat_aCap", "vec_b")
        new(vec_c, mat_aCap, vec_b, missing)
    end
end


"""
    solveLinear(n_x, vec_c, vec_b, mat_aCap)

Linear Programming in Matrix Form

# Arguments
- vec_c: [column vector] coefficient vector in objective function
- vec_b: [column vector] right-hand-side coefficient vector in constraint
- mat_aCap: Coefficient Matrix
"""
function solveLinear(vec_c, vec_b, mat_aCap)
    n_x = length(vec_c)
    model = Model(with_optimizer(GLPK.Optimizer))
    @variable(model, vec_x[1: n_x] >= 0)
    @objective(model, Min, (transpose(vec_c) * vec_x)[1])
    @constraint(model, vec_cons, mat_aCap * vec_x .>= vec_b)
    optimize!(model)
    vec_result_u = dual_vec(vec_cons)
    obj = objective_value(model)
    vec_result_x =  value_vec(vec_x)
    return obj, vec_result_x, vec_result_u
end


function solveMix(n_x, vec_c, vec_b, mat_aCap, vec_f, mat_b)
    model = Model(with_optimizer(GLPK.Optimizer))
    @variable(model, vec_x[1: n_x] >= 0)
    @objective(model, Min, (transpose(vec_c) * vec_x)[1])
    @constraint(model, vec_cons, mat_aCap * vec_x .>= vec_b)
    optimize!(model)
    vec_result_u = dual_vec(vec_cons)
    obj = objective_value(model)
    vec_result_x = value_vec(vec_x)
    return obj, vec_result_x, vec_result_u
end
