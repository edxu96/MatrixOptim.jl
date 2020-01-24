## Metsa-Oy Forest Products Supply Chain
## Edward J. Xu <edxu96@outlook.com>
## Jan 24th, 2020


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
  mat3_value =
  mat3_value = [value(mat3_x[i, j, k]) for i=1:m, j=1:n, k=1:o]

  return mat3_value
end


"Get the optimized value of a 4-D decision matrix."
function value_mat4(mat4_x::Array{VariableRef,4})
  m, n, o, p = size(mat4_x)
  mat4_value = [value(mat4_x[i, j, k, l]) for i=1:m, j=1:n, k=1:o, l=1:p]

  return mat4_value
end


"Get the optimized value of decision matrix."
function value_mat_extra1(mat_x)
  m, n = size(mat_x)
  mat_value = zeros(m, n+1)
  for i=1:m, j=2:(n+1)
    mat_value[i, j] = value(mat_x[i, j])
  end

  return mat_value
end


"Get the optimized value of a 3-D decision matrix."
function value_mat3_extra1(mat3_x)
  m, n, o = size(mat3_x)
  mat3_value = zeros(m, n+1, o)
  for i=1:m, j=2:(n+1), k=1:o
    mat3_value[i, j, k] = value(mat3_x[i, j, k])
  end

  return mat3_value
end


"Get the optimized value of a 4-D decision matrix."
function value_mat4_extra1(mat4_x)
  m, n, o, p = size(mat4_x)
  mat4_value = zeros(m, n+1, o, p)
  for i=1:m, j=2:(n+1), k=1:o, l=1:p
    mat4_value[i, j, k, l] = value(mat4_x[i, j, k, l])
  end

  return mat4_value
end
