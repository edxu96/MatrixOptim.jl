# Benders Decomposition
# 1. BendersOptim.milp: for MILP with Sub and Ray Problems
# 2. BendersOptim.lshaped: for stochastic programming
# 0. Linear programming in matrix
# Version: 5.1
# Author: Edward J. Xu, edxu96@outlook.com
# Date: April 5th, 2019


function check_whe_continue(boundUp, boundLow, epsilon, result_q, obj_sub,
        timesIteration, timesIterationMax)
    whe_continue = true
    if (boundUp - boundLow <= epsilon) & (boundUp - boundLow >= - epsilon)
        if (result_q - obj_sub <= epsilon) & (result_q - obj_sub >= - epsilon)
            whe_continue = false
        end
    end

    return (timesIteration <= timesIterationMax) && whe_continue
end


mutable struct ModMasHead
    mod
    obj

    ref

    function ModMasHead(n_y, vec_min_y, vec_max_y)
        mod_mas = Model(with_optimizer(GLPK.Optimizer))
        @variable(mod_mas, q)
        @variable(mod_mas, vec_y[1: n_y], Int)
        @objective(mod_mas, Min, (transpose(vec_f) * vec_y)[1] + q)
        @constraint(mod_mas, vec_y[1: n_y] .<= vec_max_y)
        @constraint(mod_mas, vec_y[1: n_y] .>= vec_min_y)
        new(mod, vec_y, [])
    end
end


struct SoluMas()
    vec_yBar

    ref
end


function solve_mod_mas!(
        mod_mas::ModMas, q, vec_y, vec_b, mat_b
        )
    if bool_solution_sub
        @constraint(mod_mas.mod, (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= q)
    else  # Add feasible cut Constraints
        @constraint(mod_mas.mod, (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= 0)
    end
    @constraint(mod_mas.mod, (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= q)

    optimize!(mod_mas.mod)
    vec_result_y = value_vec(vec_y)
    push!(mod_mas.obj, objective_value(mod_mas))
end


include("./milp.jl")
include("./l-shaped.jl")
