# OptiGas: Optimize Gas Network using Benders Algorithm
# Version: 2.0
# Author: Edward J. Xu, edxu96@outlook.com
# Date: March 20th, 2019
push!(LOAD_PATH, "$(homedir())/Desktop/OptiGas, DTU42136")
cd("$(homedir())/Desktop/OptiGas, DTU42136")
# using BendersMilp_EDXU
using Benders
using LinearAlgebra
# -------------------------------------------------------------------
# 1. Parameters
vec_nameNodes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
numNodes = length(vec_nameNodes)
vec_xNode = [1    3    8    2    4    5    6    7    9    9]
vec_yNode = [1    2    1    7    9    5    3    7    9    4]
mat_arcTwoNodes = [0    1    0    0    0    0    0    0    0    0;
                   0    0    0    0    0    1    0    0    0    0;
                   0    0    0    0    0    0    0    0    0    1;
                   1    0    0    0    1    0    0    0    0    0;
                   0    0    0    0    0    1    0    0    0    0;
                   1    0    0    1    0    0    0    1    0    0;
                   0    1    1    0    0    0    0    0    0    0;
                   0    0    0    0    0    0    0    0    1    0;
                   0    0    0    0    1    0    0    0    0    0;
                   0    0    0    0    0    1    1    0    1    0]
vec_netEject =  [0    0   0    0    0   90    0    0   0   80 ]
vec_netInject = [10   30  20   10   40   0   25   20  15    0 ]
mat_distance = zeros(Float64, numNodes, numNodes)
for m = 1: numNodes
    for n = 1: numNodes
        mat_distance[m, n] = floor(sqrt( (vec_xNode[m] - vec_xNode[n]) * (vec_xNode[m] - vec_xNode[n]) +
                                   (vec_yNode[m] - vec_yNode[n]) * (vec_yNode[m] - vec_yNode[n]) ) )
    end
end
mat_fixedCost = zeros(Float64, numNodes, numNodes)
for m = 1: numNodes
    for n = 1: numNodes
        mat_fixedCost[m, n] = 10 * mat_distance[m, n]
    end
end
# ----------------------------------------------------------------------------------------------------------------------
# Question 4
# Fomulation of Matrix A
mat_a1_1 = zeros(numNodes^2, numNodes^2)
for mn = 1: numNodes^2
    mat_a1_1[mn, mn] = -1
end
# mat_a2_1 = zeros(numNodes^2, numNodes^2)
mat_a3_1 = zeros(numNodes, numNodes^2)
seq_zeroTenNinety = collect(0:10:90)
for m = 1: numNodes
    mat_a3_1[m, (10 * m - 9): (10 * m)] = repeat([-1], 10)  # sent out
    mat_a3_1[m, (seq_zeroTenNinety + repeat([m],10))] = repeat([1], 10)  # sent in
    mat_a3_1[:, (11 * m - 10)] = repeat([0], 10)  # self-sending doesn't count
end
mat_a_1 = vcat(mat_a1_1, mat_a3_1)
# Fomulation of Matrix B
mat_b1_1 = zeros(numNodes^2, numNodes^2)
for mn = 1: numNodes^2
    mat_b1_1[mn, mn] = 170
end
# mat_b2_1 = Diagnal(repeat([1], numNodes^2))
mat_b3_1 = zeros(numNodes, numNodes^2)
mat_b_1 = vcat(mat_b1_1, mat_b3_1)
# Fomulation of Vector b
vec_b1_1 = zeros(numNodes^2)
# vec_b2_1 = zeros(numNodes^2)
# for m = 1: numNodes
#     for n = 1: numNodes
#         vec_b2_1[10 * (m - 1) + n] = mat_arcTwoNodes[m, n]
#     end
# end
vec_b3_1 = zeros(numNodes)
for n = 1: numNodes
    vec_b3_1[n] = vec_netInject[n] - vec_netEject[n]
