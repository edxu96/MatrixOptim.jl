# Dantzig-Wolfe Decomposition
# Edward J. Xu
# 2019.5.28
# include("$(homedir())/Documents/Github/DantzigWolfeDecomposition/Case/TDSP/main.jl")
########################################################################################################################
push!(LOAD_PATH, "$(homedir())//Documents/Github/DantzigWolfeDecomposition/Case/SSCFLP")
cd("$(homedir())//Documents/Github/DantzigWolfeDecomposition/Case/SSCFLP")
using JuMP
# using CPLEX
using Gurobi
using LinearAlgebra
using Random
# using DantzigWolfeOptim
include("FuncSub.jl")
include("FuncMas.jl")
include("FuncOptim.jl")
include("FuncData.jl")
include("DantzigWolfeOptim.jl")
########################################################################################################################


function main()
    ## 1,  Data
    ## num, widthMax, heightMax, wCap, seed
    ## Some instances may be difficult, both for CPLEX/Gurobi and for the Dantzig-Wolfe approach.
    # (wCap, vec_w, vec_h) = getStripPack(3, 10, 10, 11, 2)
    (wCap, vec_w, vec_h) = getStripPack(4, 10, 10, 11, 2)
    # (wCap, vec_w, vec_h) = getStripPack(5, 10, 10, 12, 3)
    #(wCap, vec_w, vec_h) = getStripPack(6, 10, 10, 13, 4)
    #(wCap, vec_w, vec_h) = getStripPack(7, 10, 10, 20, 5)
    # (wCap, vec_w, vec_h) = getStripPack(8, 10, 10, 20, 6)
    #(wCap, vec_w, vec_h) = getStripPack(9, 10, 10, 20, 7)
    #(wCap, vec_w, vec_h) = getStripPack(10, 10, 10, 20, 8)
    #(wCap, vec_w, vec_h) = getStripPack(11, 10, 10, 20, 9)
    #(wCap, vec_w, vec_h) = getStripPack(12, 10, 10, 20, 1)
    #(wCap, vec_w, vec_h) = getStripPack(13, 10, 10, 20, 10)
    #(wCap, vec_w, vec_h) = getStripPack(14, 10, 10, 20, 11)
    # (wCap, vec_w, vec_h) = getStripPack(15, 10, 10, 20, 12)
    # println("wCap = $(wCap)")
    # println("vec_w = $(vec_w)")
    # println("vec_h = $(vec_h)")
    # solveStripPack(wCap, vec_w, vec_h)
    (vec_c, mat_a, vec_b, vecVecIndexSub, numSub, m_mat_h, vecRowMatD, vecVecIndexBinInSub) = getCoefMatrix(
        wCap, vec_w, vec_h
        )
    if numSub == 1
        solveLP(vec_c, mat_a, vec_b, vecVecIndexBinInSub)
    end
    ## Test the algorihtm using SSCFLP
    # (vec_c, mat_a, vec_b, vecVecIndexSub, numSub, m_mat_h, vecRowMatD, vecVecIndexBinInSub) = getData()
    ## 2,  Optim
    wheBranch = false
    vecWhiSub = [1]
    vecWhiVar = [1]
    vecWhiBranch = [1]
    doDantzigWolfeOptim(
        vec_c, mat_a, vec_b, vecVecIndexSub, numSub, m_mat_h, vecRowMatD, vecVecIndexBinInSub,
        wheBranch, vecWhiSub, vecWhiVar, vecWhiBranch
        )
end


main()
