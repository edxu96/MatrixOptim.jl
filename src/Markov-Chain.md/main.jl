## main file for Markov chain related structs and functions


"Check if all the probabilities are greater equal than 0."
function check_prob(mat_prob::Union{Array{Float64,2}, Array{Int64,1}})
    if all(mat_prob .<= 0)
        throw("All probabilities must be greater equal than 0.")
    end
end


"Check if all the summations of rows in stpm are 1."
function check_prob_sum(stpm::Array{Float64,2})
    n_row = size(stpm)[1]
    if all(stpm * ones(n_row, 1) .== 1)
        throw("The sum of probabilities in $i-th row doesn't equal to 1.")
    end
end


"Calculate limiting probability distribution of a Markov chain family."
function cal_vec_lpd(stpm::Array{Float64,2})

    hcat([1; 1; 1])
    return vec_lpd
end


"Define the non-mutable struct for Markov chain family."
struct MarkovChainFamily
    stpm::Array{Float64,2}  # [Stationary Transition Probability Matrix]
    vec_lpd::Array{Float64,2}  # [Limiting Probability Distribution]

    function MarkovChainFamily(stpm::Array{Float64,2})
        check_prob(stpm)
        check_prob_sum(stpm)

        vec_lpd = cal_vec_lpd(stpm)

        new(stpm, vec_lpd)
    end
end
