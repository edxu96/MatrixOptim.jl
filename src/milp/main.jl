# Linear programming in matrix form
# Version: 6.0
# Author: Edward J. Xu, edxu96@outlook.com
# Date: August 11, 2019

include("./func.jl")


"""
Get the model for optimization
"""
function getModel(vec_c::Array{Int64,2}, mat_aCap::Array{Int64,2}, vec_b::Array{Int64,2},
    vec_f::Union{Missing, Array{Int64,2}}=missing, mat_bCap::Union{Missing, Array{Int64,2}}=missing)
    if (vec_f === missing) & (mat_bCap === missing)
        model = ModelLinear(vec_c, mat_aCap, vec_b)
    elseif isa(vec_f, Array{Int64,2}) & isa(mat_bCap, Array{Int64,2})
        model = ModelMix(vec_c, mat_aCap, vec_f, mat_bCap, vec_b)
    else
        throw("Input `vec_f` or `mat_bCap` do not match.")
    end
    return model
end


function solveModel!(model)
    if isa(model, ModelLinear)
        obj, vec_result_x, vec_result_u = solveLinear(model.vec_c, model.vec_b, model.mat_aCap)
    elseif isa(model, ModelMix)
        obj, vec_result_x, vec_result_u = solveMix(model.vec_c, model.vec_b, model.mat_aCap, model.vec_f, model.mat_b)
    else
        throw("Wrong input model.")
    end
    model.solution = Solution(obj, hcat(vec_result_x), hcat(vec_result_u))
end


"""
Append a constraint to ModelMix
"""
function appendConstraint!(model::ModelMix, vec_a_new::Array{Int64,2}, vec_b_new::Array{Int64,2}, b_new::Float64)
    checkColVec(vec_a_new, "vec_a_new")
    checkColVec(vec_b_new, "vec_b_new")
    model.mat_aCap = vcat(model.mat_aCap, vec_a_new')
    model.mat_bCap = vcat(model.mat_bCap, vec_b_new')
    model.vec_b = vcat(mode.vec_b, b_new)
end
