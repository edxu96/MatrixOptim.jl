
# Decomposition Algorithms for MILP

## 1, Benders Decomposition, MatrixOptim

According to wikipedia:

> Benders decomposition (or Benders' decomposition) is a technique in mathematical programming that allows the solution of very large linear programming problems that have a special block structure. This block structure often occurs in applications such as stochastic programming as the uncertainty is usually represented with scenarios. The technique is named after Jacques F. Benders.

### 1.1, Generic Benders Decomposition for Mixed Integer Linear Programming

![Standard MILP](https://github.com/edxu96/MatrixOptim.jl/blob/master/images/2.png)

```
ModMilpBenders
    sol::SolMix
        obj::Float64
        vec_result_x::Array{Float64,2}
        vec_result_y::Array{Float64,2}
    mas::ModMas
        expr::Model
        vec_y
    logs::LogHead
        next::Log
```

### 1.2, L-Shaped Benders Decomposition for Stochastic Programming without Integer Variables in Second Stage

![Stochastic Programming without Integer Variables in Second Stage](https://github.com/edxu96/MatrixOptim.jl/blob/master/images/1.png)

## 2, Dantzig-Wolfe Decomposition
