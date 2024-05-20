# MatrixOptim.jl

[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

MILP, Robust Optim. and Stochastic Optim., Decomposition Algorithms, and more in Matrix.

`MatrixOptim.jl` is a package to model and solve optimization in uncertain context. The
templates for robust optimization and stochastic optimization formulated in matrix are very
coherent comprehensive, and the algorithms in matrix are very explicit.

This is a package I developed in 2019. Don't know too much about tests and documentation
that time. I am trying to keep it up-to-date these days.

## Introduction

The MILP can always be formulated in the following matrixes:

```
min  vec_c' * vec_x + vec_f' * vec_y
s.t. mat_A * vec_x + mat_B * vec_y <= vec_b
     vec_x in R
     vec_y in Z
```

## Installation and Test

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

Right now, the supported solver is `GLPK`. Will add the feature to select other solvers,
like `Gurobi` and `CPLEX` later.

## Features

### Models

- [x] Linear Programming
- [x] Mixed Integer Linear Programming
- [ ] Robust Optimization
- [ ] Stochastic Optimization
- [ ] Markov Decision Process
- [x] Dynamic Optimization

### Algorithms

- [ ] Simplex Method
- [ ] Branch and Cut for MILP
- [X] Benders Decomposition for MILP
- [ ] L-Shaped Benders Decomp for Stochastic Optim
- [ ] Dantzig-Wolfe Decomposition Family

### Related to Development

- [BlueStyle](https://github.com/invenia/BlueStyle): a Style Guide for Julia

## More Info

- Cookbook for theories and algorithms in MatrixOptim:
  [MatrixOptim-Cookbook](./files/MatrixOptim-Cookbook.pdf) .
- 矩阵优化：通过矩阵表示混合整数线性规划，鲁棒（抗差）优化，随机优化和分解算法。虽然项目是用
  英文写的，但是有[中文详解](https://github.com/edxu96/MatrixOptim/wiki/9-zh)。
