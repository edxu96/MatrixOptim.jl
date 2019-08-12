
using MatrixOptim
using Test

include("./milp/test.jl")
include("./benders/test.jl")

@test test_milp() == 42
@test test_benders() == 0
