module MatrixOptim

using JuMP
using GLPKMathProgInterface
using LinearAlgebra
using MathProgBase
using Random
using SparseArrays
using PrettyTables

include("benders.jl")
include("robust.jl")
include("milp.jl")
include("dw.jl")
include("coeff-matrix.jl")

export getModelProgramming, solveModel!, appendConstraint!,
    doDWDecomp, Sense, leq, geq, eq

end