end
vec_b_1 = vcat(vec_b1_1, vec_b3_1)
vec_b_1 = hcat(vec_b_1)
#
vec_max_y_1 = repeat([1], numNodes^2)
vec_max_y_1 = hcat(vec_max_y_1)
vec_min_y_1 = zeros(numNodes^2)
for m = 1: numNodes
    for n = 1: numNodes
        vec_min_y_1[10 * (m - 1) + n] = mat_arcTwoNodes[m, n]
    end
end
#
vec_c_1 = zeros(numNodes^2)
for m = 1: numNodes
    for n = 1: numNodes
        vec_c_1[10 * (m - 1) + n] = mat_distance[m, n]
    end
end
vec_c_1 = hcat(vec_c_1)
#
vec_f_1 = zeros(numNodes^2)
for m = 1: numNodes
    for n = 1: numNodes
        vec_f_1[10 * (m - 1) + n] = mat_fixedCost[m, n]
    end
end
vec_f_1 = hcat(vec_f_1)
#
Benders.milp(n_x = numNodes^2,
             n_y = numNodes^2,
             vec_min_y = vec_min_y_1,
             vec_max_y = vec_max_y_1,
             vec_c = vec_c_1,
             vec_f = vec_f_1,
             vec_b = vec_b_1,
             mat_a = mat_a_1,
             mat_b = mat_b_1,
             epsilon = 0.0001,
             timesIterationMax = 1000)
# 1280 - sum(mat_arcTwoNodes .* mat_fixedCost)
# ----------------------------------------------------------------------------------------------------------------------
# Question 5
# Fomulation of Matrix A
mat_a1_2 = zeros(numNodes^2, numNodes^2)
for mn = 1: numNodes^2
    mat_a1_2[mn, mn] = -1
end
mat_a3_2 = zeros(numNodes, numNodes^2)
seq_zeroTenNinety = collect(0:10:90)
for m = 1: numNodes
    mat_a3_2[m, (10 * m - 9): (10 * m)] = repeat([-1], 10)  # sent out
    mat_a3_2[m, (seq_zeroTenNinety + repeat([m],10))] = repeat([1], 10)  # sent in
    mat_a3_2[:, (11 * m - 10)] = repeat([0], 10)  # self-sending doesn't count
end
mat_a_2 = vcat(mat_a1_2, mat_a3_2)
# Fomulation of Matrix B
mat_b1_2 = zeros(numNodes^2, numNodes^2)
for mn = 1: numNodes^2
    mat_b1_2[mn, mn] = 170
end
mat_b3_2 = zeros(numNodes, numNodes^2)
mat_b_2 = vcat(mat_b1_2, mat_b3_2)
# Fomulation of Vector b
vec_b1_2 = zeros(numNodes^2)
vec_b3_2 = zeros(numNodes)
for n = 1: numNodes
    vec_b3_2[n] = vec_netInject[n] - vec_netEject[n]
end
vec_b_2 = vcat(vec_b1_2, vec_b3_2)
vec_b_2 = hcat(vec_b_2)
#
vec_max_y_2 = repeat([1], numNodes^2)
vec_max_y_2 = hcat(vec_max_y_2)
#
vec_c_2 = zeros(numNodes^2)
for m = 1: numNodes
    for n = 1: numNodes
        vec_c_2[10 * (m - 1) + n] = mat_distance[m, n]
    end
end
vec_c_2 = hcat(vec_c_2)
#
vec_f_2 = zeros(numNodes^2)
for m = 1: numNodes
    for n = 1: numNodes
        vec_f_2[10 * (m - 1) + n] = mat_fixedCost[m, n]
    end
end
vec_f_2 = hcat(vec_f_2)
#
Benders.milp(n_x = numNodes^2,
            n_y = numNodes^2,
            vec_min_y = repeat([0], numNodes^2),
            vec_max_y = vec_max_y_2,
            vec_c = vec_c_2,
            vec_f = vec_f_2,
            vec_b = vec_b_2,
            mat_a = mat_a_2,
            mat_b = mat_b_2,
            epsilon = 0.0001,
            timesIterationMax = 1000)
