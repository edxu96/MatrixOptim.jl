
$$
\begin{aligned}
  \min \quad & \sum_{i, p, t} \left(\sum_{s} c_{s} y_{i s p t}+c^{B R} m_{i p t}^{B R}+c^{B O} m_{i p t}^{B O}\right. \left.+c^{P R} m_{i p t}^{P R}+c^{P O} m_{i p t}^{P O}+h_{p} I_{i p t}+\Pi \delta_{i p t}\right) \\
  \text{s.t.} \quad & y_{i s p t} = \pi_{p s} x_{i p t} \\
  & m_{i p t}^{B R}+m_{i p t}^{B 0} =\mu_{p}^{B} x_{i p t} \\
  & m_{i p t}^{P R}+m_{i p t}^{P O} =\mu_{p}^{P} x_{i p t} \\
  & \sum_{p} m_{i p t}^{B R} \leq 432000 \\
  & \sum_{p} m_{i p t}^{P R} \leq 432000 \\
  & \sum_{p} m_{i p t}^{B 0} \leq 86400 \\
  & \sum_{p} m_{i p t}^{P 0} \leq 86400 \\
  & x_{i p t}+I_{i p t-1} = I_{i p t}+D_{i p t} - \delta_{i p t} \\
  & I_{i p t} \geq s s_{i p t}
\end{aligned}
$$

$$
\begin{array}{cl}
  \hline
  \text { Symbol } & \text { Definition } \\
  \hline
  L & \text{regions} \\
  P & \text{products} \\
  T & \text{weeks} \\
  S & \text{materials} \\
  \hline
\end{array}
$$

$$
\begin{array}{ll}
  \hline
  \text{Symbol} & \text{Definition} \\
  \hline
  x_{i p t} & \text{production quantity at plant $i$ of product $p$ in week $t$} \\
  y_{i s p t} & \text{Source quantity at plant } i \text { of (preblend/packaging) material } s \text { for product } p \text { in week } t \\
  m_{i p t}^{B R} & \text { Regular time of the blend machine reserved at plant } i \text { for product } p \text { in week } t \\
  m_{i p t}^{P R} & \text { Regular time of the packaging machine reserved at plant } i \text { for product } p \text { in week } t \\
  m_{i p t}^{B 0} & \text { Overtime of the blend machine reserved at plant } i \text { for product } p \text { in week } t \\
  m_{i p t}^{P 0} & \text { Overtime of the packaging machine reserved at plant } i \text { for product } p \text { in week } t \\
  I_{i p t} & \text { Inventory level at warehouse } i \text { of product } p \text { at the end of week } t \\
  \delta_{i p t} & \text { Amount of demand at warehouse } i \text { of product } p \text { in week } t \text { that could not be satisfied } \\
  \hline
\end{array}
$$
