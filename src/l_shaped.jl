
module LShaped

using JuMP
using GLPK
using LinearAlgebra
using Random
using SparseArrays
using PrettyTables

function set_model_main(n_y::Int64, vec_min_y::Matrix, vec_max_y::Matrix, vec_f::Matrix)
    m = Model(GLPK.Optimizer)
    @variable(m, q)
    @variable(m, vec_y[1:n_y], Int)
    @objective(m, Min, (transpose(vec_f) * vec_y)[1] + q)
    @constraint(m, vec_y[1:n_y] .<= vec_max_y)
    @constraint(m, vec_y[1:n_y] .>= vec_min_y)

    return m, vec_y
end

function solve_main(m, vec_y, e1_mat, e2, is_sub_feasible::Bool)::Float64
    q = variable_by_name(m, "q")

    if is_sub_feasible
        @constraint(m, (e1_mat * vec_y)[1] + q >= e2)
    else
        @constraint(m, (e1_mat * vec_y)[1] >= e2)
        @constraint(m, (e1_mat * vec_y)[1] + q >= e2)
    end

    optimize!(m)
    return objective_value(m)
end

function solve_sub(vec_ybar, n_constraint, vec_h, mat_t, mat_w, vec_c)

    model_sub = Model(GLPK.Optimizer)
    @variable(model_sub, vec_u[1:n_constraint] >= 0)
    @objective(model_sub, Max, (transpose(vec_h - mat_t * vec_ybar)*vec_u)[1])
    cons_dual = @constraint(model_sub, transpose(mat_w) * vec_u .<= vec_c)
    optimize!(model_sub)

    vec_ubar = value.(vec_u)
    status = termination_status(model_sub)

    if status == JuMP.OPTIMAL
        bool_sub = true
        obj_sub = objective_value(model_sub)
        vec_result_x = dual.(cons_dual)
    elseif status == JuMP.DUAL_INFEASIBLE # ???
        print("Not solved optimally because the feasible set is unbounded.\n")
        bool_sub = false
        obj_sub = objective_value(model_sub)
        vec_result_x = repeat([NaN], length(vec_c))
    elseif status == JuMP.INFEASIBLE
        print("Not solved optimally because of infeasibility. Something is ",
            "wrong.\n")
        bool_sub = false
        obj_sub = NaN
        vec_ubar = hcat(vec_ubar)
        vec_result_x = hcat(repeat([NaN], length(vec_c)))
    end

    return bool_sub, vec_result_x, vec_ubar, obj_sub
end

function solve_ray(vec_ybar, n_constraint, vec_h, mat_t,
    mat_w)

    model_ray = Model(GLPK.Optimizer)
    @variable(model_ray, vec_u[1:n_constraint] >= 0)
    @objective(model_ray, Max, 1)
    @constraint(model_ray, (transpose(vec_h - mat_t * vec_ybar)*vec_u)[1] == 1)
    @constraint(model_ray, transpose(mat_w) * vec_u .<= 0)
    optimize!(model_ray)

    return value.(vec_u), objective_value(model_ray)
end


