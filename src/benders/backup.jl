

dict_obj_mas = Dict()
dict_q = Dict()
dict_obj_sub = Dict()
dict_obj_ray = Dict()
dict_boundUp = Dict()
dict_boundLow = Dict()


function print_result(args)
    println("Master Problem")
    println("    obj_mas: $(objective_value(mod_mas))")
    # println(mod_mas)
    println("Final Result")
    println("    boundUp: $(round(boundUp, digits = 5)), boundLow: $(round(boundLow, digits = 5)), ",
            "difference: $(round(boundUp - boundLow, digits = 5))")
    println("    vec_x: $vec_result_x")
    vec_result_y = value_vec(vec_y)
    result_q = value_vec(q)
    println("    vec_y: $vec_result_y")
    println("    result_q: $result_q")
    println("Iteration Result")
    # Initialize
    seq_timesIteration = collect(1: (timesIteration - 1))
    vec_boundUp = zeros(timesIteration - 1)
    vec_boundLow = zeros(timesIteration - 1)
    vec_obj_subRay = zeros(timesIteration - 1)
    vec_obj_mas = zeros(timesIteration - 1)
    vec_q = zeros(timesIteration - 1)
    vec_type = repeat(["ray"], (timesIteration - 1))
    #
    for i = 1: (timesIteration - 1)
        vec_obj_mas[i] = round(dict_obj_mas[i], digits = 5)
        vec_boundUp[i] = round(dict_boundUp[i], digits = 5)
        vec_boundLow[i] = round(dict_boundLow[i], digits = 5)
        vec_q[i] = round(dict_q[i], digits = 5)
        if haskey(dict_obj_sub, i)
            vec_type[i] = "sub"
            vec_obj_subRay[i] = round(dict_obj_sub[i], digits = 5)
        else
            vec_obj_subRay[i] = round(dict_obj_ray[i], digits = 5)
        end
    end
    table_iterationResult = hcat(
        seq_timesIteration, vec_boundUp, vec_boundLow, vec_obj_mas, vec_q,
        vec_type, vec_obj_subRay
        )
    pretty_table(
        table_iterationResult,
        ["Seq", "boundUp", "boundLow", "obj_mas", "q", "sub/ray",
            "obj_sub/ray"],
        compact; alignment=:l)
end


function store_ite()
    dict_boundUp[timesIteration] = boundUp
    dict_boundLow[timesIteration] = boundLow
    if bool_solution_sub
        dict_obj_mas[timesIteration] = obj_mas
        dict_obj_sub[timesIteration] = obj_sub
        result_q = value_vec(q)
        dict_q[timesIteration] = result_q
        println("Result in $(timesIteration)-th Iteration with Sub \n    ",
                "UB: $(round(boundUp, digits = 5)) ; ",
                "LB: $(round(boundLow, digits = 5)) ; ",
                "obj_mas: $(round(obj_mas, digits = 5)) ; ",
                "q: $result_q ; obj_sub: $(round(obj_sub, digits = 5)) ;")
    else
        dict_obj_mas[timesIteration] = obj_mas
        dict_obj_ray[timesIteration] = obj_ray
        result_q = value_vec(q)
        dict_q[timesIteration] = result_q
        println("Result in $(timesIteration)-th Iteration with Ray \n    ",
                "UB: $(round(boundUp, digits = 5)) ; ",
                "LB: $(round(boundLow, digits = 5)) ; ",
                "obj_mas: $(round(obj_mas, digits = 5)) ; ",
                "q: $result_q ; obj_ray: $(round(obj_ray, digits = 5)) ;")
    end
end
