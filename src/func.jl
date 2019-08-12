

function value_vec(vec_x::Union{Array{VariableRef,1}, VariableRef})
    if isa(vec_x, VariableRef)
        vec_value = value(vec_x)
    else
        vec_value = [value(vec_x[i]) for i = 1:length(vec_x)]
    end
    
    return vec_value
end


function dual_vec(vec_cons)
    return [dual(vec_cons[i]) for i = 1:length(vec_cons)]
end


@enum ColRow begin
   row = 1
   col = 2
end


function checkColVec(vec::Array{Int64,2}, str_name::String)
    if size(vec)[Int(col)] != 1
        throw("$str_name is not a column vector")
    end
end


function checkMatrixMatch(array_1::Array{Int64,2}, array_2::Array{Int64,2}, whi_1::ColRow, whi_2::ColRow,
    str_name_1::String, str_name_2::String)
    if size(array_1)[Int(whi_1)] != size(array_2)[Int(whi_2)]
        throw("The $(str(whi_1)) of $str_name_1 doesn't match the $(str(whi_2)) of $str_name_2.")
    end
end
