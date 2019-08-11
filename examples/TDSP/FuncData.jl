

function getStripPack(num, widthMax, heightMax, wCap, seed)
    Random.seed!(seed)
    vec_w = rand(1:widthMax, num)  # [width of items]
    vec_h = rand(1:heightMax, num)  # [height of items]
    println("Whether wCap >= widthMax? $(wCap >= widthMax)")
    return (wCap, vec_w, vec_h)
end


function solveStripPack(wCap, vec_w, vec_h)
    n = length(vec_w)
    hCap = sum(vec_h)
    println("################################################################################") ########################
    println("**** hCap = $(hCap)")
    timeStart = time()
    IP = Model(solver = GurobiSolver())
    # IP = Model(solver = CplexSolver())
    @variable(IP, 0 <= x[i = 1:n] <= wCap - vec_w[i], Int )
    @variable(IP, 0 <= y[i = 1:n] <= hCap - vec_h[i], Int )
    @variable(IP, matAlpha[i=1:n, j = 1:n], Bin )
    @variable(IP, matBeta[i = 1:n, j = 1:n], Bin )
    @variable(IP, 0 <= z <= hCap, Int )
    @objective(IP, Min, z)
    @constraint(IP, [i = 1:n, j = 1:n; i < j], matAlpha[i,j] + matAlpha[j,i] + matBeta[i,j] + matBeta[j,i] >= 1)
    @constraint(IP, [i = 1:n], y[i] + vec_h[i] <= z)
    # given by variable bounds:
    # @constraint(IP, [i=1:n], x[i] + vec_w[i] <= wCap)
    @constraint(IP, [i = 1:n, j = 1:n; i != j], x[i] + vec_w[i] <= x[j] + wCap * (1 - matAlpha[i,j]))
    @constraint(IP, [i = 1:n, j = 1:n; i != j], y[i] + vec_h[i] <= y[j] + hCap * (1 - matBeta[i,j]))
    # writeLP(IP,"StripPacking.lp",genericnames=false)
    status = solve(IP, relaxation=true)
    println("**** Objective value, relaxation: ", getobjectivevalue(IP))
    #println("y = ", getvalue(y))
    status = solve(IP)
    println("**** Objective value IP: ", getobjectivevalue(IP))
    println("**** x = ", getvalue(x))
    println("**** y = ", getvalue(y))
    println("################################################################################\n",
            "**** Elapsed time is $(time() - timeStart) seconds.\n",
            "#### End #######################################################################") ########################
end


function getSeriesMatrix(i::Int64, j::Int64, num::Int64 = num)
    if i == j
        throw("!!!! Error: i = j.")
    elseif i < j
        s = (i - 1) * (num - 1) + j - 1
    elseif i > j
        s = (i - 1) * (num - 1) + j
    end
    return s
end


