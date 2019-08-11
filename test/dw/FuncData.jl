# Dantzig-Wolfe Reformulation and Column Generation
# Functions for Master Problem
# Edward J. Xu
# 2019.5.25
########################################################################################################################


function setGAPModel(w, p, c)
    (numSub, numXPerSub) = size(w)
    # mod = Model(solver = CplexSolver(CPX_PARAM_TILIM = 1))
    modAll = Model(solver = GurobiSolver())
    @variable(modAll, x[1:numSub, 1:numXPerSub], Bin)
    @objective(modAll, Min, sum(p[i,j] * x[i,j] for i = 1:numSub for j = 1:numXPerSub))
    # each job must be served
    @constraint(modAll, [j = 1:numXPerSub], sum(x[i,j] for i = 1:numSub) == 1)
    @constraint(modAll, [i = 1:numSub], sum(w[i,j] * x[i,j] for j = 1:numXPerSub) <= c[i])
    ##
    # define blocks (Each block becomes a sub-problem)
    blocks = []
    for i = 1:numSub
        # constraint (numXPerSub + i) goes into block i
        push!(blocks, [numXPerSub + i])
    end
    # When using cplex we need to start solving the model before we can
    # export the constraint matrix and so on.
    # solve(mod)
    JuMP.build(modAll)
    return (modAll, numXPerSub, blocks)
end


function readData(strFileName::String, series::Int64)
    # function for reading GAP files from the OR-library
    open(strFileName) do f
        allFile = read(f, String)
        allNumbers = map(x -> parse(Int64,x), split(allFile))
        # return allNumbers
        numSeries = allNumbers[1]
        println("File contains $numSeries instances.")
        if series > numSeries
            throw("readData(...): specified file does not contain $(series) example")
        end
        index = 2
        for inst = 1:numSeries
            numSub = allNumbers[index]
            numXPerSub = allNumbers[index + 1]
            println("numSub = $(numSub), numXPerSub = $(numXPerSub)")
            w = zeros(numSub, numXPerSub)
            p = zeros(numSub, numXPerSub)
            c = zeros(numSub)
            index += 2
            println("start index when reading p: $index")
            for i = 1:numSub
                for j = 1:numXPerSub
                    p[i,j] = allNumbers[index]
                    index += 1
                end
            end
            println("start index when reading w: $index")
            for i = 1:numSub
                for j = 1:numXPerSub
                    w[i,j] = allNumbers[index]
                    index += 1
                end
            end
            println("start index when reading c: $index")
            for i=1:numSub
                c[i] = allNumbers[index]
                index += 1
            end
            if inst == series
                return (w, p, c)
            end
        end
    end
end


function getMat(mod)
    JuMP.build(mod)
    mpb = MathProgBase
    modInternal = internalmodel(mod)
    vecBoundLowerCons = mpb.getconstrLB(modInternal)
    vecBoundUpperCons = mpb.getconstrUB(modInternal)
    vecSense = Vector{Sense}(undef, length(vecBoundLowerCons))
    vec_b = Vector{Float64}(undef, length(vecBoundLowerCons))
    for i = 1:length(vecBoundLowerCons)
        if vecBoundLowerCons[i] == vecBoundUpperCons[i]
            vecSense[i] = eq
            vec_b[i] = vecBoundLowerCons[i]
        elseif vecBoundLowerCons[i] == -Inf
            vecSense[i] = leq
            vec_b[i] = vecBoundUpperCons[i]
        elseif vecBoundUpperCons[i] == Inf
            vecSense[i] = geq
            vec_b[i] = vecBoundLowerCons[i]
        else
            throw("Error: One of the constraints in the input model is a \"range\" constraint. This is not supported.")
        end
    end
    mat_a = mpb.getconstrmatrix(modInternal)
    vec_c = mpb.getobj(modInternal)
    vecBoundLowerVar = mpb.getvarLB(modInternal)
    vecBoundUpperVar = mpb.getvarUB(modInternal)
    vecTypeVar = mpb.getvartype(modInternal)
    return (mat_a, vec_b, vec_c, vecSense)
    # return (mat_a, vec_b, vec_c, vecBoundLowerVar, vecBoundUpperVar, vecTypeVar, vecSense)
end


function addVarsFromRow(Arow, varBitSet)
    for idx=1:length(Arow.nzval)
        if Arow.nzval[idx] != 0
            push!(varBitSet, Arow.nzind[idx])
        end
    end
end


function getIndex(mat_a, blocks)
    # find out which variables that belong to which block:
    numSub = length(blocks)
    if numSub < 1
        throw("error. We expect at least one block")
    end
    (numCons, numVar) = size(mat_a)
    varsInSub = Vector{BitSet}(undef, numSub)
    for k = 1:numSub
        varsInSub[k] = BitSet()
        for row in blocks[k]
            addVarsFromRow(mat_a[row,:], varsInSub[k])
        end
    end
    # check that the blocks are not sharing any variables
    for k1 = 1:numSub
        for k2 = k1 + 1:numSub
            if !isempty(intersect(varsInSub[k1],varsInSub[k2]))
                throw("Blocks $k1 and $k2 share variables. This is not supported.")
            end
        end
    end
    # Check that all variables belong to a block
    setUnion = deepcopy(varsInSub[1])
    for k = 2:numSub
        union!(setUnion, varsInSub[k])
    end
    for j = 1:numVar
        if !(j in setUnion)
            throw("variable $j does not belong to any block. This is not supported")
        end
    end
    # Find the rows that are left in master problem:
    indexMas = BitSet(1:numCons)
    for block in blocks
        setdiff!(indexMas, block)
    end
    ## IndexSub
    indexSub = Vector{Vector{Int64}}(undef, numSub)
    for k = 1:numSub
        indexSub[k] = collect(varsInSub[k])
    end
    return (indexMas, indexSub)
end


function setGeneralAssignProbDate(strFileName, series)
    println("#### 1.1/5,  Read Data #########################################################") ########################
    (w, p, c) = readData(strFileName, series)
    (modAll, numXPerSub, blocks) = setGAPModel(w, p, c)
    println("#### 1.2/5,  Get Index #########################################################") ########################
    (mat_a, vec_b, vec_c, vecSenseAll) = getMat(modAll)
    (indexMas, indexSub) = getIndex(mat_a, blocks)
    return (mat_a, vec_b, vec_c, vecSenseAll, indexMas, blocks, indexSub, numXPerSub, numXPerSub)
end
