---
author: Edward J. Xu <edxu96@outlook.com>
date: Feb 1st, 2020
---

# L-Shaped Benders Decomposition for Stochastic Programming

The standard form for two stage stochastic programming with no integer variables in second stage can be expressed as:

$$ \begin{align}
    \min_{\mathbf{y}, \mathbf{x}} \quad& \mathbf{f}^{T} \mathbf{y} + \sum_{s \in \Omega} \pi_s \mathbf{c}_s^T \mathbf{x}_s \\
    \text{s.t.} \quad& \mathbf{t}_s \mathbf{y} + \mathbf{w}_s \mathbf{x}_s \geq \mathbf{h}_s \quad \forall s \in S \\
    & \mathbf{y} \in \mathbf{Y} \\
    & \mathbf{x}_s \geq 0 \quad \forall s \in S
\end{align} $$

where $\mathbf{y}$ is the vector of here-and-now decision variables, some of which are integer variables.

Master Problem:

$$ \begin{align}
    \min_{\mathbf{y}, q} \quad& \mathbf{f} ^ {T} \mathbf{y} + q \\
    \text{s.t.} \quad& \overline{\mathbf{u}_j^r}^T (\mathbf{h}_s - \mathbf{t}_s \mathbf{y}) \leq 0 \quad \forall j \\
    & \overline{\mathbf{u}_i^p}^T (\mathbf{h}_s - \mathbf{t}_s \mathbf{y}) \leq q \quad \forall i \\
    & \mathbf{y} \in \mathbf{Y}
\end{align} $$

Sub-problem for each scenario:

$$ \begin{align}
    \min_{\mathbf{x}} \quad & \mathbf{c}_s^T \mathbf{x}_s \\
    \text{s.t.} \quad & \mathbf{w}_s \mathbf{x}_s \geq \mathbf{h}_s - \mathbf{t}_s \overline{\mathbf{y}} \\
    & \mathbf{x}_s \geq 0
\end{align} $$

Dual problem of the sub-problem is used, which can be expressed as:

$$ \begin{align}
    \max_{\mathbf{u}} \quad & \left(\mathbf{h}_s - \mathbf{t}_s \overline{\mathbf{y}} \right)^T \mathbf{u}_s \\
    \text{s.t.} \quad & \mathbf{w}_s^T \mathbf{u}_s \leq \mathbf{c}_{s} \\
    & \mathbf{u}_s \geq 0
\end{align} $$

Then, when the sub-problem cannot be solved optimally because the feasible set is unbounded, ray-problem should be used instead, which can be expressed as:

$$ \begin{align}
  \max_{\mathbf{u}} \quad & 1 \\
  \text{s.t.} \quad & (\mathbf{h}_{s} - \mathbf{t}_{s} \overline{\mathbf{y}})^{T} \mathbf{u} = 1 \\
  & \mathbf{w}_{s}^{T} \mathbf{u} \leq \mathbf{0} \\
  & \mathbf{u}_s \geq 0
\end{align} $$

The aggregation of $\overline{\mathbf{u}}$ and $\text{obj}_{\text{sub}}$ from all scenarios are:

$$ \begin{align}
    \overline{\mathbf{u}} &= \sum_{s \in \Omega} \pi_s \mathbf{u}_s \\
    \text{obj}_{\text{sub}} &= \sum_{s \in \Omega} \pi_s \text{obj}_{\text{sub}, s} \\
\end{align} $$

## Example: News Boy problem

$$ \begin{align}
    \max \quad & \sum_{s} \pi_{s}(p-h) x_{s}+\sum_{s} \pi_{s}(h-c) y \\
    \text{s.t.} \quad & x_{s} \leq d_{s} \quad \forall s \\
    & x_{s} \leq y \quad \forall s \\
    & x \in R^{+} \\
    & y \in Z^{+}
\end{align} $$
