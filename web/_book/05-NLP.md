---
editor_options:
  chunk_output_type: console
---

# Non-Linear Programming (NLP)

In one general form, the nonlinear programming problem is to find $\mathbf{x}=\left(x_{1}, x_{2}, \ldots, x_{n}\right)$ so as to maximize $f(\mathbf{x})$ subject to $g_{i}(\mathbf{x}) \leq b_{i} \text{, for  } i=1,2, \ldots, m$ and $\mathbf{x} \geq \mathbf{0}$ where $f(\mathbf{x})$ and the $g_{i}(\mathbf{x})$ are given of the $n$ variables.

> Nonlinear programming problems come in many different shapes and forms. Unlike the simplex method for linear programming, no single algorithm can solve all these different types of problems. Instead, algorithms have been developed for various individual classes (special types) of nonlinear programming problems. [@hillier2012introduction]



## Classical Methods of Calculus

### Unconstrained Optimization

According to appendix 3 in [@hillier2012introduction], the analysis for an unconstrained function of several variables $f(\mathbf{x}),$ where $\mathbf{x}=\left(x_{1}, x_{2}, \ldots, x_{n}\right),$ is similar. Thus, a necessary condition for a solution $\mathbf{x}=\mathbf{x}^{*}$ to be either a minimum or a maximum is that:

$$ \frac{\partial f(\boldsymbol{x})}{\partial x_{j}}=0 \quad \text { at } \mathbf{x}=\mathbf{x}^{*}, \quad \text { for } j=1,2, \dots, n$$

After the critical points that satisfy this condition are identified, each such point is then classified as a local minimum or maximum if the function is strictly convex or strictly concave, respectively, within a neighborhood of the point. (Additional analysis is required if the function is neither.) The global minimum and maximum would be found by comparing the local minima and maxima and then checking the value of the function as some of the variables approach $-\infty$ or $+\infty$. However, if the function is known to be convex or concave, then a critical point must be a global minimum or a global maximum, respectively.

### Constrained Optimization with Equality Constraints

> From a practical computational viewpoint, the method of Lagrange multipliers is not a particularly powerful procedure. [@hillier2012introduction]

#### Method of Lagrange Multipliers {-}

According to appendix 3 in [@hillier2012introduction], the procedure begins by formulating the Lagrangian function:

$$ h(\mathbf{x}, \boldsymbol{\lambda})=f(\mathbf{x})-\sum_{i=1}^{m} \lambda_{i}\left[g_{i}(\mathbf{x})-b_{i}\right] $$

where the new variables $\boldsymbol{\lambda}=\left(\lambda_{1}, \lambda_{2}, \ldots, \lambda_{m}\right)$ are called Lagrange multipliers. Notice the key fact that for the feasible values of $\mathbf{x}$:

$$ g_{i}(\mathbf{x})-b_{i}=0, \quad \text { for all } i $$

so $h(\mathbf{x}, \mathbf{\lambda})=f(\boldsymbol{x}) .$ Therefore, it can be shown that if $(\mathbf{x}, \mathbf{\lambda}) = \left(\mathbf{x}^{*}, \mathbf{\lambda}^{*}\right)$ is a local or global minimum or maximum for the unconstrained function $h(\mathbf{x}, \boldsymbol{\lambda}),$ then $\mathbf{x}^{*}$ is a corresponding critical point for the original problem. As a result, the method now reduces to analyzing $h(\mathbf{x}, \mathbf{\lambda})$ by the procedure just described for unconstrained optimization. Thus, the $n+m$ partial derivatives would be set equal to zero:

$$ \begin{align}
\frac{\partial h}{\partial x_{j}} &= \frac{\partial f}{\partial x_{j}} - \sum_{i=1}^{m} \lambda_{i} \frac{\partial g_{i}}{\partial x_{j}} = 0 \quad \text{for  } j = 1, 2, \ldots, n \\
\frac{\partial h}{\partial \lambda_{i}} &= -g_{i}(\mathbf{x})+b_{i} = 0 \quad \text{for  } i = 1, 2, \ldots, m
\end{align} $$

and then the critical points would be obtained by solving these equations for $(\mathbf{x}, \boldsymbol{\lambda})$. Notice that the last $m$ equations are equivalent to the constraints in the original problem, so only feasible solutions are considered. After further analysis to identify the global minimum or maximum of $h(\cdot),$ the resulting value of $\mathbf{x}$ is then the desired solution to the original problem.



## KKT Conditions

KKT conditions is the necessary conditions for optimality in general constrained problem. See section 13.6 in [@hillier2012introduction] for details.

\BeginKnitrBlock{corollary}<div class="corollary"><span class="corollary" id="cor:unnamed-chunk-3"><strong>(\#cor:unnamed-chunk-3) </strong></span>Assume that $f(\mathbf{x})$ is a concave function and that $g_{1}(\mathbf{x}), g_{2}(\mathbf{x}), \ldots, g_{m}(\mathbf{x})$ are convex functions (i.e., this problem is a convex programming problem), where all these functions satisfy the regularity conditions. Then $\mathbf{x}^{*}=\left(x_{1}^{*}, x_{2}^{*}, \ldots, x_{n}^{*}\right)$ is an optimal solution if and only if all the conditions of the theorem are satisfied.</div>\EndKnitrBlock{corollary}

> For complicated problems, it may be difficult, if not essentially impossible, to derive an optimal solution directly from the KKT conditions. Nevertheless, these conditions still provide valuable clues as to the identity of an optimal solution, and they also permit us to check whether a proposed solution may be optimal. [@hillier2012introduction]

> There also are many valuable indirect applications of the KKT conditions. One of these applications arises in the duality theory that has been developed for nonlinear programming to parallel the duality theory for linear programming. [@hillier2012introduction]
