
$$
\begin{array}{clc}

\end{array}
$$

$$
\begin{align}
  \min \quad & c * \sum_{m} \sum_{n} l_{m, n} y_{m, n} + \sum_{m \in M} h_{m} \left(\sum_{i \in I} \sum_{n \in M / \{m\}} x_{i, m, n} \right) \\
  \text{s.t.} \quad & b * y_{m, n} \geq \sum_{i \in I} x_{i, m, n} \quad \forall m \in M, n \in M / \{m\} \\
  & y_{m, n} \leq 10 z_{m, n} \quad \forall m \in M, n \in M / \{m\} \\
  & \sum_{n \in M / \{m\}} x_{i, m, n} = a_{i, m} + \sum_{k \in M / \{m\}} x_{i, k, m} \quad \forall i \in I, m \in M
\end{align}
$$
