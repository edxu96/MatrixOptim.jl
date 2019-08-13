# Benders Algorithm for Mixed Integer Linear Programming
# To Solve the News Boy Problem
# Edward J. Xu
# Feb 28th, 2019
using JuMP
using GLPKMathProgInterface
# Benders Decomposition algorithm
demand = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30] # Demand of newspapers in each scenario
lengthS = length(demand)
prob = [0.05, 0.10, 0.10, 0.10, 0.15, 0.15, 0.10, 0.10, 0.10, 0.05 ] # probability of scenario
c = 20  # purchase price
p = 70  # selling price
h = 10  # scrap value
y = 20
let
    mas = Model(solver = GLPKSolverMIP())
    @variable(mas, q)
    @variable(mas, 0 <= y <= 40, Int)
    # add master-problem objective
    @objective(mas, Min, (c - h) * y + q)
    boundUp = Inf
    boundLow = - Inf
    epsilon = 0.01
    # definition of sub variables
    uBar = ones(10)
    # initial value of master variables
    yBar = 0
    #
    objMas = 0
    objSub = 0
    timesIteration = 1
    while (boundUp - boundLow > epsilon && timesIteration < 10)
        # sub-problem
        let
            sub = Model(solver = GLPKSolverLP())
            # create full sub-problem model, using the value of master variables yBar
            @variable(sub, u[1: 10] >= 0)
            @objective(sub, Max, - u)
            consX_1 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[1] * (h - p))
            consX_2 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[2] * (h - p))
            consX_3 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[3] * (h - p))
            consX_4 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[4] * (h - p))
            consX_5 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[5] * (h - p))
            consX_6 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[6] * (h - p))
            consX_7 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[7] * (h - p))
            consX_8 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[8] * (h - p))
            consX_9 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[9] * (h - p))
            consX_10 = @constraint(sub, - (u_1 + u_2 + u_3 + u_4 + u_5 + u_6 + u_7 + u_8 + u_9 + u_10) <= prob[10] * (h - p))
            solve(sub)
            objSub = getobjectivevalue(sub)
            u1Bar = getvalue(u_1)
            u2Bar = getvalue(u_2)
            u3Bar = getvalue(u_3)
            u4Bar = getvalue(u_4)
            u5Bar = getvalue(u_5)
            u6Bar = getvalue(u_6)
            u7Bar = getvalue(u_7)
            u8Bar = getvalue(u_8)
            u9Bar = getvalue(u_9)
            u10Bar = getvalue(u_10)
        end
        boundUp = min(boundUp, objSub + (c - h) * yBar)
        # master-problem only add the feasibility constraint
        @constraint(mas, sum((- demand .- y).* [u1Bar, u2Bar, u3Bar, u4Bar, u5Bar, u6Bar, u7Bar, u8Bar, u9Bar, u10Bar]) <= q)
        solve(mas)
        objMas = getobjectivevalue(mas)
        yBar = getvalue(y)
        boundLow = max(objMas, boundLow)
        println("timesIteration: $(timesIteration)\t boundUp: $(boundUp)\t boundLow: $(boundLow)")
        timesIteration += 1
    end
end
println("Correct Ending")
