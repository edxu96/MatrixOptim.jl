# Framework for
# Edward J. Xu, edxu96@outlook.com
# Aug 25, 2019

module MatrixOptimFramework

export


"MILP model for Benders decomposition in matrix form."
mutable struct Mod

    solution::Union{Solution, Missing}

    function Mod()
        new()
    end
end


mutable struct Mod()

    function Mod()
        model_ray = Model(with_optimizer(GLPK.Optimizer))
        @variable(model_ray, vec_u[1: n_cons] >= 0)
        @objective(model_ray, Max, 1)
        @constraint(model_ray, (transpose(vec_b - mat_b * vec_yBar) * vec_u)[1] == 1)
        @constraint(model_ray, vec_cons, transpose(mat_a) * vec_u .<= 0)
        new(expr=model)
    end
end


"Head of Linked List of Sub Model"
struct ModSubHead()
    expr
    ref

    function ModSubHead(n_cons, vec_yBar, vec_b, mat_b, mat_a, vec_c)
        expr = Model(with_optimizer(GLPK.Optimizer))
        @variable(expr, vec_u[1: n_cons] >= 0)
        @objective(expr, Max, (transpose(vec_b - mat_b * vec_yBar) * vec_u)[1])
        @constraint(expr, vec_cons, transpose(mat_a) * vec_u .<= vec_c)
        new(expr, ref=ModSub())
    end
end


function get_mod_sub(mod_sub_head::ModSubHead)
    return mod_sub
end


mutable struct ModSub()
    bool
    obj
    vec_uBar
    vec_result_x

    ref

    function ModSub()
        new(missing, missing, missing, missing, ModSub())
    end
end


function solve_mod_sub!(mod::ModSub)
    mod.st_solution = optimize!(mod.expr)
    mod.vec_uBar = value_vec(vec_u)

    mod.bool = true
    mod.vec_result_x = zeros(length(vec_c))
    mod.obj = NaN
    if Int(primal_status(model)) == 1
        mod.vec_result_x = dual_vec(vec_cons)
        mod.obj = objective_value(model)
    elseif Int(primal_status(model)) == 4  # Unbounded
        println("    Not solved to optimality because feasible set is unbounded.")
        mod.bool = false
        mod.obj = objective_value(model)
        mod.vec_result_x = repeat([NaN], length(vec_c))
    else  # if Int(primal_status(model)) == 3  # Infeasible
        println("    Not solved to optimality because infeasibility. Something is wrong. $(Int(primal_status(model)))")
        mod.bool = false
        mod.vec_result_x = hcat(repeat([NaN], length(vec_c)))
    end
end


mutable struct ModRay()
    vec_uBar
    obj

    ref

    function ModRay()
        new(vec_uBar=value_vec(vec_u), obj_ray=objective_value(model_ray))
    end
end


function solve_mod_ray!(mod::ModRay)

    optimize!(model_ray)


    return (obj_ray, vec_uBar)
end


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


mutable struct name
    fields
end


"""
Generic Benders Decomposition for Mixed Integer Linear Programming
"""
function solveModMixBD!(mod::ModBD, epsilon=1e-6, timesIterationMax=100)
    if mod.solution is not missing
        println("The model has been solved.")
    else
        println("The model has been solved.")
        mod_mas = ModMas(mod.n_y, mod.vec_min_y, mod.vec_max_y)
        mod_sub_head = ModSub()

        boundUp = Inf
        boundLow = - Inf
        # vec_uBar = zeros(n_cons, 1)  # initial value of master variables
        vec_yBar = zeros(mod.n_y, 1)
        vec_result_x = zeros(mod.n_x, 1)

        obj_sub = 0
        result_q = 0
        timesIteration = 1
        # Must make sure "result_q == obj_sub" in the final iteration
        # while ((boundUp - boundLow > epsilon) && (timesIteration <= timesIterationMax))  !!!
        while check_whe_continue(
                boundUp, boundLow, epsilon, result_q, obj_sub,
                timesIteration, timesIterationMax
                )
            mod_sub = get_mod_sub(mod_mod_sub_head)
            solve_mod_sub!(mod_sub)
            if mod_sub.bool
                println("obj_sub = $(obj_sub) ;")
                boundUp = min(boundUp, mod_sub.obj + (transpose(mod.vec_f) * vec_yBar)[1])
            else
                mod_ray = ModRay()
                solve_mod_ray!(mod_ray)
            end

            solve_mod_mas!(
                mod_mas, q, vec_y, mod.vec_b, mod.mat_b
                )
            vec_yBar = value_vec(mod_mas.vec_y)
            boundLow = max(boundLow, mod_mas.obj)

            timesIteration += 1
        end
    end
    println("End")
end


end
