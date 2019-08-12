# Dantzig-Wolfe Reformulation and Column Generation
# Functions for Sub-Problem
# Edward J. Xu
# 2019.5.26
########################################################################################################################


mutable struct ModelSub
    mod::Model
    mat_e
    vec_l
    mat_d
    vec_q
    vec_x
    vecSense
end


function setVariableSub(modSub::Model, mat_d, vec_q, vecSense)
    (m_d, n_d) = size(mat_d)
    @variable(modSub, vec_x[1: n_d] >= 0, Bin)
    @objective(modSub, Max, 0)
    # @constraint(modSub, cons[i = 1: m_d], sum(mat_d[i, j] * vec_x[j] for j = 1: n_d) <= vec_q[i])
    for i = 1:m_d
        if vecSense[i] == leq
            @constraint(modSub, sum(mat_d[i, j] * vec_x[j] for j = 1:n_d) <= vec_q[i])
        elseif vecSense[i] == geq
            @constraint(modSub, sum(mat_d[i, j] * vec_x[j] for j = 1:n_d) >= vec_q[i])
        else
            @constraint(modSub, sum(mat_d[i, j] * vec_x[j] for j = 1:n_d) == vec_q[i])
        end
    end
    return vec_x
end


# function setBranch(vecModelSub, i, j)
#     vec_new = zeros(1, 15)
#     vec_new[j] = -1
#     vecModelSub[i].mat_d = vcat(vecModelSub[i].mat_d, vec_new)
#     vecModelSub[i].vec_q = vcat(vecModelSub[i].vec_q, [-1])
#     println(vecModelSub[i].mat_d)
#     println(vecModelSub[i].vec_q)
#     return vecModelSub
# end


function setModelSub(mat_a, vec_b, vec_c, vecSense, indexMas, blocks, indexSub, gurobi_env, whiSolver)
    numSub = length(blocks)
    vecModelSub = Vector{ModelSub}(undef, numSub)
    modWhiSolver = Model(with_optimizer(GLPK.Optimizer))
    for k = 1:numSub
        vecModelSub[k] = ModelSub(
            modWhiSolver,                                                 # mod
            deepcopy(mat_a[collect(indexMas), indexSub[k]]),              # mat_e
            deepcopy(vec_c[indexSub[k]]),                                 # vec_l
            deepcopy(mat_a[blocks[k], indexSub[k]]),                      # mat_d
            deepcopy(vec_b[blocks[k]]),                                   # vec_q
            0,                                                            # vec_x
            deepcopy(vecSense[blocks[k]])                                 # vecSense
            )
    end
    # vecModelSub = setBranch(vecModelSub, 1, 2)
    for k = 1:numSub
        vecModelSub[k].vec_x = setVariableSub(vecModelSub[k].mod, vecModelSub[k].mat_d, vecModelSub[k].vec_q,
            vecModelSub[k].vecSense)
    end
    return vecModelSub
end


function solveSub(modSub::ModelSub, vecPi, kappa)
    (m, n) = size(modSub.mat_e)
    piA0 = vecPi * modSub.mat_e
    @objective(modSub.mod, Max, sum(modSub.vec_l[j] * modSub.vec_x[j] for j = 1: n) -
        sum(piA0[1, j] * modSub.vec_x[j] for j = 1: n) - kappa)
    status = optimize!(modSub.mod)
    if status != :Optimal
        throw("Error: Non-optimal sub-problem status")
    end
    costReduce = objective_value(modSub.mod)
    vec_x_result = value(modSub.vec_x)
    return (costReduce, vec_x_result)
end
