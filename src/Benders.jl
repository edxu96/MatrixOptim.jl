# Benders Decomposition
# 1. BendersOptim.milp: for MILP with Sub and Ray Problems
# 2. BendersOptim.lshaped: for stochastic programming
# 0. Linear programming in matrix
# Version: 5.1
# Author: Edward J. Xu, edxu96@outlook.com
# Date: April 5th, 2019
module Benders
    using JuMP
    using GLPKMathProgInterface
    using PrettyTables
    # 1.BendersOptim.milp: for MILP with Sub and Ray Problems
    include("Benders_milp.jl")
    # 2. BendersOptim.lshaped: for stochastic programming
    include("Benders_lshaped.jl")
    # 0. Linear programming
    include("lp.jl")
end