"""
L-Shaped decomposition for stochastic programming without integer variables in the second stage.
"""
function lshaped(; n_x, vec_min_y, vec_max_y, vec_f, probabilities, mat_c, mat_h,
    mat3_t, mat3_w, epsilon=1e-6, timesIterationMax=100)

    println("Begin L-shaped decomposition")
    n_y = length(vec_min_y)
    num_s = length(mat3_t[:, 1, 1])
    n_constraint = length(mat3_w[1, :, 1])
    mod_mas, vec_y = set_model_main(n_y, vec_min_y, vec_max_y, vec_f)

    let
        ub = Inf
        lb = -Inf

        # initial value of master variables
        mat_uBar = zeros(num_s, n_constraint, 1)
        vec_ybar = zeros(n_y, 1)
        vec_result_x = zeros(num_s, Int8(n_x / num_s), 1)
        obj_sub = 0
        obj_sub_s = zeros(num_s)
        timesIteration = 1

        dict_obj_mas = Dict()
        dict_q = Dict()
        dict_obj_sub = Dict()
        dict_obj_ray = Dict()
        dict_ub = Dict()
        dict_lb = Dict()

        # Must make sure "result_q == obj_sub" in the final iteration
		# while check_whe_continue(ub, lb, epsilon, result_q, obj_sub,
		#     timesIteration, timesIterationMax)
        while ((ub - lb > epsilon) && (timesIteration <= timesIterationMax))

            ## 1. Solve sub/ray problem for each scenario
            is_sub_feasible = trues(num_s)
            for s = 1:num_s
                is_sub_feasible[s], vec_result_x[s, :, :], mat_uBar[s, :, :], obj_sub_s[s] = solve_sub(
                    vec_ybar, n_constraint, mat_h[s, :, :], mat3_t[s, :, :], mat3_w[s, :, :], mat_c[s, :, :])

                if !(is_sub_feasible[s])
                    mat_uBar[s, :, :], obj_sub_s[s]= solve_ray(
                        vec_ybar, n_constraint, mat_h[s, :, :], mat3_t[s, :, :], mat3_w[s, :, :])
                end
            end
            obj_sub = (transpose(probabilities)*obj_sub_s)[1]
            ub = min(ub, obj_sub + (transpose(vec_f)*vec_ybar)[1])

            ## 2. Add optimal cut to master problem
            e1_mat = sum(probabilities[s] * (transpose(mat_uBar[s, :])*mat3_t[s, :, :])[1]
                         for s = 1:num_s)
            e2 = sum(probabilities[s] * (transpose(mat_uBar[s, :])*mat_h[s, :])[1] for
                     s = 1:num_s)

            obj_mas = solve_main(mod_mas, vec_y, e1_mat, e2, is_sub_feasible[1])
            vec_ybar = value.(vec_y)

            ## 3. Compare the bounds and decide whether to stop
            lb = max(lb, obj_mas)

            result_q = value(variable_by_name(mod_mas, "q"))

            dict_ub[timesIteration] = ub
            dict_lb[timesIteration] = lb
            dict_obj_mas[timesIteration] = obj_mas
            dict_obj_sub[timesIteration] = obj_sub
            dict_q[timesIteration] = result_q

            if is_sub_feasible[1]
                println("------------------ Result in $(timesIteration)-th Iteration with Sub ",
                    "-------------------\n", "ub: $(round(ub, digits = 5)), ",
                    "lb: $(round(lb, digits = 5)), obj_mas: $(round(obj_mas, digits = 5)), ",
                    "q: $result_q, obj_sub: $(round(obj_sub, digits = 5)).")
            else
                println("------------------ Result in $(timesIteration)-th Iteration with Ray ",
                    "-------------------\n", "ub: $(round(ub, digits = 5)), ",
                    "lb: $(round(lb, digits = 5)), obj_mas: $(round(obj_mas, digits = 5)), ",
                    "q: $result_q, obj_ray: $(round(obj_ray, digits = 5)).")
            end
            timesIteration += 1
        end

        println("obj_mas: $(objective_value(mod_mas))")
        println("-------------------------------------------------------------------------\n",
            "------------------------------ 2/4. Result ------------------------------\n",
            "-------------------------------------------------------------------------")
        println("ub: $(round(ub, digits = 5)), lb: $(round(lb, digits = 5)), ",
            "difference: $(round(ub - lb, digits = 5))")
        println("vec_x: $vec_result_x")
        vec_result_y = value.(vec_y)
        result_q = value(variable_by_name(mod_mas, "q"))
        println("vec_y: $vec_result_y")
        println("result_q: $result_q")

        println("-------------------------------------------------------------------------\n",
            "------------------------- 3/4. Iteration Result -------------------------\n",
            "-------------------------------------------------------------------------")
        # Initialize
        seq_timesIteration = collect(1:(timesIteration-1))
        vec_ub = zeros(timesIteration - 1)
        vec_lb = zeros(timesIteration - 1)
        obj_sub_sRay = zeros(timesIteration - 1)
        vec_obj_mas = zeros(timesIteration - 1)
        vec_q = zeros(timesIteration - 1)
        vec_type = repeat([""], (timesIteration - 1))

        #
        for i = 1:(timesIteration-1)
            vec_obj_mas[i] = round(dict_obj_mas[i], digits=5)
            vec_ub[i] = round(dict_ub[i], digits=5)
            vec_lb[i] = round(dict_lb[i], digits=5)
            vec_q[i] = round(dict_q[i], digits=5)
            if haskey(dict_obj_sub, i)
                vec_type[i] = "sub"
                obj_sub_sRay[i] = round(dict_obj_sub[i], digits=5)
            else
                vec_type[i] = "ray"
                obj_sub_sRay[i] = round(dict_obj_ray[i], digits=5)
            end
        end
        table_iterationResult = hcat(seq_timesIteration, vec_ub, vec_lb,
            vec_obj_mas, vec_q, vec_type, obj_sub_sRay)
        pretty_table(table_iterationResult,
            ; alignment=:l, header=["Seq", "ub", "lb", "obj_mas", "q", "sub/ray", "obj_sub/ray"])
    end
end

export lshaped

end