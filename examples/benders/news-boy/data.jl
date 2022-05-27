demand = [12, 14, 16, 18, 20, 22, 24, 26, 28, 30] # Demand of newspapers in each scenario
lengthS = length(demand)
vec_prob = [0.05, 0.10, 0.10, 0.10, 0.15, 0.15, 0.10, 0.10, 0.10, 0.05 ] # probability of scenario
c = 20 # purchase price
p = 70 # selling price
h = 10 # scrap value
y = 20
# 1. Solved by L-Shaped Benders Algorithm ------------------------------------------------------------------------------
n_x = 10
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
