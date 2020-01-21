## Linear programming in MatrixOptim.jl
## Edward J. Xu, edxu96@outlook.com
## August 11, 2019

include("./func.jl")


"Get the mod for optimization"
function get_mod(vec_c::Array{Int64,2}, mat_aa::Array{Int64,2}, vec_b::Array{Int64,2},
    vec_f::Union{Missing, Array{Int64,2}}=missing, mat_bb::Union{Missing, Array{Int64,2}}=missing)
    if (vec_f === missing) & (mat_bb === missing)
        mod = ModLinear(vec_c, mat_aa, vec_b)
    elseif isa(vec_f, Array{Int64,2}) & isa(mat_bb, Array{Int64,2})
        mod = ModMix(vec_c, mat_aa, vec_f, mat_bb, vec_b)
    else
        throw("Input `vec_f` or `mat_bb` do not match.")
    end
    return mod
end


"Solve the model."
function solve_mod!(mod::Union{ModLinear, ModMix})
    if isa(mod, ModLinear)
        obj, vec_result_x, vec_result_u = solve_lp(mod.vec_c, mod.vec_b,
            mod.mat_aa)
    else
        obj, vec_result_x, vec_result_u = solve_milp(mod.vec_c, mod.vec_b, 
            mod.mat_aa, mod.vec_f, mod.mat_b)
    end
    mod.solution = Solution(obj, hcat(vec_result_x), hcat(vec_result_u))
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


"Append a constraint"
function append_cons!(mod::ModMix, vec_a_new::Array{Int64,2}, vec_b_new::Array{Int64,2}, b_new::Float64)
    checkColVec(vec_a_new, "vec_a_new")
    checkColVec(vec_b_new, "vec_b_new")
    mod.mat_aa = vcat(mod.mat_aa, vec_a_new')
    mod.mat_bb = vcat(mod.mat_bb, vec_b_new')
    mod.vec_b = vcat(mode.vec_b, b_new)
end
