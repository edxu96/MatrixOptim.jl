# Julia Module Manipulate the Coefficient Matrix in Standard LP or MILP Problem
# Version: 2.0
# Auther: Edward J. Xu
# Date: Aprial 7th, 2019
module CoeffMatrix
# Function to initiate the coefficient matrix, update the last row, or add a row in the last.
# 1. default double-script order:
#   |     n(j)|
#   |m(i)  *  |
#
# 2. default single-script order: k = (j - 1) * m + i (To bottom, then right)
#    to convert back: i = k % m
#                     j = Int8((k - i) / m)
#
# 3. if inverse == TURE, use inversed single-script order: k = (i - 1) * n + j (To right, then bottom)
#    to convert back: j = k % n
#                     i = Int8((k - j) / n)
#
function updateRow(; mat_coeff = 0, add = false, m, n, mat_para,
    vec_i_x, vec_j_x, vec_i_a = vec_i_x, vec_j_a = vec_j_x, inverse = false)
    num_x = m * n
    # 1. Check if m, n and mat_coeff are coherent.
    if mat_coeff != 0
        (num_row_coeff, num_col_coeff) = size(mat_coeff)
        if num_x != num_col_coeff
            print("Wrong m or n, of which the product should be same with col number of mat_coeff!")
        end
    end
    # 2. Generate mat_para_cal with same row and col numbers with mat_x, if mat_para is not a matrix
    if isa(mat_para, Number)  # If mat_para is a number or a vector, generate a m*n matrix for later use
        mat_para_cal = mat_para * ones(m, n)
    end
    # If row vector, check if col number equals that of mat_x.
    # If col vector, check if row number equals that of mat_x.
    (num_row_a, num_col_a) = size(mat_para)
    if ((num_row_a != 1) && (num_row_a != m)) || ((num_col_a != 1) && (num_col_a != n))
        print("Wrong mat_para, which should be vector or a matix in same size with mat_x!")
        return (mat_coeff, mat_para)
    elseif num_row_a < m  # if mat_para is a row vector, duplicate it to m-row matrix
        mat_para_cal = ones(m, n)
        for i = 1: m
            mat_para_cal[i, :] = mat_para[1, :]
        end
        mat_para = mat_para_new
    elseif num_col_a < n  # if mat_para is a strict column vector, duplicate it to n-column matrix
        mat_para_cal = ones(m, n)
        for j = 1: n
            mat_para_cal[:, j] = mat_para[:, 1]
        end
    else
        mat_para_cal = mat_para
    end
    # 3. Calculate the new row vector for coefficient matrix
    vecRow_coeff_new = zeros(1, num_x)
    for p = 1: length(vec_i_x)
        for q = 1: length(vec_j_x)
            i = vec_i_x[p]
            j = vec_j_x[q]
            if inverse  # inverse single-script order
                k = (i - 1) * n + j  # To right, then bottom
                vecRow_coeff_new[(i - 1) * n + vec_j_x[j]] = mat_para_cal[vec_i_a[p], vec_j_a[q]]
            else  # default single-script order
                k = (j - 1) * m + i  # To bottom, then right
                vecRow_coeff_new[k] = mat_para_cal[vec_i_a[p], vec_j_a[q]]
            end
        end
    end
    # 4. Update the last row of coefficient matrix or add a row in the last, if "add = 1".
    if mat_coeff == 0  # Initiate the coefficient matrix, if no coefficient matrix input.
        mat_coeff = vecRow_coeff_new
    elseif add  # Add a row in the last
        mat_coeff = vcat(mat_coeff, vecRow_coeff_new)
    else  # Update the last row
        mat_coeff[num_row_coeff, :] = mat_coeff[num_row_coeff, :] + transpose(vecRow_coeff_new)
    end
    return (mat_coeff, mat_para_cal)
end
# Example:
# mat_para = [99.74  99.21  100.21  99.76  100.48  100.7  99.42  99.11  97.69  98.94  97.22  98.99;
#          1.89   2.02   1.95    2.16   2.16    2.08   2.08   2.09   1.97   1.99   1.89   1.95;
#          15.58  15.11  14.93   14.86  15.06   15.51  14.41  14.96  15.62  14.4   15.64  14.52]
# (mat_coeff, mat_para_cal) = updateRow(m = 3, n = 12, mat_para = - hcat(mat_para[:,1]),
#     vec_i_x = [1 2 3], vec_j_x = [1])
# (mat_coeff, mat_para_cal) = updateRow(add = 1, mat_coeff = mat_coeff, m = 3, n = 12,
#     mat_para = - mat_para, vec_i_x = [1 2 3], vec_j_x = collect(2: 1: 12))
# (mat_coeff, mat_para_cal) = updateRow(add = 1, mat_coeff = mat_coeff, m = 3, n = 12,
#     mat_para = mat_para, vec_i_x = [1 2 3], vec_j_x = collect(1: 1: 11), vec_j_a = collect(1: 1: 11) .+ 1)
end  # module CoeffMatrix
