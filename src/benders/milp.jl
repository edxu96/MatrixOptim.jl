# Benders Decomposition for MILP with Sub and Ray Problems
# Author: Edward J. Xu, edxu96@outlook.com
# Date: April 25th, 2019

"MILP model for Benders decomposition in matrix form."
mutable struct ModMilpBenders
    vec_min_y
    vec_max_y
    vec_c
    vec_f
    vec_b
    mat_aCap
    mat_bCap
    n_x
    n_y
    n_cons

    sol::Union{SolutionMix,Missing}
    mas::Union{ModMas,Missing}
    logs::Union{LogHead,Missing}

    function ModMilpBenders(
            vec_min_y::Array{Int64,1}, vec_max_y::Array{Int64,1},
            vec_c::Array{Int64,2}, vec_b::Array{Int64,2},
            vec_f::Array{Int64,2}, mat_aCap::Array{Int64,2},
            mat_bCap::Array{Int64,2}
            )
        # Check if the vectors are column vectors.
        checkColVec(vec_c, "vec_c")
        checkColVec(vec_f, "vec_f")
        checkColVec(vec_b, "vec_b")

        # Check if the corresponding lengths match with each other.
        n_x = length(vec_c)
        n_y = length(vec_f)
        n_cons = length(vec_b)
        checkMatrixMatch(n_y, vec_min_y, "vec_min_y")
        checkMatrixMatch(n_y, vec_max_y, "vec_max_y")
        checkMatrixMatch(n_x, mat_aCap, col, "num of x", "mat_aCap")
        checkMatrixMatch(n_y, mat_bCap, col, "num of y", "mat_bCap")
        checkMatrixMatch(
            n_cons, mat_aCap, row, "num of constraints", "mat_aCap"
            )
        checkMatrixMatch(
            n_cons, mat_bCap, row, "num of constraints", "mat_bCap"
            )

        new(
            vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_aCap, mat_bCap,
            n_x, n_y, n_cons, missing
            )
    end
end

"""
Benders Decomposition for Mixed Integer Linear Programming

    mod = ModMilpBenders()
    solveModMilpBenders!(mod)
"""
function solveModMilpBenders!(
        mod::ModMilpBenders, epsilon=1e-6, timesIterationMax=100
        )
    if mod.solution is not missing
        println("The model has been solved.")
    else
        println("The model is being solved by Benders decomposition.")

        mod.mas = ModMas(mod.n_y, mod.vec_min_y, mod.vec_max_y)
        mod.logs = LogHead(n_cons, vec_y_bar, vec_b, mat_b, mat_a, vec_c)

        obj_sub = 0
        result_q = 0
        ite = 1
        whe_continue = true
        while whe_continue
            log = log_latest(mod.logs)

            # Solve sub model first. If failed, solve ray model
            mod_sub = ModSub(
                mod.log.vec_y_bar, mod.n_cons, mod.vec_b, mod.mat_b, mod.mat_a,
                mod.vec_c
                )
            log.slave = solve_sub!(mod_sub)
            if mod_sub.bool
                log.bu = min(
                    bu, mod_sub.obj + (transpose(mod.vec_f) * vec_y_bar)[1]
                    )
            else
                mod_ray = ModRay()
                log.slave = solve_ray!(mod_ray)
            end

            log.mas = solve_mod_mas!(
                mod.mas, q, vec_y, mod.vec_b, mod.mat_b
                )
            vec_y_bar = value_vec(mod_mas.vec_y)
            log.bl = max(bl, mod_mas.obj)

            ite += 1
            append_log!(log)
            whe_continue = check_whe_continue(
                log.bu, log.bl, epsilon, result_q, obj_sub,
                ite, timesIterationMax
                )
        end

        mod.sol = SolutionMix(obj=)
    end
    println("End")
end
