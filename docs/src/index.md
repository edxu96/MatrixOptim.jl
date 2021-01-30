
# MatrixOptim.jl

[![Build Status](https://travis-ci.org/edxu96/MatrixOptim.jl.svg?branch=master)](https://travis-ci.org/edxu96/MatrixOptim.jl) [![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

MILP, Robust Optim. and Stochastic Optim., Decomposition Algorithms, and more in Matrix.

![Tangram](../../img/tangram.png)

`MatrixOptim.jl` is a package to model and solve optimization in uncertain context. The
templates for robust optimization and stochastic optimization formulated in matrix are very
coherent comprehensive, and the algorithms in matrix are very explicit.

This is a package I developed in 2019. Don't know too much about tests and documentation
that time. I am trying to keep it up-to-date these days.

## Why in Matrix

I wrote most of the code when taking [02435 decision making under
uncertainty](https://kurser.dtu.dk/course/02435) and [42136 large scale optimization using
decomposition](https://kurser.dtu.dk/course/42136) at Technical University of Denmark. In
course 02435, we are encouraged to use [GAMS](https://www.gams.com/) to formulate and solve
problems. For SP and RP problems, you cannot code them directly in GAMS. Instead, you have
to transform every one of them to a corresponding MILP problem on paper first. In course
42136, teachers promote Julia and JuMP, and teach most of the theories in matrix form. Then
I started coding in Julia and tried to make the formulation more general, for course 02435
and 42136.

Every optimization problem can be written in matrix form. For some problems, it may seems
trivial, but it's coherent and easy to understand. Besides, when it comes to algorithms to
solve them, it's more explicit in matrix form. Finally, the abstraction algorithm for
problem modelling helps a lot in understanding. In general, there are three steps when using
`MatrixOptim.jl`:

1. Store all data in a composite according to a pre-defined way.
2. Solve the problem.
3. Assign returned results.

## Documentation

```@meta
CurrentModule = MatrixOptim
```

```@autodocs
Modules = [MatrixOptim]
Order = [:function, :type]
```
