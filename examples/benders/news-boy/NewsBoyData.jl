# News Boy Problem solved by L-Shaped Benders Decomposition
# Author: Edward J. Xu, edxu96@outlook.com
# Date: April 5th, 2019
# 0. Set working path, install packages and use module -----------------------------------------------------------------
push!(LOAD_PATH, "$(homedir())/Desktop/News Boy Problem, Stochastic Programming")
cd("$(homedir())/Desktop/News Boy Problem, Stochastic Programming")
using BendersLshapedStochasMilp_EDXU
using JuMP
using GLPKMathProgInterface
# 1. Date Input --------------------------------------------------------------------------------------------------------
demand = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30] # Demand of newspapers in each scenario
lengthS = length(demand)
vec_prob = [0.05, 0.10, 0.10, 0.10, 0.15, 0.15, 0.10, 0.10, 0.10, 0.05 ] # probability of scenario
c = 20 # purchase price
p = 70 # selling price
h = 10 # scrap value
y = 20
# 2. Data Transfer -----------------------------------------------------------------------------------------------------
n_x = 10  # Number of all the x
n_y = 1
vec_min_y = hcat([0])
vec_max_y = hcat([30])
vec_f = hcat(c - 10)
vec_pi = hcat(vec_prob)
mat_c = zeros(10, 1, 1)
for i = 1:10
    mat_c[i, :, :] = hcat([- 70 + 10])
end
mat_h = zeros(10, 2, 1)
for i = 1: 10
    mat_h[i, 1, :] = hcat(- demand[i])
    mat_h[i, 2, :] = hcat(0)
end
mat3_t = zeros(10, 2, 1)
for i = 1:10
    mat3_t[i, 1, :] = hcat(0)
    mat3_t[i, 2, :] = hcat(1)
end
mat3_w = - ones(10, 2, 1)
epsilon = 0.001
timesIterationMax = 500
# 3. Begin Optimization ------------------------------------------------------------------------------------------------
BendersLshaped(; n_x = n_x, n_y = n_y, vec_min_y = vec_min_y, vec_max_y = vec_max_y, vec_f = vec_f,
    vec_pi = vec_pi, mat_c = mat_c, mat_h = mat_h, mat3_t = mat3_t, mat3_w = mat3_w,
    epsilon = epsilon, timesIterationMax = timesIterationMax)
# answer: obj = - 976
