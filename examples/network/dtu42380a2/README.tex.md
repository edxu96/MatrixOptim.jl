---
for: MatrixOptim.jl/examples/network/dtu42380a2
author: Edward J. Xu
date: April 9, 2020
---

# DTU42380a2: Supply Networks and Inventory

$$
\begin{array}{cl}
\hline
\text { Symbol } & \text { Definition } & \text{Details} \\
\hline
L & \text{locations} \\
W & \text{types of warehouses} \\
V & \text{zones} & \{1, 2, 3, 4, 5, 6 \} \\
S & \text{years} & \{1, 2, 3\} \\
P & \text{plans} & \{1, 2, 3, 4, 5\} \\
\hline
\end{array}
$$

$$
\begin{array}{clc}
\hline
\text { Plan } & \text { Definition } & \text{Number of Years} \\
\hline
1 & \text{2007-2008} & 2 \\
2 & \text{2008-2009} & 2 \\
3 & \text{2007-2009} & 3 \\
4 & \text{2009} & 1 \\
5 & - & 0 \\
\hline
\end{array}
$$

$$
\begin{array}{cl}
\hline
\text { Symbol } & \text { Definition } \\
\hline
y^p_{l, w} & \text{whether plan $p$ for warehouse $w$ in location $l$} \\
z^s_{l, w} & \text{whether inventory used of warehouse $w$ in location $l$ in year $s$} \\
x^s_{l, v} & \text{shipment of products from location $l$ to vone $v$} \\
\hline
\end{array}
$$

$$
\begin{array}{cl}
\hline
\text { Symbol } & \text { Definition } \\
\hline
d^s_v & \text{demand in vone $v$ in year $s$} \\
c^{\text{ship}}_{l, v} & \text{cost of shipment from $l$ to $v$} \\
c^{\text{fix}}_{l, w} & \text{fixed cost of warehouse $w$ in $l$} \\
c^{\text{var}} & \text{variable cost} \\
q_w & \text{capacity of warehouse $w$} \\
e^s_p & \text{in plan $p$, whether to lease in year $s$} \\
v^s_p & \text{in plan $p$, if lease in year $s$} \\
\hline
\end{array}
$$

$$
\begin{align}
\max \quad & \sum_{S, L, W, P} c^{\text{fix}}_{l, w} e^s_p y^p_{l, w} + 475000 \sum_{S, L, W} z^s_{l, w} + (0.165 + c^{\text{var}}) \sum_{S, L, V} x^s_{l, v} + \sum_{S, L, V} c^{\text{ship}}_{l, v} x^s_{l, v} \\
\text{s.t.} \quad & \sum_{v \in V} x^s_{l, v} \leq \sum_W q_w z^s_{l, w} \quad l \in L, s \in S \\
& \sum_{p \in P} y^p_{l, w} = 1 \quad \forall l \in L, w \in W \\
& z^s_{l, w} \leq \sum_P e^s_p y^p_{l, w} \quad \forall s \in S, l \in L, w \in W \\
& z^s_{l, w}, y^p_{l, w} \in \{0, 1\} \quad \forall s \in S, l \in L, w \in W, p \in P
\end{align}
$$
