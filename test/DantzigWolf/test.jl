# Dantzig-Wolfe Reformulation and Column Generation
# Edward J. Xu
# 2019.5.26
# include("$(homedir())/Documents/Github/DantzigWolfeDecomposition/Test/test.jl")
# push!(LOAD_PATH, "$(homedir())/Documents/Github/DantzigWolfeDecomposition")
# cd("$(homedir())/Documents/Github/DantzigWolfeDecomposition")

include("FuncData.jl")
using DantzigWolfeDecomposition

function main(strFileName::String, series::Int64)
    println("#### 1/2,  Prepare Data ########################################################") ########################
    (mat_a, vec_b, vec_c, vecSenseAll, indexMas, blocks, indexSub, numXPerSub) = setGeneralAssignProbDate(
        strFileName, series)
    println("#### 2/2,  Begin Optim #########################################################") ########################
    timeStart = time()
    ## Set parameter and start DW-Decomposition
    dualPen = 10
    dualPenMult = 0.1
    dualPenThreshold = 0.01 - 1e-5
    epsilon = 0.00001                # [maximum difference between two bounds]
    whePrint = false                 # [whether to print detailed info]
    whiSolver = 1                    # 1: Gurobi, 2: CPLEX, 3: GLPK
    doDWDecomp(
        mat_a, vec_b, vec_c,                                  # Data in LP Problem
        vecSenseAll, indexMas, blocks, indexSub, numXPerSub,  # Data for DW-Decomp
        dualPen, dualPenMult, dualPenThreshold,               # Para for Stable
        epsilon, whePrint, whiSolver                          # Control Para
        )
    println("Elapsed time is $(time() - timeStart) seconds.")
    println("#### End #######################################################################") ########################
end


main("Data/gapa.txt", 1)
