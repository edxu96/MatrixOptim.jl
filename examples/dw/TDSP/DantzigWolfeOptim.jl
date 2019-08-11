# Dantzig-Wolfe Decomposition
# Edward J. Xu
# 2019.5.28
# module DantzigWolfeOptim
# export doDantzigWolfeOptim
########################################################################################################################
using JuMP
# using CPLEX
using Gurobi
using LinearAlgebra
include("FuncSub.jl")
include("FuncMas.jl")
include("FuncOptim.jl")
########################################################################################################################


function doDantzigWolfeOptim(
        vec_c, mat_a, vec_b, vecVecIndexSub, numSub, m_mat_h, vecRowMatD, vecVecIndexBinInSub,
        wheBranch, vecWhiSub, vecWhiVar, vecWhiBranch
        )
    timeStart = time()
    epsilon = 0.00001
    gurobi_env = Gurobi.Env()
    vecStrNameVar = getVecStrNameVar(numSub, vecVecIndexSub)
    println("#### 1/4,  Set vecModelSub #####################################################") ########################
    vecModelSub = setModelSub(
        numSub, vecVecIndexSub, m_mat_h, vec_c, mat_a, vec_b, vecRowMatD, gurobi_env, vecVecIndexBinInSub,
        wheBranch, vecWhiSub, vecWhiVar, vecWhiBranch
        )
    println("#### 2/4,  Set modelMas ########################################################") ########################
    (modMas, vecConsRef, vecConsConvex, vecLambda) = setModelMas(vecModelSub[1].mat_e, vec_b, numSub, gurobi_env)
    println("#### 3/4,  Begin Optim #########################################################") ########################
    (vecLambdaResult, extremePointForSub, extremePoints) = doOptim(
        vecModelSub, modMas, vecConsRef, vecConsConvex, vecLambda, epsilon
        )
    println("#### 4/4,  Print Result ########################################################") ########################
    # printResult(vecLambdaResult, extremePointForSub, extremePoints, vecStrNameVar, vecVecIndexSub)
    println("################################################################################\n",
            "#### Elapsed time is $(time() - timeStart) seconds.\n",
            "#### End #######################################################################") ########################
end


# end
