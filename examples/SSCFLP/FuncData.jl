# Dantzig-Wolfe Reformulation and Column Generation
# Edward J. Xu
# 2019.5.28
########################################################################################################################


function SSCFLRand(m::Int64,n::Int64, maxXY::Int64, minF::Int64, maxF::Int64, minD::Int64, maxD::Int64, seed)
    # m:  number of facilities
    # n: number of customers
    Random.seed!(seed)
    # Cost of opening facitlities
    f = rand(minF:maxF, m)
    # Coordinates for facilities (chosen in the box [0,maxXY]x[0,maxXY])
    fac = rand(0:maxXY, m, 2)
    # Coordinates for customers (chosen in the box [0,maxXY]x[0,maxXY])
    cust = rand(0:maxXY, n, 2)
    d = rand(minD:maxD, n)
    totDemand = sum(d)
    capPerFacility = ceil(1.3 * totDemand / m)
    q = capPerFacility*ones(m)

    c = zeros(m, n)
    # compute distances
    for i = 1:m
        for j = 1:n
            dist = round(norm(fac[i,1:2] - cust[j,1:2]))  # norm function is in package LinearAlgebra
            c[i,j] = dist
        end
    end
    return (c, f, q, d)
end


function solveSSCFL(c, f, q, d)
    (m,n) = size(c)
    timeStart = time()
    mod = Model(solver = GurobiSolver())
    #mod = Model(solver = CplexSolver())
    @variable(mod, x[1:m, 1:n], Bin )
    @variable(mod, y[1:m], Bin )
    @objective(mod, Min, sum(c[i,j] * x[i,j] for i=1:m for j=1:n) + sum(f[i]*y[i] for i=1:m))
    @constraint(mod, [j = 1:n], sum(x[i,j] for i=1:m) == 1)
    #@constraint(mod, [i=1:m,j=1:n], x[i,j] <= y[i])
    @constraint(mod, [i = 1:m], sum(d[j]*x[i,j] for j=1:n) <= q[i]y[i])
    # writeLP(mod, "SSCFLP.lp", genericnames = false)
    status = solve(mod, relaxation = true)
    println("#### Objective value, relaxation: ", getobjectivevalue(mod))
    println("#### y = ", getvalue(y))
    println("#### Elapsed time is $(time() - timeStart) seconds.\n",
            "################################################################################") ########################
    status = solve(mod)
    println("#### Objective value: ", getobjectivevalue(mod))
    #println("x = ", getvalue(x))
    #println("y = ", getvalue(y))
    println("#### Number of facilities opened: ", sum(getvalue(y)))
    println("#### Elapsed time is $(time() - timeStart) seconds.\n",
            "#### End #######################################################################") ########################
end


