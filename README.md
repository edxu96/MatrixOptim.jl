
# MatrixOptim

[![Build Status](https://travis-ci.org/edxu96/MatrixOptim.svg?branch=master)](https://travis-ci.org/edxu96/MatrixOptim)

![Tangram](/images/tangram_1.png)

MILP, Robust Optim. and Stochastic Optim., and Decomposition Algorithm in Matrix (by Julia)

__矩阵优化__：通过矩阵表示混合整数线性规划，鲁棒（抗差）优化，随机优化和分解算法。中文详解请见[wiki/9-zh](https://github.com/edxu96/MatrixOptim/wiki/9-zh)。

Every optimization problem can be written in matrix form. For some problems, it may seems trivial, but it's coherent and easy to understand. Secondly, when it comes to algorithms to solve them, it's more explicit in matrix form. Thirdly, the abstraction algorithm for problem modeling helps a lot in understanding.

## Introduction

The MILP can always be formulated in the following matrixes:

```
min  vec_c' * vec_x + vec_f' * vec_y
s.t. mat_aCap * vec_x + mat_bCap * vec_y <= vec_b
     vec_x in R
     vec_y in Z
```

There are two directions for matrix optimization to develop: make modeling easier and solving faster.

In this package, there are formulated algorithm for four kinds of optimization problems, and two decomposition algorithms for faster MILP solving.

## To Check

- [x] Linear Programming
- [x] Mixed Integer Linear Programming
- [ ] Robust Optimization
- [ ] Stochastic Optimization
- [ ] Benders Decomposition
- [ ] Dantzig-Wolfe Decomposition Family

## How to Use

```
julia> Pkg.clone("https://github.com/edxu96/MatrixOptim.git")
```

Or

```
(v1.1) pkg> add https://github.com/edxu96/MatrixOptim.git
```

Besides, remember to update it regularly after installation:

```
julia> Pkg.update("MatrixOptim")
```

Or

```
(v1.1) pkg> update MatrixOptim
```

## More Info

- [edxu96/MatrixOptim/wiki](https://github.com/edxu96/MatrixOptim/wiki/1-Home)
- [中文详解](https://github.com/edxu96/MatrixOptim/wiki/9-zh)

## Contributers

Edward J. Xu (<edxu96@outlook.com>) (<https://edxu96.github.io>)
