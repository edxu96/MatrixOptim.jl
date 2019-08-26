# Benders Decomposition
# Edward J. Xu, edxu96@outlook.com
# April 25th, 2019

module BendersDecomp

"""
Make sure "result_q == obj_sub" in the final iteration,
while ((bu - bl > epsilon) && (ite <= timesIterationMax))  !!!
"""
function check_whe_continue(
        bu, bl, epsilon, result_q, obj_sub,
        ite, timesIterationMax
        )
    whe_continue = true
    if (bu - bl <= epsilon) & (bu - bl >= - epsilon)
        if (result_q - obj_sub <= epsilon) & (result_q - obj_sub >= - epsilon)
            whe_continue = false
        end
    end

    return (ite <= timesIterationMax) && whe_continue
end


"JuMP Model of Master Problem"
mutable struct ModMas
    expr::Model
    vec_y

    function ModMas(n_y, vec_min_y, vec_max_y)
        expr = Model(with_optimizer(GLPK.Optimizer))
        @variable(expr, q)
        @variable(expr, vec_y[1: n_y], Int)
        @objective(expr, Min, (transpose(vec_f) * vec_y)[1] + q)
        @constraint(expr, vec_y[1: n_y] .<= vec_max_y)
        @constraint(expr, vec_y[1: n_y] .>= vec_min_y)
        new(expr, vec_y)
    end
end

struct LogMas
    obj
    vec_y_result
end

function solve_mas!(
        mas::ModMas, q, vec_y, vec_b, mat_b
        )
    if bool_solution_sub
        @constraint(
            mas.mod,
            (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= q
            )
    else  # Add feasible cut Constraints
        @constraint(
            mas.mod,
            (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= 0
            )
    end
    @constraint(
        mas.mod, (transpose(vec_uBar) * (vec_b - mat_b * vec_y))[1] <= q
        )

    optimize!(mas.mod)
    log = LogMas(obj=objective_value(mas), vec_y=value_vec(vec_y))
    return log
end

mutable struct Log
    ite::Int64
    log_slave::Union{LogRay,LogSub,Missing}
    log_mas::Union{LogMas,Missing}
    bu::Float64
    bl::Float64
    next::Log

    function Log(ite, bu=missing, bl=missing)
        new(missing, missing, bu, bl, missing)
    end
end

"Append a new log after this log."
function append_log!(log::Log)
    log.next = Log(log.ite + 1)
    log.next.bu = log.bu
    log.next.bl = log.bl
end

"Head of Linked List for Log"
struct LogHead
    next::Log

    function LogHead(n_cons, vec_y_bar, vec_b, mat_b, mat_a, vec_c)
        vec_y_bar = zeros(mod.n_y, 1)
        vec_result_x = zeros(mod.n_x, 1)
        new(
            next=Log(ite=0, bu=Inf, bl=- Inf)
            )
    end
end

function findLogLastest(logs::LogHead)
    crt = LogHead
    while !(isequal(missing, crt.next))
        crt = crt.next
    end
    return crt
end

include("./milp.jl")
include("./l-shaped.jl")
include("./slave.jl")


export ModMilpBenders, solveModMilpBenders!

end
