## DTU42380a2: Supply Networks and Inventory
## Edward J. Xu
## April 10, 2020
## Data and Functions

function get_data()
  # demands = [
  #   640000.00	400000.00	320000.00	440000.00	700000.00	350000.00;
  #   1152000.00	720000.00	576000.00	792000.00	1260000.00	630000.00;
  #   2073600.00	1296000.00	1036800.00	1425600.00	2268000.00	1134000.00
  #   ]  # demands[s, v]

  demands = [
    640000.00	400000.00	320000.00	440000.00	700000.00	350000.00;
    1216000.00	760000.00	608000.00	836000.00	1330000.00	665000.00;
    2310400.00	1444000.00	1155200.00	1588400.00	2527000.00	1263500.00
    ]  # demands[s, v]

  costs_ship = [
    0.50	0.63	0.88	1.00	1.25	1.38;
    0.63	0.63	0.63	0.75	1.00	1.13;
    0.88	0.88	0.63	0.63	0.75	0.88;
    1.00	1.00	0.75	0.63	0.75	0.63;
    1.13	1.25	0.75	0.88	0.63	1.00
    ]  # costs_fix[l, v]

  costs_fix = [
    300000.00 500000.00
    250000.00 420000.00
    220000.00 375000.00
    220000.00 375000.00
    240000.00 400000.00
    ]  # costs_fix[l, w]

  cost_var = 0.2

  q = [2 4] * 1000000  # q[w]

  e = [
    1 1 0;
    0 1 1;
    1 1 1;
    0 0 1;
    0 0 0
    ]  # e[p, s]

  return demands, costs_ship, costs_fix, cost_var, q, e
end


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
