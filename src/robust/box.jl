
"""
        milpBoxBudget(; num_x, num_y, vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_a,
                mat_b, mat_a_bar, mat_a_hat, mat_b_bar, vec_b_bar, vec_gammaCap)

Function for MILP with Box Uncertainty and Budget of Uncertainty
"""
function milpBoxBudget(; num_x, num_y, vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_a, mat_b,
    mat_a_bar, mat_a_hat, mat_b_bar, vec_b_bar, vec_gammaCap)
    m = length(mat_a_bar[:,1])
    n = length(mat_a_bar[1,:])
    for i = 1: m
        if vec_gammaCap[i] > n
            println("Error: vec_gammaCap[$i] is greater than m in nominal and hat data!")
        end
    end
    println("---------------------------------------------------------\n",
            "    1/2. Robust MILP with Box Uncertainty and Budget\n",
            "---------------------------------------------------------\n")
    println("Input: vec_gammaCap = $vec_gammaCap.")
    #
    model = Model(with_optimizer(GLPK.Optimizer))
    @variable(model, vec_y[1: num_y], Int)
    @variable(model, vec_x[1: num_x] >= 0)
    @objective(model, Min, (transpose(vec_c) * vec_x + transpose(vec_f) * vec_y)[1])
    @constraint(model, vec_y[1: num_y] .<= vec_max_y)
    @constraint(model, vec_y[1: num_y] .>= vec_min_y)
    @constraint(model, mat_a * vec_x + mat_b * vec_y .>= vec_b)
    # Transformation of Box Uncertainty.
    @variable(model, vec_lambda[1: m] >= 0)
    @variable(model, mat_mu[1: m, 1: num_x] >= 0)
    @variable(model, vec_z[1: num_x] >= 0)
    @constraint(model, - vec_z .<= vec_x)
    @constraint(model, vec_x .<= vec_z)
    for i = 1: m
        # sum() of variables without coefficients can be used directly
        @constraint(model, transpose(mat_a_bar[i, :]) * vec_x + vec_gammaCap[i] * vec_lambda[i] +
            sum(mat_mu[i, :]) + transpose(mat_b_bar[i, :]) * vec_y <= vec_b_bar[i])
        @constraint(model, vec_lambda[i] .+ hcat(mat_mu[i, :]) .>=  hcat(mat_a_hat[i, :]) .* vec_z[:])
    end
    optimize!(model)
    obj_result = objective_value(model)
    vec_result_y = value(vec_y)
    println("Result: vec_y = $vec_result_y.")
    vec_result_x = value(vec_x)
    println("Result: vec_x = $vec_result_x.")
    vec_result_z = value(vec_z)
    mat_result_mu = value(mat_mu)
    vec_result_lambda = value(vec_lambda)
    println("---------------------------------------------------------\n",
            "   2/2. Nominal Ending\n",
            "---------------------------------------------------------\n")
    return (obj_result, vec_result_y, vec_result_x, vec_result_z, mat_result_mu, vec_result_lambda)
end

"""
Function for LP with Box Uncertainty and Budget of Uncertainty
"""
function lpBoxBudget(; num_x, vec_c, vec_b, mat_a, mat_a_bar, mat_a_hat, vec_b_bar, vec_gammaCap)
    m = length(mat_a_bar[:,1])
    n = length(mat_a_bar[1,:])
    for i = 1: m
        if vec_gammaCap[i] > n
            println("Error: vec_gammaCap[$i] is greater than m in nominal and hat data!")
        end
    end
    println("---------------------------------------------------------\n",
            "    1/2. Robust MILP with Box Uncertainty and Budget\n",
            "---------------------------------------------------------\n")
    println("Input: vec_gammaCap = $vec_gammaCap.")
    #
    model = Model(with_optimizer(GLPK.Optimizer))
    @variable(model, vec_x[1: num_x] >= 0)
    @objective(model, Min, (transpose(vec_c) * vec_x)[1])
    # Transformation of Box Uncertainty.
    @variable(model, vec_lambda[1: m] >= 0)
    @variable(model, mat_mu[1: m, 1: num_x] >= 0)
    @variable(model, vec_z[1: num_x] >= 0)
    @constraint(model, - vec_z .<= vec_x)
    @constraint(model, vec_x .<= vec_z)
    for i = 1: m
        # sum() of variables without coefficients can be used directly
        @constraint(model, transpose(mat_a_bar[i, :]) * vec_x + vec_gammaCap[i] * vec_lambda[i] +
            sum(mat_mu[i, :]) <= vec_b_bar[i])
        @constraint(model, vec_lambda[i] .+ hcat(mat_mu[i, :]) .>=  hcat(mat_a_hat[i, :]) .* vec_z[:])
    end
    optimize!(model)
    obj_result = objective_value(model)
    vec_result_x = value(vec_x)
    # println("Result: vec_x = $vec_result_x.")
    vec_result_z = value(vec_z)
    mat_result_mu = value(mat_mu)
    vec_result_lambda = value(vec_lambda)
    println("---------------------------------------------------------\n",
            "   2/2. Nominal Ending\n",
            "---------------------------------------------------------\n")
    return (obj_result, vec_result_x, vec_result_z, mat_result_mu, vec_result_lambda)
end