function getData(whi::Float64)
    if whi == 1  # Convexify􏰁 constraints into one sub-problem
        vec_c = - [292  453  359  219  268  736  291  443  403  498  400  967]
        mat_a = [
            Matrix{Float64}(I, 5, 5) zeros(5, 1) Matrix{Float64}(I, 5, 5) zeros(5, 1);
            14 20 6 16 10 -43 zeros(1, 6);
            zeros(1, 6) 14 20 6 16 10 -43
            ]
        vec_b = hcat([ones(5,1); 0; 0])
        matIndexSub = hcat(collect(1:12))'
        numSub = 1
        numXInSub = 12
        m_mat_h = 5
        vecRowMatD = [2]
    elseif whi == 2  # Convexify􏰁 constraints into two sub-problems
        vec_c = - [292  453  359  219  268  736  291  443  403  498  400  967]
        mat_a = [
            Matrix{Float64}(I, 5, 5) zeros(5, 1) Matrix{Float64}(I, 5, 5) zeros(5, 1);
            14 20 6 16 10 -43 zeros(1, 6);
            zeros(1, 6) 14 20 6 16 10 -43
            ]
        vec_b = hcat([ones(5,1); 0; 0])
        matIndexSub = Array{Int64}(undef, 2, 6)
        matIndexSub[1, :] = collect(1:6)
        matIndexSub[2, :] = collect(7:12)
        numSub = 2
        numXInSub = 6
        m_mat_h = 5
        vecRowMatD = [1, 1]
    elseif whi == 3  # Convexify􏰁 constraints into one sub-problems, restrain the y
        vec_c = - [292  453  359  219  268  736  291  443  403  498  400  967]
        mat_a = [
            Matrix{Float64}(I, 6, 6) Matrix{Float64}(I, 6, 6);
            14 20 6 16 10 -43 zeros(1, 6);
            zeros(1, 6) 14 20 6 16 10 -43
            ]
        vec_b = hcat([ones(5,1); 2; 0; 0])
        matIndexSub = Array{Int64}(undef, 2, 6)
        matIndexSub[1, :] = collect(1:6)
        matIndexSub[2, :] = collect(7:12)
        numSub = 1
        numXInSub = 12
        m_mat_h = 6
        vecRowMatD = [2]
    elseif whi == 4  # Convexify􏰁 constraints into two sub-problems, restrain the y
        vec_c = - [292  453  359  219  268  736  291  443  403  498  400  967]
        mat_a = [
            Matrix{Float64}(I, 6, 6) Matrix{Float64}(I, 6, 6);
            14 20 6 16 10 -43 zeros(1, 6);
            zeros(1, 6) 14 20 6 16 10 -43
            ]
        vec_b = hcat([ones(5,1); 2; 0; 0])
        matIndexSub = Array{Int64}(undef, 2, 6)
        matIndexSub[1, :] = collect(1:6)
        matIndexSub[2, :] = collect(7:12)
        numSub = 2
        numXInSub = 6
        m_mat_h = 6
        vecRowMatD = [1, 1]
    elseif whi >= 5
        if round(whi) == 5
            (c, f, q, d) = SSCFLRand(2, 5, 500, 500, 1000, 1, 20, 3)
        elseif round(whi) == 6
            (c, f, q, d) = SSCFLRand(10, 25, 500, 500, 1000, 1, 20, 3)
        elseif round(whi) == 7
            (c, f, q, d) = SSCFLRand(20, 50, 500, 500, 1000, 1, 20, 3)
        end
        vec_c = - reshape(hcat(c, f)', 1, :)
        (m, n) = size(c)
        mat_a_atom = zeros(m, m + n, n + 1)
        for i = 1:m
            mat_a_atom[i, :, :] = [
                Matrix{Float64}(I, n, n) zeros(n, 1);
                zeros(m, n + 1)
                ]
            mat_a_atom[i, n + i, :] = vcat(d, - q[i])
        end
        mat_a = zeros(n + m, m * (n + 1))
        for i = 1:m
            mat_a[:, ((i - 1) * (n + 1) + 1):(i * (n + 1))] = mat_a_atom[i, :, :]
        end
        vec_b = hcat(zeros(n + m, 1))
        vec_b[1:n, 1] = ones(n, 1)
        if ((whi == 5.1) | (whi == 6.1) | (whi == 7.1))
            matIndexSub = hcat(collect(1:(m * (n + 1))))'
            numSub = 1
            numXInSub = m * (n + 1)
            m_mat_h = n
            vecRowMatD = Array{Int64}(undef, 1)
            vecRowMatD = [m]
        elseif ((whi == 5.2) | (whi == 6.2) | (whi == 7.2))
            matIndexSub = Array{Int64}(undef, m, n + 1)
            for i = 1:m
                matIndexSub[i, :] = collect(((i - 1) * (n + 1) + 1):(i * (n + 1)))
            end
            numSub = m
            numXInSub = n + 1
            m_mat_h = n
            vecRowMatD = Array{Int64}(undef, 1)
            vecRowMatD = ones(1, m)
            println("#### 0,  Solve SSCFL Model using Gurobi#########################################") ####################
            solveSSCFL(c, f, q, d)
            println("#### End #######################################################################") ####################
        else
            throw("Wrong \"whi\" input!")
        end
    else
        throw("Wrong \"whi\" input!")
    end
    return (vec_c, mat_a, vec_b, matIndexSub, numSub, numXInSub, m_mat_h, vecRowMatD)
end