# obj - sum(mat_arcTwoNodes .* mat_fixedCost)
# ----------------------------------------------------------------------------------------------------------------------
# using LightGraphs
# using GraphPlot
# using Compose
# using Cairo
# using Fontconfig
# mat_result_y = [0 1 0 0 0 0 0 0 0 0;
#                 0 0 0 0 0 1 0 0 0 0;
#                 0 0 0 0 0 0 0 0 0 1;
#                 1 0 0 0 1 0 0 0 0 0;
#                 0 0 0 0 0 1 0 0 0 0;
#                 1 1 0 1 1 0 0 1 0 0;
#                 0 1 1 0 0 0 0 0 0 0;
#                 0 0 0 0 0 0 0 0 1 0;
#                 0 0 0 0 1 0 0 0 0 0;
#                 0 0 1 0 0 1 1 1 1 0]
# graph_initial = DiGraph(mat_arcTwoNodes)
# plot_graph_initial = gplot(graph_initial, nodelabel = vec_nameNodes)
# graph_result = graph_initial
# mat_arcTwoNodes_new = mat_result_y - mat_arcTwoNodes
# for m = 1: numNodes
#     for n = 1: numNodes
#         if mat_arcTwoNodes_new[m,n] == 1
#             add_edge!(graph_result, m, n)
#         end
#     end
# end
# gplot(graph_result, nodelabel = vec_nameNodes)
# draw(PNG("graph_initial.png", 16cm, 16cm), gplot(graph_initial))
# draw(PNG("graph_result.png", 16cm, 16cm), gplot(result))

# Final Corrected
vec_x= [0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        10 10 0 10 40 0 0 20 0 0
        0 20 20 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 65 0 15 0]
vec_y= [0 1 0 0 0 0 0 0 0 0
        0 0 0 0 0 1 0 0 0 0
        0 0 0 0 0 0 0 0 0 1
        1 0 0 0 1 0 0 0 0 0
        0 0 0 0 0 1 0 0 0 0
        1 1 0 1 1 0 0 1 0 0
        0 1 1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 1 0
        0 0 0 0 1 0 0 0 0 0
        0 0 0 0 0 1 1 0 1 0]

vec_y: [0 1 0 0 0 0 0 0 0 0
        0 0 0 0 0 1 0 0 0 0
        0 0 0 0 0 0 0 0 0 1
        1 0 0 0 1 0 0 0 0 0
        0 0 0 0 0 1 0 0 0 0
        1 1 0 1 1 0 0 1 0 0
        0 1 1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 1 0
        0 0 0 0 1 0 0 0 0 0
        0 0 1 0 0 1 1 1 1 0]
result_q: 600.0






vec_x= [0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        10 30 0 10 40 0 0 0 0 0
        0 0 0 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 15 0
        0 0 0 0 0 0 0 0 0 0
        0 0 20 0 0 0 25 35 0 0]

# vec_result_x = reshape(transpose(vec_x), numNodes^2)
vec_result_node = zeros(numNodes)
for m = 1: numNodes
    vec_result_node[m] = sum(vec_x[(10 * m - 9): (10 * m)]) - sum(vec_x[(seq_zeroTenNinety + repeat([m],10))])
end
vec_y= [0 1 0 0 0 0 0 0 0 0
        0 0 0 0 0 1 0 0 0 0
        0 0 0 0 0 0 0 0 0 1
        1 0 0 0 1 0 0 0 0 0
        0 0 0 0 0 1 0 0 0 0
        1 1 0 1 1 0 0 1 0 0
        0 1 1 0 0 0 0 0 0 0
        0 0 0 0 0 0 0 0 1 0
        0 0 0 0 1 0 0 0 0 0
        0 0 1 0 0 1 1 1 1 0]
