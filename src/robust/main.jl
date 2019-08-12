# Robust Optimization
# 1. Function for MILP with Box Uncertainty and Budget of Uncertainty
# 2. Fucntion for Two-Stage Stochastic LP with Box Uncertainty
# Version: 4.0
# Author: Edward J. Xu, edxu96@outlook.com
# Date: August 11, 2019

include("./box.jl")


"""
Fucntion for Two-Stage Stochastic MILP with Box Uncertainty
"""
function milpAdjustBox(; num_x, num_y, num_z, vec_min_y, vec_max_y, vec_c, vec_f, vec_g, vec_b,
    mat_a, mat_b, mat_d, mat_a_bar, mat_a_hat, mat_b_bar, mat_d_bar, vec_b_bar)
    println("---------------------------------------------------------\n",
            "   1/2. Adjustable Robust LP with Box Uncertainty\n",
            "---------------------------------------------------------\n")
    model = Model(with_optimizer(GLPK.Optimizer))
    # 1. Standard LP
    @variable(model, vec_y[1: num_y], Int)
    @constraint(model, vec_y >= vec_min_y)
    @constraint(model, vec_max_y >=  vec_y)
    @variable(model, vec_x[1: num_x] >= 0)
    @variable(model, gamma)
    @variable(model, vec_alpha[1: num_z])
    @variable(model, vec_theta1[1: num_z])
    @objective(model, Min, (transpose(vec_f) * vec_y + transpose(vec_c) * vec_x)[1] + gamma)
    @constraint(model, mat_b * vec_y + mat_a * vec_x + mat_d * (vec_alpha + vec_theta1) .>= vec_b)
    # 2. Get rid of the uncertainty in objective function
    @variable(model, vec_beta[1: num_z])
    @constraint(model, gamma >= (transpose(vec_g) * (vec_alpha + vec_theta1))[1])
    @constraint(model, vec_theta1 .<= vec_beta)
    @constraint(model, - vec_beta .<= vec_theta1)
    @constraint(model, vec_alpha .>= - vec_theta1)  # z(zeta) must be greater than 0
    # 3. Transformation of Box Uncertainty.
    @variable(model, vec_theta2[1: num_z])
    vec_theta2_rep = (ones(num_y, num_z) .* vec_theta2')[:]  # Repeat every theta2 num_y times and then concatenate.
    @constraint(model, mat_b_bar * vec_y + mat_a_bar * vec_x + mat_a_hat * vec_theta2_rep +
        mat_d_bar * (vec_alpha + vec_theta1) .<= vec_b_bar)
    @constraint(model, vec_theta2_rep .<= vec_x)
    @constraint(model, - vec_x .<= vec_theta2_rep)
    # @constraint(model, [m = 1: num_y], sum([mat_a_bar[m, (p-1) * num_y + m] * vec_x[(p-1) * num_y + m] + vec_theta2[p]]
    #     for p = 1: 10)[1] + mat_b_bar[m, m] * vec_y[m] <= vec_b_bar[m])
    # @constraint(model, [m = 1: num_y, p = 1: num_z], - mat_a_hat[m, (p-1) * num_y + m] * vec_x[(p-1) * num_y + m]
    #     <= vec_theta2[p])
    # @constraint(model, [m = 1: num_y, p = 1: num_z], vec_theta2[p] <=
    #     mat_a_hat[m, (p-1) * num_y + m] * vec_x[(p-1) * num_y + m])
    # Solve the model
    optimize!(model)
    obj_result = objective_value(model)
    vec_result_y = value(vec_y)
    println("Result: vec_y = $vec_result_y.")
    vec_result_x = value(vec_x)
    println("Result: vec_x = $vec_result_x.")
    vec_result_theta1 = value(vec_theta1)
    vec_result_theta2 = value(vec_theta2)
    vec_result_gamma = value(gamma)
    println("---------------------------------------------------------\n",
            "   2/2. Nominal Ending\n",
            "---------------------------------------------------------\n")
    return (obj_result, vec_result_y, vec_result_x, vec_result_gamma, vec_result_theta1, vec_result_theta2)
end

"""
Fucntion for Two-Stage Stochastic LP with Box Uncertainty
"""
function lpAdjustBox(; num_x, m, num_z, vec_c, vec_g, vec_b,
    mat_a, mat_d, mat_a_bar, mat_a_hat, mat_d_bar, vec_b_bar)
    println("---------------------------------------------------------\n",
            "   1/2. Adjustable Robust LP with Box Uncertainty\n",
            "---------------------------------------------------------\n")
    model = Model(with_optimizer(GLPK.Optimizer))
    # 1. Standard LP
    @variable(model, vec_x[1: num_x] >= 0)
    @variable(model, gamma)
    @variable(model, vec_alpha[1: num_z])
    @variable(model, vec_theta1[1: num_z])
    @objective(model, Min, (transpose(vec_c) * vec_x)[1] + gamma)
    @constraint(model, mat_a * vec_x + mat_d * (vec_alpha + vec_theta1) .>= vec_b)
    # 2. Get rid of the uncertainty in objective function
    @variable(model, vec_beta[1: num_z])
    @constraint(model, gamma >= (transpose(vec_g) * (vec_alpha + vec_theta1))[1])
    @constraint(model, vec_theta1 .<= vec_beta)
    @constraint(model, - vec_beta .<= vec_theta1)
    @constraint(model, vec_alpha .>= - vec_theta1)  # z(zeta) must be greater than 0
    # 3. Transformation of Box Uncertainty.
    @variable(model, vec_theta2[1: num_z])
    vec_theta2_rep = (ones(m, num_z) .* vec_theta2')[:]  # Repeat every theta2 num_y times and then concatenate.
    @constraint(model, mat_a_bar * vec_x + mat_a_hat * vec_theta2_rep +
        mat_d_bar * (vec_alpha + vec_theta1) .<= vec_b_bar)
    @constraint(model, vec_theta2_rep .<= vec_x)
    @constraint(model, - vec_x .<= vec_theta2_rep)
    # Solve the model
    optimize!(model)
    obj_result = objective_value(model)
    # println("Result: obj = $(obj).")
    vec_result_x = value(vec_x)
    # println("Result: vec_x = $vec_result_x.")
    vec_result_theta1 = value(vec_theta1)
    vec_result_theta2 = value(vec_theta2)
    vec_result_gamma = value(gamma)
    println("---------------------------------------------------------\n",
            "   2/2. Nominal Ending\n",
            "---------------------------------------------------------\n")
    return (obj_result, vec_result_x, vec_result_gamma, vec_result_theta1, vec_result_theta2)
end

"""
Fucntion for LP with Box Uncertainty
"""
function lpBox(; num_x, m, num_z, vec_c, vec_b, mat_a, mat_a_bar, mat_a_hat, vec_b_bar)
    println("---------------------------------------------------------\n",
            "   1/2. Adjustable Robust LP with Box Uncertainty\n",
            "---------------------------------------------------------\n")
    model = Model(with_optimizer(GLPK.Optimizer))
    # 1. Standard LP
    @variable(model, vec_x[1: num_x] >= 0)
    @objective(model, Min, (transpose(vec_c) * vec_x)[1])
    @constraint(model, mat_a * vec_x .>= vec_b)
    # 2. Transformation of Box Uncertainty.
    @variable(model, vec_theta2[1: m])
    vec_theta2_rep = (ones(m, num_z) .* vec_theta2')[:]  # Repeat every theta2 num_y times and then concatenate.
    @constraint(model, mat_a_bar * vec_x + mat_a_hat * vec_theta2_rep .<= vec_b_bar)
    @constraint(model, vec_theta2_rep .<= vec_x)
    @constraint(model, - vec_x .<= vec_theta2_rep)
    # Solve the model
    optimize!(model)
    obj_result = objective_value(model)
    # println("Result: obj = $(obj).")
    vec_result_x = value(vec_x)
    # println("Result: vec_x = $vec_result_x.")
    vec_result_theta2 = value(vec_theta2)
    println("---------------------------------------------------------\n",
            "   2/2. Nominal Ending\n",
            "---------------------------------------------------------\n")
    return (obj_result, vec_result_x, vec_result_theta2)
end
