# Dantzig-Wolfe Reformulation and Column Generation
# Data for General Assignment Problem 1
# Edward J. Xu
# 2019.5.1


function getData()
    vec_c = [6 4 6 1 3 4 1 2 8]
    mat_a =[
    1 0 0 1 0 0 1 0 0 ;
    0 1 0 0 1 0 0 1 0 ;
    0 0 1 0 0 1 0 0 1 ;
    7 2 8 0 0 0 0 0 0 ;
    0 0 0 8 7 6 0 0 0 ;
    0 0 0 0 0 0 9 1 9]
    vec_b = hcat([1;1;1;9;7;10])
    index_sub = [[1,2,3], [4,5,6], [7,8,9]]
    num_sub = 3
    return (vec_c, mat_a, vec_b, index_sub, num_sub)
end


(vec_c, mat_a, vec_b, index_sub, num_sub) = getData()
