module MatrixOptim

using JuMP
using GLPKMathProgInterface
using LinearAlgebra
using MathProgBase
using Random
using SparseArrays
using PrettyTables

include("./benders/main.jl")
include("./robust/main.jl")
include("./milp/main.jl")
include("./dw/main.jl")

export getModel, solveModel!, appendConstraint!,
    doDWDecomp, Sense, leq, geq, eq

end
