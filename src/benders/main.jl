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


function set_mod_mas(n_y, vec_min_y, vec_max_y)
    mod_mas = Model(with_optimizer(GLPK.Optimizer))
    @variable(mod_mas, q)
    @variable(mod_mas, vec_y[1: n_y], Int)
    @objective(mod_mas, Min, (transpose(vec_f) * vec_y)[1] + q)
    @constraint(mod_mas, vec_y[1: n_y] .<= vec_max_y)
    @constraint(mod_mas, vec_y[1: n_y] .>= vec_min_y)
    return mod_mas
end

include("./milp.jl")
include("./l-shaped.jl")
