
## Introduction

`MatrixOptim.jl` can make it easier to solve some optimization models. There are several prefabricated algorithms to solve the models in matrix form.

## Advantage

- Consistent
- Comprehensive

## Decision Making under Uncertainty

> Many important problems involve decision making under uncertainty, including aircraft collision avoidance, wildfire management, and disaster response. When one is designing automated decision support systems, it is important to account for the various sources of uncertainty when making or recommending decisions. Accounting for these sources of uncertainty and carefully balancing the multiple objectives of the system can be very challenging. [1]

### Stochastic Optimization

Stochastic programming is a framework for modeling optimization problems that involve uncertainty, if the probability distributions governing the data are known or can be estimated. The goal here is to find some policy that is feasible for all (or almost all) the possible data instances and maximizes the expectation of some function of the decisions and the random variables.

### Robust Optimization

When the parameters are known only within certain bounds, one approach to tackling such problems is called robust optimization. Here the goal is to find a solution which is feasible for all such data and optimal in some sense.

## Decomposition

The principle of decomposition as a solution technique is to break a problem down into a set of smaller problems, and, by solving the smaller problems, obtain a solution to the original problem. [2]

### Benders Decomposition

### Dantzig-Wolfe Decomposition

[3]

## References

[1]: https://books.google.dk/books?hl=en&lr=&id=hUBWCgAAQBAJ&oi=fnd&pg=PR7&dq=decision+making+under+uncertainty+theory&ots=529NaoMOT3&sig=bZmuKQa-w9fE_uwu_wWmnIgGUmY&redir_esc=y#v=onepage&q=decision%20making%20under%20uncertainty%20theory&f=false

1. Kochenderfer, M.J., 2015. Decision making under uncertainty: theory and application. MIT press.

[2]: http://eaton.math.rpi.edu/CourseMaterials/PreviousSemesters/PreviousSemesters/Spring08/JM6640/tebboth.pdf

2. Tebboth, J.R., 2001. A computational study of Dantzig-Wolfe decomposition. University of Buckingham.

[3]: ./0-ref.md
