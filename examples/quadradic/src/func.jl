## Metsa-Oy Forest Products Supply Chain
## Edward J. Xu <edxu96@outlook.com>
## Jan 23rd, 2020


"Get the optimized value of decision vector."
function value_vec(vec_x::Union{Array{VariableRef,1}, VariableRef})
    if isa(vec_x, VariableRef)
        vec_value = value(vec_x)
    else
        vec_value = [value(vec_x[i]) for i = 1:length(vec_x)]
    end

    return vec_value
end


"Get the optimized value of decision matrix."
function value_mat(mat_x::Array{VariableRef,2})
  m, n = size(mat_x)
  mat_value = [value(mat_x[i, j]) for i=1:m, j=1:n]

  return mat_value
end


"Get the optimized value of a 3-D decision matrix."
function value_mat3(mat3_x::Array{VariableRef,3})
  m, n, o = size(mat3_x)
  mat3_value = [value(mat3_x[i, j, k]) for i=1:m, j=1:n, k=1:o]

  return mat3_value
end