function getCoefMatrix(wCap, vec_w, vec_h)
    num = length(vec_w)
    hCap = sum(vec_h)
    vecNumCol = Array{Int64}(undef, 5)
    vecNumCol[1:2] .= convert(Int64, num^2 - num)
    vecNumCol[3:4] .= convert(Int64, num)
    vecNumCol[5] = convert(Int64, 1)
    vecNumRow = Array{Int64}(undef, 5)
    vecNumRow[1] = convert(Int64, sum(collect(1:(num - 1))))
    vecNumRow[2] = convert(Int64, num)
    vecNumRow[3] = convert(Int64, num)
    vecNumRow[4] = convert(Int64, num^2 - num)
    vecNumRow[5] = convert(Int64, num^2 - num)
    ##
    vec_c = zeros(convert(Int64, sum(vecNumCol)))
    vec_c[convert(Int64, sum(vecNumCol))] = -1
    ## mat_a
    mat_a11 = zeros(vecNumRow[1], vecNumCol[1])
    whiRow = 1
    for i = 1:num
        for j = 1:num
            if i < j
                s1 = getSeriesMatrix(i, j, num)
                mat_a11[whiRow, s1] = -1
                s2 = getSeriesMatrix(j, i, num)
                mat_a11[whiRow, s2] = -1
                whiRow += 1
            end
        end
    end
    mat_a1 = [mat_a11 mat_a11 zeros(vecNumRow[1], sum(vecNumCol[3:5]))]
    mat_a2 = [zeros(num, sum(vecNumCol[1:3])) Matrix{Int64}(I, num, num) -ones(num, 1)]
    mat_a3 = [zeros(num, sum(vecNumCol[1:2])) Matrix{Int64}(I, num, num) zeros(num, sum(vecNumCol[4:5]))]
    mat_a41 = zeros(vecNumRow[4], vecNumCol[3])
    whiRow = 1
    for i = 1:num
        for j = 1:num
            if i != j
                mat_a41[whiRow, i] = 1
                mat_a41[whiRow, j] = -1
                whiRow += 1
            end
        end
    end
    mat_a4 = hcat(wCap * Matrix{Int64}(I, vecNumCol[1], vecNumCol[1]), zeros(vecNumRow[4], vecNumCol[2]),
        mat_a41, zeros(vecNumRow[4], sum(vecNumCol[4:5])))
    mat_a5 = hcat(zeros(vecNumRow[5], vecNumCol[1]), hCap * Matrix{Int64}(I, vecNumCol[1], vecNumCol[1]),
        zeros(vecNumRow[5], vecNumCol[3]), mat_a41, zeros(vecNumRow[5], vecNumCol[5]))
    mat_a = vcat(mat_a1, mat_a2, mat_a3, mat_a4, mat_a5)
    ##
    vec_b = hcat(zeros(sum(vecNumRow), 1))
    vec_b[1:vecNumRow[1], 1] .= -1
    vec_b[(vecNumRow[1] + 1):sum(vecNumRow[1:2]), 1] .= -vec_h
    vec_b[(sum(vecNumRow[1:2]) + 1):sum(vecNumRow[1:3]), 1] = wCap .- vec_w
    for i = 1:num
        vec_b[(sum(vecNumRow[1:3]) + (i-1) * (num - 1) + 1):(sum(vecNumRow[1:3]) + i * (num - 1)), 1] .= wCap - vec_w[i]
    end
    for i = 1:num
        vec_b[(sum(vecNumRow[1:4]) + (i-1) * (num - 1) + 1):(sum(vecNumRow[1:4]) + i * (num - 1)), 1] .= hCap - vec_h[i]
    end
    ## Parameters for Sub-problems
    vecVecIndexSub = [vcat(collect(1:vecNumCol[1]), collect((sum(vecNumCol[1:2]) + 1):sum(vecNumCol[1:3]))),
        vcat(collect(sum(vecNumCol[1] + 1):sum(vecNumCol[1:2])),
        collect((sum(vecNumCol[1:3]) + 1):sum(vecNumCol[1:5])))]
    numSub = 2
    m_mat_h = sum(vecNumRow[1:3])
    vecRowMatD = [vecNumRow[4], vecNumRow[5]]
    vecVecIndexBinInSub = [collect(1:vecNumCol[1]), collect(1:vecNumCol[2])]
    # vecVecIndexSub = [collect(1:sum(vecNumCol[1:5]))]
    # numSub = 1
    # m_mat_h = sum(vecNumRow[1:3])
    # vecRowMatD = [sum(vecNumRow[4:5])]
    # vecVecIndexBinInSub = [collect(1:sum(vecNumCol[1:2]))]
    return (vec_c, mat_a, vec_b, vecVecIndexSub, numSub, m_mat_h, vecRowMatD, vecVecIndexBinInSub)
end


function getData()
    ## Test the algorihtm using SSCFLP
    vec_c = - [292  453  359  219  268  736  291  443  403  498  400  967]
    mat_a = [
        Matrix{Float64}(I, 5, 5) zeros(5, 1) Matrix{Float64}(I, 5, 5) zeros(5, 1);
        14 20 6 16 10 -43 zeros(1, 6);
        zeros(1, 6) 14 20 6 16 10 -43
        ]
    vec_b = hcat([ones(5,1); 0; 0])
    vecVecIndexSub = [collect(1:6), collect(7:12)]
    numSub = 2
    m_mat_h = 5
    vecRowMatD = [1, 1]
    vecVecIndexBinInSub = [collect(1:6), collect(1:6)]
    return (vec_c, mat_a, vec_b, vecVecIndexSub, numSub, m_mat_h, vecRowMatD, vecVecIndexBinInSub)
end
