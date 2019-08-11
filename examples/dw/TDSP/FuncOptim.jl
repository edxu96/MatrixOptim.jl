# Dantzig-Wolfe Reformulation and Column Generation
# Edward J. Xu
# 2019.5.28
########################################################################################################################


function doOptim(vecModelSub, modMas, vecConsRef, vecConsConvex, vecLambda, epsilon)
    ## 4,  Begin Iteration
    println("#### Begin Iteration ###########################################################") ########################
    extremePoints = [[]]
    extremePointForSub = [-1]
    done = false
    iter = 1
    while !done
        (vec_pi, vec_kappa, obj_master) = solveMas(modMas, vecConsRef, vecConsConvex)
        done = true
        ## Print the result
        println("--------------------------------------------------------------------------------")
        println("$(iter)-th iteration. obj_master = $(obj_master).")
        println("vec_pi = $(vec_pi)\n",
                "vec_kappa = $(vec_kappa)")
        ## Column Generation
        costReduceBest = -1
        for k = 1: length(vecModelSub)
            (costReduce, vec_x_result) = solveSub(vecModelSub[k], vec_pi, vec_kappa[k])
            println("Reduced cost of $(k)-th sub model is $costReduce.")
            if costReduce > costReduceBest
                costReduceBest = costReduce
            end
            # remember to look for negative reduced cost if we are minimizing.
            if costReduce > epsilon
                lambdaNew = addColToMaster(modMas, vecModelSub[k], vec_x_result, vecConsRef, vecConsConvex[k])
                push!(vecLambda, lambdaNew)
                push!(extremePoints, vec_x_result)
                push!(extremePointForSub, k)
                done = false
            end
        end
        ##
        iter += 1
        # println("best reduced cost is $costReduceBest")
    end
    ## 5,  Print the Result
    println("################################################################################\n", ######################
            "Optimization Done After $(iter-1) Iterations.\n",
            "obj_master = $(getobjectivevalue(modMas))\n",
            "################################################################################")
    vecLambdaResult = getvalue(vecLambda)
    return (vecLambdaResult, extremePointForSub, extremePoints)
end


function getVecStrNameVar(numSub, vecVecIndexSub)
    vecNumXInSub = zeros(numSub)
    for i = 1: numSub
        vecNumXInSub[i] = length(vecVecIndexSub[i])
    end
    vecStrNameVar = Vector{String}(undef, convert(Int64, sum(vecNumXInSub)))
    idx = 1
    for i = 1: numSub
        for j = 1: vecNumXInSub[i]
            vecStrNameVar[idx] = "x_{$(i),$(j)}"
            idx += 1
        end
    end
    return vecStrNameVar
end


function printResult(vecLambdaResult, extremePointForSub, extremePoints, vecStrNameVar, matIndexSub)
    # compute values of original variables
    origVarValSub = []
    numSub = size(matIndexSub)[1]
    for s = 1:numSub
        push!(origVarValSub, zeros(length(matIndexSub[s,:])))
    end
    for p = 1: length(vecLambdaResult)
        if vecLambdaResult[p] > 0.000001
            println("lambda_$p = ", vecLambdaResult[p], ", sub = $(extremePointForSub[p]), \n",
                    "extreme point = $(extremePoints[p]).")
            origVarValSub[extremePointForSub[p]] += vecLambdaResult[p] * extremePoints[p]
        end
    end
    for s = 1:numSub
        #println("var val for sub problem $s: $(origVarValSub[s])")
        for t = 1: length(origVarValSub[s])
            if abs(origVarValSub[s][t]) > 0.000001
                println("$(vecStrNameVar[matIndexSub[s, t]]) = $(origVarValSub[s][t])")
            end
        end
    end
end


function solveLP(vec_c, mat_a, vec_b, vecVecIndexBinInSub)
    println("################################################################################") ########################
    num_x = length(vec_c)
    model = Model(solver = GurobiSolver())
    @variable(model, vec_x[1:num_x] >= 0, Int)
    @objective(model, Max, sum(vec_c[i] * vec_x[i] for i = 1:num_x))
    @constraint(model, mat_a * vec_x .<= vec_b)
    @constraint(model, vec_x[vecVecIndexBinInSub[1]] .<= 1)
    solve(model)
    println("**** Objective value IP: $(getobjectivevalue(model))")
    println("**** x = $(getvalue(vec_x))\n",
            "#### End #######################################################################") ########################
end
