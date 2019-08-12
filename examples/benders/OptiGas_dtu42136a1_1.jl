# OptiGas: Optimize Gas Network using Benders Algorithm
# Author: Edward J. Xu, edxu96@outlook.com
# Date: Aug 12, 2019

using LinearAlgebra
using MatrixOptim


function getData()
    vec_nameNodes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    numNodes = length(vec_nameNodes)
    vec_xNode = [1    3    8    2    4    5    6    7    9    9]
    vec_yNode = [1    2    1    7    9    5    3    7    9    4]
    mat_arcTwoNodes = [
        0    1    0    0    0    0    0    0    0    0;
        0    0    0    0    0    1    0    0    0    0;
        0    0    0    0    0    0    0    0    0    1;
        1    0    0    0    1    0    0    0    0    0;
        0    0    0    0    0    1    0    0    0    0;
        1    0    0    1    0    0    0    1    0    0;
        0    1    1    0    0    0    0    0    0    0;
        0    0    0    0    0    0    0    0    1    0;
        0    0    0    0    1    0    0    0    0    0;
        0    0    0    0    0    1    1    0    1    0
    ]
    vec_netEject = [0    0   0    0    0   90    0    0   0   80 ]
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
    return numNodes, vec_netEject, vec_netInject, mat_distance, mat_fixedCost
end


function getModelQ4(numNodes, vec_netEject, vec_netInject, mat_distance, mat_fixedCost)
    # Fomulation of mat_aCap
    mat_aCap_1 = zeros(numNodes^2, numNodes^2)
    for mn = 1: numNodes^2
        mat_aCap_1[mn, mn] = -1
    end
    # mat_a2_1 = zeros(numNodes^2, numNodes^2)
    mat_aCap_3 = zeros(numNodes, numNodes^2)
    seq_zeroTenNinety = collect(0:10:90)
    for m = 1: numNodes
        mat_aCap_3[m, (10 * m - 9): (10 * m)] = repeat([-1], 10)  # sent out
        mat_aCap_3[m, (seq_zeroTenNinety + repeat([m],10))] = repeat([1], 10)  # sent in
        mat_aCap_3[:, (11 * m - 10)] = repeat([0], 10)  # self-sending doesn't count
    end
    mat_aCap = vcat(mat_aCap_1, mat_aCap_3)

    # Fomulation of Matrix B
    mat_bCap_1 = zeros(numNodes^2, numNodes^2)
    for mn = 1: numNodes^2
        mat_bCap_1[mn, mn] = 170
    end
    # mat_b2_1 = Diagnal(repeat([1], numNodes^2))
    mat_bCap_3 = zeros(numNodes, numNodes^2)
    mat_bCap = vcat(mat_bCap_1, mat_bCap_3)

    # Fomulation of Vector b
    vec_bCap_1 = zeros(numNodes^2)
    # vec_b2_1 = zeros(numNodes^2)
    # for m = 1: numNodes
    #     for n = 1: numNodes
    #         vec_b2_1[10 * (m - 1) + n] = mat_arcTwoNodes[m, n]
    #     end
    # end
    vec_bCap_3 = zeros(numNodes)
    for n = 1: numNodes
        vec_bCap_3[n] = vec_netInject[n] - vec_netEject[n]
    end
    vec_b = vcat(vec_bCap_1, vec_bCap_3)
    vec_b = hcat(vec_b)

    vec_y_max = repeat([1], numNodes^2)
    vec_y_max = hcat(vec_y_max)
    vec_y_min = zeros(numNodes^2)
    for m = 1: numNodes
        for n = 1: numNodes
            vec_y_min[10 * (m - 1) + n] = mat_arcTwoNodes[m, n]
        end
    end

    vec_c = zeros(numNodes^2)
    for m = 1: numNodes
        for n = 1: numNodes
            vec_c[10 * (m - 1) + n] = mat_distance[m, n]
        end
    end
    vec_c = hcat(vec_c)

    vec_f = zeros(numNodes^2)
    for m = 1: numNodes
        for n = 1: numNodes
            vec_f[10 * (m - 1) + n] = mat_fixedCost[m, n]
        end
    end
    vec_f = hcat(vec_f)

    return vec_c, mat_aCap, vec_b, vec_f, vec_bCap, vec_y_min, vec_y_max
end


function main()
    numNodes, vec_netEject, vec_netInject, mat_distance, mat_fixedCost = getData()
    vec_c, mat_aCap, vec_b, vec_f, vec_bCap, vec_y_min, vec_y_max = getModelQ4(
        numNodes, vec_netEject, vec_netInject, mat_distance, mat_fixedCost
    )
    solveBendersMilp(
        n_x = numNodes^2,
        n_y = numNodes^2,
        vec_min_y = vec_y_min,
        vec_max_y = vec_y_max,
        vec_c = vec_c,
        vec_f = vec_f,
        vec_b = vec_b,
        mat_a = mat_aCap,
        mat_b = mat_bCap,
        epsilon = 0.0001,
        timesIterationMax = 1000
    )
    # 1280 - sum(mat_arcTwoNodes .* mat_fixedCost)
end


main()
