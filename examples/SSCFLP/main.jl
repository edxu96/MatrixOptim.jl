# Dantzig-Wolfe Decomposition
# Edward J. Xu
# 2019.5.28
# include("$(homedir())/Documents/Github/DantzigWolfeDecomposition/Case/SSCFLP/main.jl")
########################################################################################################################
push!(LOAD_PATH, "$(homedir())//Documents/Github/DantzigWolfeDecomposition/Case/SSCFLP")
cd("$(homedir())//Documents/Github/DantzigWolfeDecomposition/Case/SSCFLP")
using JuMP
# using CPLEX
using Gurobi
using LinearAlgebra
using Random
using DantzigWolfeOptim
include("FuncSub.jl")
include("FuncMas.jl")
include("FuncOptim.jl")
include("FuncData.jl")
# include("DantzigWolfeOptim.jl")
########################################################################################################################


function main(whi::Float64)
    ## 1,  Data
    (vec_c, mat_a, vec_b, matIndexSub, numSub, numXInSub, m_mat_h, vecRowMatD) = getData(whi)
    ## 2,  Optim
    vecWhiBranch = [1, 1]
    if whi == 1
        wheBranch = true
        vecWhiSub = [1, 1]
        vecWhiVar = [12, 6]
    elseif whi == 2
        wheBranch = true
        vecWhiSub = [2, 1]
        vecWhiVar = [6, 6]
    else
        wheBranch = false
        vecWhiSub = [1]
        vecWhiVar = [1]
        vecWhiBranch = [1]
    end
    doDantzigWolfeOptim(vec_c, mat_a, vec_b, matIndexSub, numSub, numXInSub,
        m_mat_h, vecRowMatD, wheBranch, vecWhiSub, vecWhiVar, vecWhiBranch
        )
end


main(7.2)
