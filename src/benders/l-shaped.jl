# L-Shaped Benders Decomposition for Stochastic Programming
# Author: Edward J. Xu, edxu96@outlook.com
# Date: August 11, 2019

"""
L-Shaped Benders Decomposition for Stochastic Programming without Integer Variables in Second Stage
"""
function lshaped(; n_x, n_y, vec_min_y, vec_max_y, vec_f,
        vec_pi, mat_c, mat_h, mat3_t, mat3_w, epsilon, timesIterationMax)
    # vec_pi
    # mat_c
    # mat_h
    # mat3_t
    # mat3_w
    println("-------------------------------------------------------------------------\n",
            "------------------------ 1/4. Begin Optimization ------------------------\n",
            "-------------------------------------------------------------------------\n")
    # Define Master problem
    n_constraint = length(mat3_w[1, :, 1])
    num_s = length(mat3_t[:, 1, 1])
    model_mas = Model(with_optimizer(GLPK.Optimizer))
    @variable(model_mas, q)
    @variable(model_mas, vec_y[1: n_y], Int)
    @objective(model_mas, Min, (transpose(vec_f) * vec_y + q)[1])
    @constraint(model_mas, vec_y[1: n_y] .<= vec_max_y)
    @constraint(model_mas, vec_y[1: n_y] .>= vec_min_y)


    function solve_master(mat_e1, e2, opt_cut::Bool)
        if opt_cut
            @constraint(model_mas, (mat_e1 * vec_y)[1] >= - q + e2)
        else  # Add feasible cut Constraints
            @constraint(model_mas, (mat_e1 * vec_y)[1] >= e2)
        end
        @constraint(model_mas, (mat_e1 * vec_y)[1] >= - q + e2)
        optimize!(model_mas)
        vec_result_y = value(vec_y)
        return objective_value(model_mas)
    end


    function solve_sub(vec_uBar, vec_yBar, n_constraint, vec_h , mat_t, mat_w, vec_c)
        model_sub = Model(with_optimizer(GLPK.Optimizer))
        @variable(model_sub, vec_u[1: n_constraint] >= 0)
        @objective(model_sub, Max, (transpose(vec_h - mat_t * vec_yBar) * vec_u)[1])
        constraintsForDual = @constraint(model_sub, transpose(mat_w) * vec_u .<= vec_c)
        solution_sub = optimize!(model_sub)
        print("------------------------------ Sub Problem ------------------------------\n")  # , model_sub)
        vec_uBar = value(vec_u)
        if solution_sub == :Optimal
            vec_result_x = zeros(length(vec_c))
            vec_result_x = dual(constraintsForDual)
            return (true, objective_value(model_sub), vec_uBar, vec_result_x)
        end
        if solution_sub == :Unbounded
            print("Not solved to optimality because feasible set is unbounded.\n")
            return (false, objective_value(model_sub), vec_uBar, repeat([NaN], length(vec_c)))
        end
        if solution_sub == :Infeasible
            print("Not solved to optimality because infeasibility. Something is wrong.\n")
            return (false, NaN, hcat(vec_uBar), hcat(repeat([NaN], length(vec_c))))
        end
    end


    function solve_ray(vec_uBar, vec_yBar, n_constraint, vec_h, mat_t, mat_w)
        model_ray = Model(with_optimizer(GLPK.Optimizer))
        @variable(model_ray, vec_u[1: n_constraint] >= 0)
        @objective(model_ray, Max, 1)
        @constraint(model_ray, (transpose(vec_h - mat_t * vec_yBar) * vec_u)[1] == 1)
        @constraint(model_ray, transpose(mat_w) * vec_u .<= 0)
        optimize!(model_ray)
        print("------------------------------ Ray Problem ------------------------------\n")  # , model_ray)
        vec_uBar = value(vec_u)
        obj_ray = objective_value(model_ray)
        return (obj_ray, vec_uBar)
    end


    # Begin Calculation --------------------------------------------------------------------------------------------
    let
        boundUp = Inf
        boundLow = - Inf
        epsilon = 0
        # initial value of master variables
        mat_uBar = zeros(num_s, n_constraint, 1)
        vec_yBar = zeros(n_y, 1)
        vec_result_x = zeros(num_s, Int8(n_x / num_s), 1)
        dict_obj_mas = Dict()
        dict_q = Dict()
        dict_obj_sub = Dict()
        dict_obj_ray = Dict()
        dict_boundUp = Dict()
        dict_boundLow = Dict()
        obj_sub = 0
        vec_obj_sub = zeros(num_s)
        timesIteration = 1
        # Must make sure "result_q == obj_sub" in the final iteration
        # while ((boundUp - boundLow > epsilon) && (timesIteration <= timesIterationMax))  !!!
        while ((!((boundUp - boundLow <= epsilon) && ((result_q == obj_sub)))) &&
            (timesIteration <= timesIterationMax))
            # 1. Solve sub/ray problem for each scenario
            vec_bool_solutionSubModel = trues(num_s)
            for s = 1: num_s
                (vec_bool_solutionSubModel[s], vec_obj_sub[s], mat_uBar[s, :, :], vec_result_x[s, :, :]) = solve_sub(
                    mat_uBar[s, :, :], vec_yBar, n_constraint,
                    mat_h[s, :, :], mat3_t[s, :, :], mat3_w[s, :, :], mat_c[s, :, :])
                if !(vec_bool_solutionSubModel[s])
                    (vec_obj_sub[s], mat_uBar[s, :, :]) = solve_ray(
                        mat_uBar[s, :, :], vec_yBar, n_constraint, mat_h[s, :, :], mat3_t[s, :, :], mat3_w[s, :, :]
                        )
                end
            end
            obj_sub = (transpose(vec_pi) * vec_obj_sub)[1]
            boundUp = min(boundUp, obj_sub + (transpose(vec_f) * vec_yBar)[1])
            # 2. Add optimal cut to master problem
            mat_e1 = sum(vec_pi[s] * (transpose(mat_uBar[s, :]) * mat3_t[s, :, :])[1] for s = 1: num_s)
            e2 = sum(vec_pi[s] * (transpose(mat_uBar[s, :]) * mat_h[s, :])[1] for s = 1: num_s)
            obj_mas = solve_master(mat_e1, e2, vec_bool_solutionSubModel[1])
            vec_yBar = value(vec_y)
            # 3. Compare the bounds and decide whether to stop
            boundLow = max(boundLow, obj_mas)
            dict_boundUp[timesIteration] = boundUp
            dict_boundLow[timesIteration] = boundLow
            if vec_bool_solutionSubModel[1]
                dict_obj_mas[timesIteration] = obj_mas
                dict_obj_sub[timesIteration] = obj_sub
                result_q = value(q)
                dict_q[timesIteration] = result_q
                println("------------------ Result in $(timesIteration)-th Iteration with Sub ",
                        "-------------------\n", "boundUp: $(round(boundUp, digits = 5)), ",
                        "boundLow: $(round(boundLow, digits = 5)), obj_mas: $(round(obj_mas, digits = 5)), ",
                        "q: $result_q, obj_sub: $(round(obj_sub, digits = 5)).")
            else
                dict_obj_mas[timesIteration] = obj_mas
                dict_obj_ray[timesIteration] = obj_sub
                result_q = value(q)
                dict_q[timesIteration] = result_q
                println("------------------ Result in $(timesIteration)-th Iteration with Ray ",
                        "-------------------\n", "boundUp: $(round(boundUp, digits = 5)), ",
                        "boundLow: $(round(boundLow, digits = 5)), obj_mas: $(round(obj_mas, digits = 5)), ",
                        "q: $result_q, obj_ray: $(round(obj_ray, digits = 5)).")
            end
            timesIteration += 1
        end  # -----------------------------------------------------------------------------------------------------
        println("obj_mas: $(objective_value(model_mas))")
        println("----------------------------- Master Problem ----------------------------\n")
        # println(model_mas)
        println("-------------------------------------------------------------------------\n",
                "------------------------------ 2/4. Result ------------------------------\n",
                "-------------------------------------------------------------------------")
        println("boundUp: $(round(boundUp, digits = 5)), boundLow: $(round(boundLow, digits = 5)), ",
                "difference: $(round(boundUp - boundLow, digits = 5))")
        println("vec_x: $vec_result_x")
        vec_result_y = value(vec_y)
        result_q = value(q)
        println("vec_y: $vec_result_y")
        println("result_q: $result_q")
        println("-------------------------------------------------------------------------\n",
                "------------------------- 3/4. Iteration Result -------------------------\n",
                "-------------------------------------------------------------------------")
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
    println("-------------------------------------------------------------------------\n",
            "-------------------------- 4/4. Nominal Ending --------------------------\n",
            "-------------------------------------------------------------------------\n")
end
