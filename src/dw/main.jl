# Dantzig-Wolfe Reformulation and Column Generation
# Edward J. Xu
# 2019.5.27
########################################################################################################################

include("./sub.jl")
include("./mas.jl")
include("./stab.jl")
include("./optim.jl")
########################################################################################################################


@enum Sense begin
    leq = 1
    geq = 2
    eq = 3
end


function doDWDecomp(mat_a, vec_b, vec_c, vecSenseAll, indexMas, blocks, indexSub, numXPerSub,
        dualPen, dualPenMult, dualPenThreshold, epsilon, whePrint::Bool, whiSolver)
    if whiSolver == 1
        gurobi_env = Gurobi.Env()
    elseif whiSolver == 2
        gurobi_env = []
    else
        gurobi_env = []
    end
    println("#### 1/4,  Set vecModelSub #####################################################") ########################
    vecModelSub = setModelSub(mat_a, vec_b, vec_c, vecSenseAll, indexMas, blocks, indexSub, gurobi_env, whiSolver)
    numSub = length(vecModelSub)
    numQ = size(vecModelSub[1].mat_e)[1]  # [num of constraints in matA_0]
    vecStrNameVar = getStrNameVar(numSub, numXPerSub)  # define variable names
    println("#### 2/4,  Set modelMas ########################################################") ########################
    vecSenseP = deepcopy(vecSenseAll[collect(indexMas)])
    vecP = deepcopy(vec_b[collect(indexMas)])
    (modMas, vecConsRef, vecConsConvex, vecLambda, vecMuMinus, vecMuPlus, vecMuMinusConv, vecMuPlusConv) =
        setModelMas(numQ, vecP, numSub, vecSenseP, dualPen, gurobi_env, whiSolver)
    ## 5,  Optimization
    println("#### 3/4,  Begin Optim #########################################################") ########################
    (vecLambdaResult, extremePointForSub, extremePoints) = doOptim(
        vecModelSub, modMas, vecConsRef, vecConsConvex, vecLambda,                                     # Para for ColGen
        dualPen, dualPenMult, dualPenThreshold, vecMuMinus, vecMuPlus, vecMuMinusConv, vecMuPlusConv,  # Para for Stable
        epsilon, whePrint
        )
    println("#### 4/4,  Print Result ########################################################") ########################
    printResult(vecStrNameVar, indexSub, vecLambda, vecLambdaResult, extremePointForSub, extremePoints)
    println("################################################################################")
end
