# Benders Decomposition
# 1. BendersOptim.milp: for MILP with Sub and Ray Problems
# Version: 5.1
# Author: Edward J. Xu, edxu96@outlook.com
# Date: April 5th, 2019


function solve_master(model_mas, q, vec_y, vec_b, mat_b, vec_uBar, bool_solution_sub::Bool)
    if bool_solution_sub
        @constraint(model_mas, (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= q)
    else  # Add feasible cut Constraints
        @constraint(model_mas, (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= 0)
    end
    @constraint(model_mas, (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= q)

    optimize!(model_mas)
    vec_result_y = value_vec(vec_y)

    return objective_value(model_mas)
end


function solve_sub(vec_yBar, n_constraint, vec_b, mat_b, mat_a, vec_c)
    model = Model(with_optimizer(GLPK.Optimizer))
    @variable(model, vec_u[1: n_constraint] >= 0)
    @objective(model, Max, (transpose(vec_b - mat_b * vec_yBar) * vec_u)[1])
    @constraint(model, vec_cons, transpose(mat_a) * vec_u .<= vec_c)
    st_solution = optimize!(model)
    vec_uBar = value_vec(vec_u)

    # Remember to initialize the returned variables
    bool_solution_sub = true
    vec_result_x = zeros(length(vec_c))
    obj_sub = NaN
    if Int(primal_status(model)) == 1
        vec_result_x = dual_vec(vec_cons)
        obj_sub = objective_value(model)
    elseif Int(primal_status(model)) == 4  # Unbounded
        println("    Not solved to optimality because feasible set is unbounded.")
        bool_solution_sub = false
        obj_sub = objective_value(model)
        vec_result_x = repeat([NaN], length(vec_c))
    else  # if Int(primal_status(model)) == 3  # Infeasible
        println("    Not solved to optimality because infeasibility. Something is wrong. $(Int(primal_status(model)))")
        bool_solution_sub = false
        vec_result_x = hcat(repeat([NaN], length(vec_c)))
    end

    return bool_solution_sub, obj_sub, vec_uBar, vec_result_x
end


function solve_ray(vec_yBar, n_constraint, vec_b, mat_b, mat_a)
    model_ray = Model(with_optimizer(GLPK.Optimizer))
    @variable(model_ray, vec_u[1: n_constraint] >= 0)
    @objective(model_ray, Max, 1)
    @constraint(model_ray, (transpose(vec_b - mat_b * vec_yBar) * vec_u)[1] == 1)
    @constraint(model_ray, transpose(mat_a) * vec_u .<= 0)
    optimize!(model_ray)

    vec_uBar = value_vec(vec_u)
    obj_ray = objective_value(model_ray)
    return (obj_ray, vec_uBar)
end


function check_whe_continue(boundUp, boundLow, epsilon, result_q, obj_sub, timesIteration, timesIterationMax)
    whe_continue = true
    if (boundUp - boundLow <= epsilon) & (boundUp - boundLow >= - epsilon)
        if (result_q - obj_sub <= epsilon) & (result_q - obj_sub >= - epsilon)
            whe_continue = false
        end
    end

    return (timesIteration <= timesIterationMax) && whe_continue
end


"""
Generic Benders Decomposition for Mixed Integer Linear Programming
"""
function solveBendersMilp(
        n_x, n_y, vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_a, mat_b, epsilon=1e-6, timesIterationMax=100
    )
    println("################################################################################")
    # Define Master problem
    n_constraint = length(mat_a[:, 1])
    model_mas = Model(with_optimizer(GLPK.Optimizer))
    @variable(model_mas, q)
    @variable(model_mas, vec_y[1: n_y], Int)
    @objective(model_mas, Min, (transpose(vec_f) * vec_y)[1] + q)
    @constraint(model_mas, vec_y[1: n_y] .<= vec_max_y)
    @constraint(model_mas, vec_y[1: n_y] .>= vec_min_y)

    let
        boundUp = Inf
        boundLow = - Inf
        # initial value of master variables
        # vec_uBar = zeros(n_constraint, 1)
        vec_yBar = zeros(n_y, 1)
        vec_result_x = zeros(n_x, 1)
        dict_obj_mas = Dict()
        dict_q = Dict()
        dict_obj_sub = Dict()
        dict_obj_ray = Dict()
        dict_boundUp = Dict()
        dict_boundLow = Dict()
        obj_sub = 0
        result_q = 0
        timesIteration = 1
        # Must make sure "result_q == obj_sub" in the final iteration
        # while ((boundUp - boundLow > epsilon) && (timesIteration <= timesIterationMax))  !!!
        while check_whe_continue(boundUp, boundLow, epsilon, result_q, obj_sub, timesIteration, timesIterationMax)
            bool_solution_sub, obj_sub, vec_uBar, vec_result_x = solve_sub(vec_yBar, n_constraint, vec_b, mat_b,
                mat_a, vec_c)
            if bool_solution_sub
                println("obj_sub = $(obj_sub) ;")
                boundUp = min(boundUp, obj_sub + (transpose(vec_f) * vec_yBar)[1])
            else
                (obj_ray, vec_uBar) = solve_ray(vec_yBar, n_constraint, vec_b, mat_b, mat_a)
            end
            obj_mas = solve_master(model_mas, q, vec_y, vec_b, mat_b, vec_uBar, bool_solution_sub)
            vec_yBar = value_vec(vec_y)
            boundLow = max(boundLow, obj_mas)
            dict_boundUp[timesIteration] = boundUp
            dict_boundLow[timesIteration] = boundLow
            if bool_solution_sub
                dict_obj_mas[timesIteration] = obj_mas
                dict_obj_sub[timesIteration] = obj_sub
                result_q = value_vec(q)
                dict_q[timesIteration] = result_q
                println("Result in $(timesIteration)-th Iteration with Sub \n    ",
                        "UB: $(round(boundUp, digits = 5)) ; ",
                        "LB: $(round(boundLow, digits = 5)) ; ",
                        "obj_mas: $(round(obj_mas, digits = 5)) ; ",
                        "q: $result_q ; obj_sub: $(round(obj_sub, digits = 5)) ;")
            else
                dict_obj_mas[timesIteration] = obj_mas
                dict_obj_ray[timesIteration] = obj_ray
                result_q = value_vec(q)
                dict_q[timesIteration] = result_q
                println("Result in $(timesIteration)-th Iteration with Ray \n    ",
                        "UB: $(round(boundUp, digits = 5)) ; ",
                        "LB: $(round(boundLow, digits = 5)) ; ",
                        "obj_mas: $(round(obj_mas, digits = 5)) ; ",
                        "q: $result_q ; obj_ray: $(round(obj_ray, digits = 5)) ;")
            end
            timesIteration += 1
        end
        println("Master Problem")
        println("    obj_mas: $(objective_value(model_mas))")
        # println(model_mas)
        println("Final Result")
        println("    boundUp: $(round(boundUp, digits = 5)), boundLow: $(round(boundLow, digits = 5)), ",
                "difference: $(round(boundUp - boundLow, digits = 5))")
        println("    vec_x: $vec_result_x")
        vec_result_y = value_vec(vec_y)
        result_q = value_vec(q)
        println("    vec_y: $vec_result_y")
        println("    result_q: $result_q")
        println("Iteration Result")
        # Initialize
        seq_timesIteration = collect(1: (timesIteration - 1))
        vec_boundUp = zeros(timesIteration - 1)
        vec_boundLow = zeros(timesIteration - 1)
        vec_obj_subRay = zeros(timesIteration - 1)
        vec_obj_mas = zeros(timesIteration - 1)
        vec_q = zeros(timesIteration - 1)
        vec_type = repeat(["ray"], (timesIteration - 1))
        #
        for i = 1: (timesIteration - 1)
            vec_obj_mas[i] = round(dict_obj_mas[i], digits = 5)
            vec_boundUp[i] = round(dict_boundUp[i], digits = 5)
            vec_boundLow[i] = round(dict_boundLow[i], digits = 5)
            vec_q[i] = round(dict_q[i], digits = 5)
            if haskey(dict_obj_sub, i)
                vec_type[i] = "sub"
                vec_obj_subRay[i] = round(dict_obj_sub[i], digits = 5)
            else
                vec_obj_subRay[i] = round(dict_obj_ray[i], digits = 5)
            end
        end
        table_iterationResult = hcat(seq_timesIteration, vec_boundUp, vec_boundLow,
                                     vec_obj_mas, vec_q, vec_type, vec_obj_subRay)
        pretty_table(table_iterationResult,
                     ["Seq", "boundUp", "boundLow", "obj_mas", "q", "sub/ray", "obj_sub/ray"],
                     compact; alignment=:l)
    end
    println("################################################################################\n")
end
