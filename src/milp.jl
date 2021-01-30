## Linear programming in MatrixOptim.jl


"Solution for a linear programming problem."
struct SolutionLinear
    obj::Float64
    x::Array{Float64,2}
end


"Solution for a mixed integer programming problem."
struct SolutionMix
    obj::Float64
    x::Array{Float64,2}
    y::Array{Float64,2}
end


@doc raw"""
Constructor for mixed integer linear programming (MILP) problems.

Any MILP can be written in the following standard format:
`` \begin{aligned}
\min \quad & \mathbf{c}^T \mathbf{x} + \mathbf{f}^T \mathbf{y} \\
\text{s.t.} \quad & \mathbf{A} \mathbf{x} + \mathbf{D} \mathbf{y} \geq \mathbf{b} \\ 
& \mathbf{y} \in Y \\
& \mathbf{x} \geq 0
\end{aligned} ``

# Arguments

- `c`: coefficient vector for continuous variables in objective function.
- `a`: coefficient matrix for continuous variables in constraints.
- `b`: coefficient matrix in constraints.
- `f`: coefficient vector for integer variables in objective function.
- `d`: coefficient matrix for integer variables in constraints.
"""
struct ModelMilp
    c::Array{Float64,2}
    a::Array{Float64,2}
    b::Array{Float64,2}
    f::Union{Array{Float64,2}, Missing}
    d::Union{Array{Float64,2}, Missing}
    solution::Union{SolutionMix, Missing}

    function ModelMilp(c, a, b, f=missing, d=missing)
        check_col_vec(c, "c")
        check_col_vec(f, "f")
        check_col_vec(b, "b")
        new(c, a, f, d, b, missing)
    end
end


"Solve the model."
function solve!(model::Union{ModelLinear, ModelMix})::Union{SolutionLinear, SolutionMix}
    if isa(model, ModLinear)
        obj, x, u = solve_lp(model.c, model.b, model.a)
    else
        obj, x, u = solve_milp(model.c, model.b, model.a, model.f, model.b)
    end
    model.solution = Solution(obj, hcat(x), hcat(u))

    return solution
end


"""
    solve_lp(n_x, vec_c, vec_b, mat_aCap)

Solve a linear programming problem in its matrix form.

# Arguments
- vec_c: [column vector] coefficient vector in objective function
- vec_b: [column vector] right-hand-side coefficient vector in constraint
- mat_aCap: Coefficient Matrix
"""
function solve_lp(vec_c, vec_b, mat_aCap)
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


function solve_milp(n_x, vec_c, vec_b, mat_aCap, vec_f, mat_b)
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
function append_cons!(
        mod::ModelMix,
        vec_a_new::Array{Int64,2},
        vec_b_new::Array{Int64,2},
        b_new::Float64
    )
    check_col_vec(vec_a_new, "vec_a_new")
    check_col_vec(vec_b_new, "vec_b_new")
    mod.mat_aa = vcat(mod.mat_aa, vec_a_new')
    mod.mat_bb = vcat(mod.mat_bb, vec_b_new')
    mod.vec_b = vcat(mode.vec_b, b_new)
end
