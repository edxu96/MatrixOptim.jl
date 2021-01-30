
import Pkg
using Test

Pkg.activate(".")

using MatrixOptim

include("./milp.jl")
# include("./benders/milp.jl")
# include("./benders/l-shaped.jl")

# @test test_benders() == 0
