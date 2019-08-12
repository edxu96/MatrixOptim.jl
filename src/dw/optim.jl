

function doOptim(vecModelSub, modMas, vecConsRef, vecConsConvex, vecLambda, dualPen,
    dualPenMult, dualPenThreshold, vecMuMinus, vecMuPlus, vecMuMinusConv, vecMuPlusConv, epsilon, whePrint)
    ## Initialize
    numQ = size(vecModelSub[1].mat_e)[1]  # [num of constraints in matA_0]
    numSub = length(vecModelSub)
    extremePoints = [[]]
    extremePointForSub = [-1]
    vecObjCoef = [-1000.0]
    wheDoneStab = false
    iter = 1
    ##
    while !wheDoneStab
        vecPi = []
        vecKappa = []
        wheDoneColGen = false
        while !wheDoneColGen
            (vecPi, vecKappa, obj_master) = solveMas(modMas, vecConsRef, vecConsConvex)
            ## Print the result
            println("$(iter)-th iteration. obj_master = $(obj_master).")
            if whePrint
                println("vecPi = $(vecPi)\n",
                        "vecKappa = $(vecKappa)")
            end
            wheDoneColGen = true
            ## Column Generation
            costReduceBest = -1
            for k = 1:numSub
                (costReduce, vec_x_result) = solveSub(vecModelSub[k], vecPi, vecKappa[k])
                if whePrint
                    println("Reduced cost of $(k)-th sub model is $costReduce.")
                end
                if costReduce > costReduceBest
                    costReduceBest = costReduce
                end
                # remember to look for negative reduced cost if we are minimizing.
                if costReduce > epsilon
                    (lambdaNew, objCoefNew) = addColToMas(modMas, vecModelSub[k], vec_x_result,
                        vecConsRef, vecConsConvex[k])
                    push!(vecLambda, lambdaNew)
                    push!(vecObjCoef, objCoefNew)
                    push!(extremePoints, vec_x_result)
                    push!(extremePointForSub, k)
                    wheDoneColGen = false
                end
            end
            ##
            iter += 1
            println("best reduced cost is $(costReduceBest)")
            println("--------------------------------------------------------------------------------")
        end
        ## See whether we should update stabilization parameters.
        if dualPen > 0
            print("Updating dual penalty. old value = $(dualPen), ")
            dualPen *= dualPenMult
            if dualPen < dualPenThreshold
                dualPen = 0
            end
            println("new value = $dualPen")
            vecDualGuessPi = vecPi
            vecDualGuessKappa = vecKappa
            println("New vecDualGuessPi = $vecDualGuessPi")
            println("New vecDualGuessKappa = $vecDualGuessKappa")
            updateStabInfo(modMas, vecObjCoef, vecLambda, numQ, numSub, dualPen, vecDualGuessPi, vecDualGuessKappa,
                vecMuMinus, vecMuPlus, vecMuMinusConv, vecMuPlusConv)
        else
            wheDoneStab = true
        end
    end
    ## 5,  Print the Result
    println("Optimization Done After $(iter-1) Iterations.\n",
            "objMaster = $(objective_value(modMas))")
    vecLambdaResult = value(vecLambda)
    return (vecLambdaResult, extremePointForSub, extremePoints)
end


function getStrNameVar(numSub, numXPerSub)
    vecStrNameVar = Vector{String}(undef, numSub * numXPerSub)
    idx = 1
    for i = 1:numSub
        for j = 1:numXPerSub
            vecStrNameVar[idx] = "x_($i, $j)"
            idx += 1
        end
    end
    return vecStrNameVar
end


function printResult(vecStrNameVar, indexSub, vecLambda, vecLambdaResult, extremePointForSub, extremePoints)
    # compute values of original variables
    origVarValSub = []
    for s = 1: length(indexSub)
        push!(origVarValSub, zeros(length(indexSub[s])))
    end
    for p = 1: length(vecLambdaResult)
        if vecLambdaResult[p] > 0.000001
            println("lambda_$p = ", vecLambdaResult[p], ", sub = $(extremePointForSub[p]), \n",
                    "extreme point = $(extremePoints[p]).")
            origVarValSub[extremePointForSub[p]] += vecLambdaResult[p] * extremePoints[p]
        end
    end
    for s = 1: length(indexSub)
        #println("var val for sub problem $s: $(origVarValSub[s])")
        for t = 1: length(origVarValSub[s])
            if abs(origVarValSub[s][t]) > 0.000001
                println("$(vecStrNameVar[indexSub[s][t]]) = $(origVarValSub[s][t])")
            end
        end
    end
end
