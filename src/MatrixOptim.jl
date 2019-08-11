module MatrixOptim

using JuMP
using GLPKMathProgInterface
using Gurobi
using CPLEX
using LinearAlgebra
using MathProgBase
using Random
using SparseArrays
using PrettyTables

export doDWDecomp, Sense, leq, geq, eq

include("benders.jl")
include("robust.jl")
include("lp.jl")
include("dw.jl")
include("coeff-matrix.jl")

end
