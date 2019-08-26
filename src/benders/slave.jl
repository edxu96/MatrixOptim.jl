# Benders Decomposition for MILP with Sub and Ray Problems
# Edward J. Xu, edxu96@outlook.com
# April 25th, 2019

mutable struct ModRay
    expr
    vec_u
    vec_cons

    function ModRay(vec_yBar, n_constraint, vec_b, mat_b, mat_a)
        mod = Model(with_optimizer(GLPK.Optimizer))
        @variable(mod, vec_u[1: n_cons] >= 0)
        @objective(mod, Max, 1)
        @constraint(mod, (transpose(vec_b - mat_b * vec_yBar) * vec_u)[1] == 1)
        @constraint(mod, vec_cons, transpose(mat_a) * vec_u .<= 0)
        new(expr=mod, vec_u=vec_u, vec_cons=vec_cons)
    end
end

struct LogRay
    obj
    vec_uBar
end

function solve_ray!(mod::ModRay)
    optimize!(mod)
    log = LogRay(obj=objective_value(mod), vec_uBar=value_vec(mod))
    return log
end

mutable struct ModSub
    expr
    vec_u
    vec_cons

    function ModSub(vec_yBar, n_constraint, vec_b, mat_b, mat_a, vec_c)
        model = Model(with_optimizer(GLPK.Optimizer))
        @variable(model, vec_u[1: n_cons] >= 0)
        @objective(
            model, Max, (transpose(vec_b - mat_b * vec_yBar) * vec_u)[1]
            )
        @constraint(model, vec_cons, transpose(mat_a) * vec_u .<= vec_c)
        new(expr=mod, vec_u=vec_u, vec_cons=vec_cons)
    end
end

struct LogSub
    bool
    obj
    vec_uBar
    vec_result_x
end

function solve_sub!(mod::ModSub)
    optimize!(mod.expr)

    log = LogSub(
        bool=true, obj=NaN, vec_uBar=value_vec(vec_u),
        vec_result_x=zeros(length(vec_c))
        )
    if Int(primal_status(model)) == 1
        log.vec_result_x = dual_vec(vec_cons)
        log.obj = objective_value(model)
    elseif Int(primal_status(model)) == 4  # Unbounded
        println(
            "    Not solved to optimality because feasible set is unbounded."
            )
        log.bool = false
        log.obj = objective_value(model)
        log.vec_result_x = repeat([NaN], length(vec_c))
    else  # if Int(primal_status(model)) == 3  # Infeasible
        println(
            "    Not solved to optimality because infeasibility. " *
            "Something is wrong. $(Int(primal_status(model)))"
            )
        log.bool = false
        log.vec_result_x = hcat(repeat([NaN], length(vec_c)))
    end
    return log
end
