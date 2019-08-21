
using MatrixOptim
using Test

include("./milp/test.jl")
include("./benders/milp.jl")
include("./benders/l-shaped.jl")

@test test_milp() == 42
@test test_benders() == 0
