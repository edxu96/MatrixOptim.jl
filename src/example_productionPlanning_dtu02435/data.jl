# Data for Robust Optimization
# Version: 1.0
# Date: April 7th, 2019
# 1. Data Import -------------------------------------------------------------------------------------------------------
file = openxl("data.xlsx")
vec_timeProdDev = readxl(file, "timeProdDev!B2:B11")
vec_costInvest = readxl(file, "costInvest!B2:B5")
vec_costProd = readxl(file, "costProd!B2:B11")
vec_demand = readxl(file, "demand!B2:B11")
mat_prodOnMachine = readxl(file, "prodOnMachine!B2:E11")
vec_timeAvai = readxl(file, "timeAvai!B2:B5")
vec_timeProd = readxl(file, "timeProd!B2:B11")
# 2. Data Process ------------------------------------------------------------------------------------------------------
# Function to calculate parameters
function paras_budgetMILP(num_x, num_y)
    vec_c = hcat(zeros(num_x))
    for i = 1: 4
        vec_c[(4 * i - 3): (4 * i), 1] = repeat([vec_costProd[i]], num_y)
    end
    vec_f = hcat(vec_costInvest)
    vec_b = hcat(repeat([0], 50))
    vec_b[1: 10, 1] = vec_demand
    # mat_a
    mat_a_1 = zeros(10, num_x)
    for i = 1: 10
        mat_a_1[i, (4 * i - 3): (4 * i)] = repeat([1], 4)
    end
    mat_a_2 = zeros(num_x, num_x)
    for i = 1: num_x
        mat_a_2[i, i] = -1
    end
    mat_a = vcat(mat_a_1, mat_a_2)
    # mat_b
    mat_b_1 = zeros(10, 4)
    mat_b_2 = zeros(num_x, 4)
    epsilon = 0.000001  # epsilon must be large enough.
    # ??? It seems that the epsilon can make a difference in the final result, thought it's large enough.
    for i = 1: 10
        for j = 1: 4
            mat_b_2[(4 * i - 4 + j), j] = mat_prodOnMachine[i, j] * 1 / epsilon
        end
    end
    mat_b = vcat(mat_b_1, mat_b_2)
    # mat_a_bar
    mat_a_bar = zeros(4, num_x)
    for i = 1: 10
        for j = 1: 4
            mat_a_bar[j, (4 * i - 4 + j)] = vec_timeProd[i]
        end
    end
    mat_a_hat = zeros(4, num_x)
    for i = 1: 10
        for j = 1: 4
            mat_a_hat[j, (4 * i - 4 + j)] = vec_timeProdDev[i]
        end
    end
    mat_b_bar = zeros(4, 4)
    for i = 1: 4
        mat_b_bar[i, i] = - vec_timeAvai[i]
    end
    vec_b_bar = hcat(zeros(4))
    #
    return (vec_c, vec_f, vec_b, mat_a, mat_b, mat_a_bar, mat_a_hat, mat_b_bar, vec_b_bar)
end

function paras_stochasticLP(num_x, num_y, penalty)
    (vec_c, vec_f, vec_b, mat_a, mat_b, mat_a_bar, mat_a_hat, mat_b_bar, vec_b_bar) = paras_budgetMILP(num_x, num_y)
    #
    vec_g = hcat(penalty * ones(10, 1))
    mat_d_1 = zeros(10, 10)
    mat_d_1[diagind(mat_d_1)] .= 1
    mat_d_2 = zeros(num_x, 10)
    mat_d = vcat(mat_d_1, mat_d_2)
    mat_d_bar = zeros(4, 10)
    return (vec_c, vec_f, vec_b, mat_a, mat_b, mat_a_bar, mat_a_hat, mat_b_bar, vec_b_bar, vec_g, mat_d, mat_d_bar)
end
