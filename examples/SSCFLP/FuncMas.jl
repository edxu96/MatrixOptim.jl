# Dantzig-Wolfe Optim
# Functions for Master Problem
# Edward J. Xu
# 2019.5.28
########################################################################################################################


function setModelMas(mat_e, vec_b, num_sub, gurobi_env)
    ## X1: initial matrix of extreme points
    modMas = Model(solver = GurobiSolver(OutputFlag = 0, gurobi_env))
    (m_e, n_e) = size(mat_e)
    vec_p = vec_b[1: m_e, 1]
    K = 1
    # In this case we do not use a starting set of extreme points.
    # we just use a dummy starting column
    @variable(modMas, vecLambda[1: K] >= 0 )
    # Remember to consider if we need to maximize or minimize
    @objective(modMas, Max, sum(- 1e6 * vecLambda[j] for j = 1: K) )
    # remember to change "==" if your master-problem uses a different type of constraints!
    @constraint(modMas, vecConsRef[i = 1: m_e], sum(vec_p[i] * vecLambda[j] for j = 1: K) == vec_p[i])
    @constraint(modMas, vecConsConvex[k = 1: num_sub], sum(vecLambda[j] for j = 1: K) == 1)
    return (modMas, vecConsRef, vecConsConvex, vecLambda)
end


function solveMas(modMas, vecConsRef, vecConsConvex)
    status = solve(modMas)
    if status != :Optimal
        throw("Error: Non-optimal master-problem status")
    end
    vec_pi = getdual(vecConsRef)
    vec_kappa = getdual(vecConsConvex)
    obj_master = getobjectivevalue(modMas)
    ## ensure that vec_pi and vec_kappa are row vectors
    vec_pi = reshape(vec_pi, 1, length(vec_pi))
    vec_kappa = reshape(vec_kappa, 1, length(vec_kappa))
    return (vec_pi, vec_kappa, obj_master)
end


function addColToMaster(modMas::JuMP.Model, modSub::ModelSub, vec_x_result, vecConsRef, consConvex)
    (m, n) = size(modSub.mat_e)
    A0x = modSub.mat_e * vec_x_result
    vec_consTouched = ConstraintRef[]
    vals = Float64[]
    for i = 1: m
        # only insert non-zero elements (this saves memory and may make the master problem easier to solve)
        if A0x[i] != 0
            push!(vec_consTouched, vecConsRef[i])
            push!(vals, A0x[i])
        end
    end
    # add variable to convexity constraint.
    push!(vec_consTouched, consConvex)
    push!(vals, 1)
    objCoef = sum(modSub.vec_l[j] * vec_x_result[j] for j = 1: n)
    # println("objCoef = $objCoef.")
    @variable(
        modMas,
        lambdaNew >= 0,                     # New variable to be added
        objective = objCoef,                # cost coefficient of new varaible in the objective
        inconstraints = vec_consTouched,    # constraints to be modified
        coefficients = vals                 # the coefficients of the variable in those constraints
        )
    return lambdaNew
end
