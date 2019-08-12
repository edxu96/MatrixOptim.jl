# Dantzig-Wolfe Reformulation and Column Generation
# Functions for Master Problem
# Edward J. Xu
# 2019.5.25
########################################################################################################################


function setModelMas(numQ, vecP, numSub, vecSenseP, dualPen, gurobi_env, whiSolver)
    vecDualGuessPi = 100 * ones(Float64, numQ)
    vecDualGuessKappa = 0 * ones(Float64, numSub)
    ## X1: initial matrix of extreme points
    # if whiSolver == 1
    #     modMas =  Model(solver = GurobiSolver(OutputFlag = 0, gurobi_env))
    # elseif whiSolver == 2
    #     modMas =  Model(solver = CplexSolver(CPX_PARAM_SCRIND=0))
    # else
    modMas =  Model(with_optimizer(GLPK.Optimizer))
    # end
    K = 1
    # In this case we do not use a starting set of extreme points.
    # we just use a dummy starting column
    @variable(modMas, vecLambda[1:K] >= 0 )
    @variable(modMas, 0 <= vecMuMinus[1:numQ] <= dualPen)
    @variable(modMas, - dualPen <= vecMuPlus[1:numQ] <= 0)
    @variable(modMas, 0 <= vecMuMinusConv[1:numSub] <= dualPen)
    @variable(modMas, - dualPen <= vecMuPlusConv[1:numSub] <= 0)
    # Remember to consider if we need to maximize or minimize
    @objective(
        modMas, Max, sum(- 1000 * vecLambda[j] for j = 1:K) +
        sum(vecDualGuessPi[i] * (vecMuMinus[i] + vecMuPlus[i]) for i = 1:numQ) +
        sum(vecDualGuessKappa[k] * (vecMuMinusConv[k] + vecMuPlusConv[k]) for k=1:numSub)
        )
    # @constraint(modMas, vecConsRef[i = 1: numQ], sum(vecP[i] * vecLambda[j] for j = 1:K) == vecP[i])
    JuMPConstraintRef = JuMP.ConstraintRef{Model, JuMP.GenericRangeConstraint{JuMP.GenericAffExpr{Float64,Variable}}}
    vecConsRef = Vector{JuMPConstraintRef}(undef, numQ)
    for i = 1:numQ
        if vecSenseP[i] == leq
            vecConsRef[i] = @constraint(modMas, sum(vecP[i] * vecLambda[j] for j = 1:K) +
                vecMuMinus[i] + vecMuPlus[i] <= vecP[i])
        elseif vecSenseP[i] == geq
            vecConsRef[i] = @constraint(modMas, sum(vecP[i] * vecLambda[j] for j = 1:K) +
                vecMuMinus[i] + vecMuPlus[i] >= vecP[i])
        else
            vecConsRef[i] = @constraint(modMas, sum(vecP[i] * vecLambda[j] for j = 1:K) +
                vecMuMinus[i] + vecMuPlus[i] == vecP[i])
        end
    end
    @constraint(modMas, vecConsConvex[k = 1: numSub], sum(vecLambda[j] for j = 1: K) +
        vecMuMinusConv[k] + vecMuPlusConv[k] == 1)
    return (modMas, vecConsRef, vecConsConvex, vecLambda, vecMuMinus, vecMuPlus, vecMuMinusConv, vecMuPlusConv)
end


function addColToMas(modMas::JuMP.Model, modSub::ModelSub, vec_x_result, vecConsRef, consConvex)
    (m, n) = size(modSub.mat_e)
    A0x = modSub.mat_e * vec_x_result
    vecConsTouched = ConstraintRef[]
    vals = Float64[]
    for i = 1: m
        # only insert non-zero elements (this saves memory and may make the modMas problem easier to optimize!)
        if A0x[i] != 0
            push!(vecConsTouched, vecConsRef[i])
            push!(vals, A0x[i])
        end
    end
    # add variable to convexity constraint.
    push!(vecConsTouched, consConvex)
    push!(vals, 1)
    objCoefNew = sum(modSub.vec_l[j] * vec_x_result[j] for j = 1: n)
    println("objCoefNew = $(objCoefNew).")
    @variable(
        modMas,
        lambdaNew >= 0,                     # New variable to be added
        objective = objCoefNew,             # cost coefficient of new varaible in the objective
        inconstraints = vecConsTouched,     # constraints to be modified
        coefficients = vals                 # the coefficients of the variable in those constraints
        )
    return (lambdaNew, objCoefNew)
end


function solveMas(modMas, vecConsRef, vecConsConvex)
    status = optimize!(modMas)
    if status != :Optimal
        throw("Error: Non-optimal modMas-problem status")
    end
    vecPi = dual(vecConsRef)
    vecKappa = dual(vecConsConvex)
    obj_master = objective_value(modMas)
    ## ensure that vecPi and vecKappa are row vectors
    vecPi = reshape(vecPi, 1, length(vecPi))
    vecKappa = reshape(vecKappa, 1, length(vecKappa))
    return (vecPi, vecKappa, obj_master)
end
