
# MatrixOptim.jl

MILP, Robust Optim. and Stochastic Optim., and Decomposition Algorithm in Matrix (by Julia)

[![Build Status](https://travis-ci.org/edxu96/MatrixOptim.jl.svg?branch=master)](https://travis-ci.org/edxu96/MatrixOptim.jl)

![Tangram](/images/tangram_1.png)

Every optimization problem can be written in matrix form. For some problems, it may seems trivial, but it's coherent and easy to understand. Besides, when it comes to algorithms to solve them, it's more explicit in matrix form. Finally, the abstraction algorithm for problem modeling helps a lot in understanding. In this package, there are formulated algorithm for four kinds of optimization problems, and two decomposition algorithms for faster MILP solving. I also write cookbooks to explain the algorithms in more detail.

## Introduction

The MILP can always be formulated in the following matrixes:

```
min  vec_c' * vec_x + vec_f' * vec_y
s.t. mat_A * vec_x + mat_B * vec_y <= vec_b
     vec_x in R
     vec_y in Z
```

## To Install and Test

```
(v1.1) pkg> add MatrixOptim
```

```
(v1.1) pkg> test MatrixOptim
```

## How to Use

For mixed integer linear programming:

```Julia
model = getModel(vec_c, mat_aa, vec_b)
solveModel!(model)
```

For mixed integer linear programming with Benders decomposition:

```Julia
model = getModelBenders(n_x, n_y, vec_min_y, vec_max_y, vec_c, vec_f, vec_b, mat_aa, mat_bb)
solveModelBenders!(model)
```

Right now, the supported solver is `GLPK`. I will add the feature to select other solvers, like `Gurobi` and `CPLEX` later.

## Features

- [x] Linear Programming
- [x] Mixed Integer Linear Programming
- [ ] Robust Optimization
- [ ] Stochastic Optimization
- [ ] Stochastic Dynamic Programming
- [X] Benders Decomposition for MILP
- [ ] L-Shaped Benders Decomp for Stochastic Optim
- [ ] Dantzig-Wolfe Decomposition Family
- [ ] Find Shortest Path

Right now, the project is still in alpha stage. There are many new updates on `JuMP`, so the algorithms need to be updated. You can try to get the latest feature by the following line.

```
(v1.1) pkg> add https://github.com/edxu96/MatrixOptim.git
```

## More Info

- wiki for documents and examples: [edxu96/MatrixOptim/wiki](https://github.com/edxu96/MatrixOptim/wiki/1-Home) .
- Cookbook for theories and algorithms in MatrixOptim: [MatrixOptim-Cookbook](./files/MatrixOptim-Cookbook.pdf) .
- 矩阵优化：通过矩阵表示混合整数线性规划，鲁棒（抗差）优化，随机优化和分解算法。虽然项目是用英文写的，但是有[中文详解](https://github.com/edxu96/MatrixOptim/wiki/9-zh)。

## Contributers

Edward J. Xu (<edxu96@outlook.com>) (<https://edxu96.github.io>)
