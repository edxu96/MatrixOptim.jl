module MatrixOptim

using JuMP
using GLPKMathProgInterface
using LinearAlgebra
using MathProgBase
using Random
using SparseArrays
using PrettyTables

export ModelMixed, doDWDecomp, Sense, leq, geq, eq

include("benders.jl")
include("robust.jl")
include("lp.jl")
include("dw.jl")
include("coeff-matrix.jl")

end
