# MatrixOptim

[![Build Status](https://travis-ci.org/edxu96/MatrixOptim.svg?branch=master)](https://travis-ci.org/edxu96/MatrixOptim)

![Tangram](/images/tangram_1.png)

MILP, Robust Optim. and Stochastic Optim., and Decomposition Algorithm in Matrix (by Julia)

__矩阵优化__：通过矩阵表示混合整数线性规划，鲁棒（抗差）优化，随机优化和分解算法。中文详解请见[wiki/9-zh](https://github.com/edxu96/MatrixOptim/wiki/9-zh)。

Every optimization problem can be written in matrix form. For some problems, it may seems trivial, but it's coherent and easy to understand. Secondly, when it comes to algorithms to solve them, it's more explicit in matrix form. Thirdly, the abstraction algorithm for problem modeling helps a lot in understanding.

## 1,  What? and Why?

The MILP can be formulated in the following matrixes:

```
min  vecFf' * vecXx + vecGg' * vecYy
s.t. matAa1 * vecXx + matCc1 * vecYy <= vecBb1
     matAa2 * vecXx + matCc2 * vecYy <= vecBb2
     vecXx in R
     vecYy in Z+
```

There are two directions for matrix optimization to develop: make modeling easier and solving faster.

### 1.1,  Specialization

In this package, there are formulation algorithm for three kinds of optimization problems, and two decomposition
algorithms for faster MILP solving.

- Robust Optimization: [edxu96/RobustOptim](https://github.com/edxu96/RobustOptimization)
- Stochastic Optimization: [edxu96/StochasticOptim](https://github.com/edxu96/StochasticOptim)

### 1.2,  Decomposition

Two decomposition algorithms are:
- Benders Decomposition
- Dantzig-Wolfe Family Decomposition

## 2,  How to Use

```
julia> Pkg.clone("https://github.com/edxu96/MatrixOptim.git")
```

## 3,  More Info

[edxu96/MatrixOptim/wiki](https://github.com/edxu96/MatrixOptim/wiki/1-Home)

## 4,  Contributers

Edward Xu (<edxu96@outlook.com>) (<https://edxu96.github.io>)
