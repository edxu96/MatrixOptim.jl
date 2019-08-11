# Dantzig-Wolfe Reformulation and Column Generation
# Functions for Master Problem
# Edward J. Xu
# 2019.5.26
########################################################################################################################


function updateStabInfo(modMas, objCoef, vecLambda, numQ, numSub, dualPen, vecDualGuessPi, vecDualGuessKappa,
        vecMuMinus, vecMuPlus, vecMuMinusConv, vecMuPlusConv)
    @objective(modMas, Max, sum(objCoef[j] * vecLambda[j] for j = 1:length(vecLambda))
        + sum(vecDualGuessPi[i] * (vecMuMinus[i] + vecMuPlus[i]) for i = 1:numQ)
        + sum(vecDualGuessKappa[k] * (vecMuMinusConv[k] + vecMuPlusConv[k]) for k = 1:numSub)
        )
    for i = 1:numQ
        setupperbound(vecMuMinus[i], dualPen)
        setlowerbound(vecMuPlus[i], - dualPen)
    end
    for i = 1:numSub
        setupperbound(vecMuMinusConv[i], dualPen)
        setlowerbound(vecMuPlusConv[i], - dualPen)
    end
end
