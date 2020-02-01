
# L-Shaped Benders Decomposition with Integer Variables in Second Stage

The standard form for two stage stochastic programming with integer variables in second stage:

$$ \begin{align}
    \min_{\mathbf{y}, \mathbf{x}_s, \mathbf{z}_s} \quad& \mathbf{f} ^ { T } \mathbf{y} + \sum_{s \in \Omega} \pi_s \left(\mathbf{c}_s^T \mathbf{x}_s + \mathbf{d}_s^T \mathbf{z}_s \right) \\
    \text{s.t.} \quad& \mathbf{T}_s \mathbf{y} + \mathbf{w}_s \mathbf{x}_s + \mathbf{g}_s \mathbf{z}_s \geq \mathbf{h}_s \quad \forall s \\
    & \mathbf{y} \in \mathbf{Y} \\
    & \mathbf{x}_s \geq 0 \quad \forall s \\
    & \mathbf{z}_s \in \mathbf{Z} \quad \forall s
\end{align} $$

where the $\mathbf{y}$ is vector of integer variables.

Master Problem:

$$ \begin{align}
    \min \quad& \mathbf{f}^{T} \mathbf{y} + \sum_{s \in \Omega} \pi_s q_s(\mathbf{y}) \\
    \text{s.t.} \quad& \overline{\mathbf{u}_j^r}^T (\mathbf{h}_s - \mathbf{T}_s \mathbf{y}) \leq 0 \quad \forall j \\
    & \overline{\mathbf{u}_i^p}^T (\mathbf{h}_s - \mathbf{T}_s \mathbf{y}) \leq q_s(\mathbf{y}) \quad \forall i \\
    & \mathbf{y} \in \mathbf{Y}
\end{align} $$

Sub-problem for each scenario:

$$ \begin{align}
    q_s(\mathbf{y}) = \min \quad & \mathbf{d}^{T}_s \mathbf{z}_s + \mathbf{c}_s^T \mathbf{x}_s \\
    \text{s.t.} \quad & \mathbf{g}_s \mathbf{z}_s + \mathbf{w}_s \mathbf{x}_s \geq \mathbf{h}_s - \mathbf{T}_s \overline{\mathbf{y}} \\
    & \mathbf{x}_s \geq 0
\end{align} $$

which is a standard MILP problem.

So we use the benders algorithm again. The Sub-Mas problem is:

$$ \begin{align}
    q_s(\mathbf{y}) = \min \quad & \mathbf{d}^{T}_s \mathbf{z}_s + p_s(\mathbf{z}_s) \\
    \text{s.t.} \quad & \overline{\mathbf{v}_m^p}^T \left[\left(\mathbf{h}_s - \mathbf{T}_s \overline{\mathbf{y}} \right) - \mathbf{g}_s \overline{\mathbf{z}_s} \right] \leq p_s(\mathbf{z}_s) \quad \forall m \\
    & \overline{\mathbf{v}_n^r}^T \left[\left(\mathbf{h}_s - \mathbf{T}_s \overline{\mathbf{y}} \right) - \mathbf{g}_s \overline{\mathbf{z}_s} \right] \leq 0 \quad \forall n \\
    & \mathbf{x}_s \geq 0
\end{align} $$

Sub-Sub-problem for each scenario:

$$ \begin{align}
    p_s(\mathbf{y}) = \min \quad & \mathbf{c}_s^T \mathbf{x}_s \\
    \text{s.t.} \quad & \mathbf{w}_s \mathbf{x}_s \geq \left(\mathbf{h}_s - \mathbf{T}_s \overline{\mathbf{y}} \right) - \mathbf{g}_s \overline{\mathbf{z}_s}  \\
    & \mathbf{x}_s \geq 0
\end{align} $$

The dual function of $p_s(\mathbf{y})$ is:

$$ \begin{align}
    p_s^d(\mathbf{y}) = \max \quad & \left[\left(\mathbf{h}_s - \mathbf{T}_s \overline{\mathbf{y}} \right) - \mathbf{g}_s \overline{\mathbf{z}_s} \right]^{T} \mathbf{v} \\
    \text{s.t.} \quad & \mathbf{w}_s^{T} \mathbf{v} \leq \mathbf{c}_s \\
    & \mathbf{v} \geq 0
\end{align} $$
