# Robust Optimization
# Version: 2.0
# Author: Edward J. Xu, edxu96@outlook.com
# Date: April 8th, 2019
# 0. Set working path, install packages and use module -----------------------------------------------------------------
push!(LOAD_PATH, "$(homedir())/Desktop/Production Planning, Robust Optimization, DTU02435")
cd("$(homedir())/Desktop/Production Planning, Robust Optimization, DTU02435")
using ExcelReaders
using RobustOptim
using LinearAlgebra
using JuMP
using GLPKMathProgInterface
# 1. Import Original Data ----------------------------------------------------------------------------------------------
include("data.jl")
# 2. Tranform to standard form -----------------------------------------------------------------------------------------
# Question 1: MILP with Box Uncertainty and Budget of Uncertainty
function sectionBudgetMILP(gammaCap)
    num_x = 40
    num_y = 4
    vec_min_y = hcat(zeros(4))
    vec_max_y = hcat(repeat([100], num_y))
    (vec_c, vec_f, vec_b, mat_a, mat_b, mat_a_bar, mat_a_hat, mat_b_bar, vec_b_bar) = paras_budgetMILP(num_x, num_y)
    # Define vec_gammaCap
    vec_gammaCap = zeros(4)
    for m = 1:4
        vec_gammaCap[m] = gammaCap * sum([mat_prodOnMachine[p, m]] for p = 1: 10)[1]
    end
    # Solve the model
    (obj, vec_y, vec_x, vec_result_z, mat_mu, vec_lambda) = RobustOptim.milpBoxBudget(
        num_x=num_x, num_y=num_y, vec_min_y=vec_min_y, vec_max_y=vec_max_y, vec_c=vec_c, vec_f=vec_f,
        vec_b=vec_b, mat_a=mat_a, mat_b=mat_b, mat_a_bar=mat_a_bar, mat_a_hat=mat_a_hat, mat_b_bar=mat_b_bar,
        vec_b_bar=vec_b_bar, vec_gammaCap=vec_gammaCap)
    # return ((obj, vec_y, vec_x, vec_result_z, mat_mu, vec_lambda)
end
# Question 2: Two-Stage Stochastic LP with Box Uncertainty
function sectionStochasticLP(penalty)
    num_x = 40
    num_y = 4
    vec_min_y = hcat(zeros(4))
    vec_max_y = hcat(repeat([100], num_y))
    (vec_c, vec_f, vec_b, mat_a, mat_b, mat_a_bar, mat_a_hat, mat_b_bar, vec_b_bar, vec_g, mat_d, mat_d_bar) =
        paras_stochasticLP(num_x, num_y, penalty)
    # Solve the model
    (obj, vec_y, vec_x, vec_gamma, vec_theta1, vec_theta2) =
        RobustOptim.milpAdjustBox(num_x=num_x, num_y=num_y, num_z=10, vec_min_y=vec_min_y, vec_max_y=vec_max_y,
        vec_c=vec_c, vec_f=vec_f, vec_g=vec_g, vec_b=vec_b, mat_a=mat_a, mat_b=mat_b, mat_d=mat_d,
        mat_a_bar=mat_a_bar, mat_a_hat=mat_a_hat, mat_b_bar=mat_b_bar, mat_d_bar=mat_d_bar, vec_b_bar=vec_b_bar)
    # return (obj, vec_y, vec_x, vec_gamma, vec_theta1, vec_theta2)
end

function main()
    # Question 1: MILP with Box Uncertainty and Budget of Uncertainty
    println("#########################################################\n",
            "   MILP with Box Uncertainty and Budget of Uncertainty\n",
            "#########################################################\n",)
    vec_gammaCap = [0.3, 0, 1]
    for i = 1: 3
        println("*********************************************************\n",
                "   When gammaCap = $(vec_gammaCap[i])\n",
                "*********************************************************\n",)
        sectionBudgetMILP(vec_gammaCap[i])
    end
    # Question 2: Two-Stage Stochastic LP with Box Uncertainty
    println("#########################################################\n",
            "   Two-Stage Stochastic LP with Box Uncertainty\n",
            "#########################################################\n",)
    vec_penalty = [1, 2, 10, 20, 50, 100, 200, 300, 500]
    for i = 1: length(vec_penalty)
        println("*********************************************************\n",
                "   When penalty = $(vec_penalty[i])\n",
                "*********************************************************\n")
        sectionStochasticLP(vec_penalty[i])
    end
end

main()
