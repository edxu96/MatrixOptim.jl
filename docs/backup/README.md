
# Docs for MatrixOptim.jl

`MatrixOptim.jl` can make it easier to solve some optimization models. There are several prefabricated algorithms to solve the models in matrix form.

## Data Driven Decision Making under Uncertainty



## Table of Contents

- [intro], introduction
- [lp], linear programming
- [milp], mixed integer linear programming
- [decomp], decomposition algorithms
  * [decomp-benders-milp], benders decomposition for mixed integer linear programming
  * [decomp-benders-lshaped], l-shaped benders decomposition for stochastic programming without integer variables in the second stage
  * [decomp-benders-lshaped-integer], l-shaped benders decomposition for stochastic programming with integer variables in the second stage
- [robust], robust programming
- [sto], stochastic programming
- [mdp], Markov decision process

## References

1.

[intro]: ./1-intro.md
[lp]: ./2-lp.md
[milp]: ./3-milp.md
[decomp]: ./4-decomp.md
[decomp-benders-milp]: ./4-1.md
[decomp-benders-lshaped]: ./4-2.md
[decomp-benders-lshaped-integer]: ./4-3.md
[robust]: ./5-robust.md
[sto]: ./6-sto.md
[mdp]: ./7-mdp.md

[1]: https://books.google.dk/books?hl=en&lr=&id=hUBWCgAAQBAJ&oi=fnd&pg=PR7&dq=decision+making+under+uncertainty+theory&ots=529NaoMOT3&sig=bZmuKQa-w9fE_uwu_wWmnIgGUmY&redir_esc=y#v=onepage&q=decision%20making%20under%20uncertainty%20theory&f=false
[2]: http://eaton.math.rpi.edu/CourseMaterials/PreviousSemesters/PreviousSemesters/Spring08/JM6640/tebboth.pdf
