
# Strategy I: New Production Lines

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

## 1. 4-Hours Overtime on Sunday

4-hours overtime on Sunday are allowed in this strategy. So the constants indicating available time on weekends in the following constraints are changed:

$$
\begin{align}
  \sum_{p} m_{i p t}^{B 0} \leq 30 \times 60 \times 60 \\
  \sum_{p} m_{i p t}^{P 0} \leq 30 \times 60 \times 60
\end{align}
$$

The following lines of codes in the program are modified.

```
@constraint(model, [i = 1:L, t = 1:T],
  sum(mBO[i,p,t] for p = 1:P) <= 30 * 60 * 60);
@constraint(model, [i = 1:L, t = 1:T],
  sum(mPO[i,p,t] for p = 1:P) <= 30 * 60 * 60);
```

### 1-1. In which weeks are overtime on Sunday used, and how much?

$$
\begin{array}{ccc}
  \hline
  \text{week} & \text{total overtime (s)} & \text{OT on Sunday (s)} \\
  \hline
  1	& 94378	 & 7978 \\  
  2	& 108000 & 21600 \\
  3	& 72985  & 0 \\
  4	& 62360	 & 0 \\
  \hline
\end{array}
$$

_Table 4. Overtime usage of the blending machine in region 2 in different weeks._

### Comparison of KPIs in this Model and the Model in Task 2

$$
\begin{array}{cccc}
  \hline
  \text{region} & \text{product} & \text{ave inventory} & \text{ave fill rate (%)} \\
  \hline
  1	& 1	& 2110	& 100 \\
  1	& 2	& 1243	& 100 \\
  1 &	3	& 814	  & 100 \\
  2	& 1	& 1650	&100 \\
  2 & 2	& 1488	& 100 \\
  2	& 3	& 3448	& 100 \\
  3	& 1	& 4172	& 100 \\
  3	& 2 & 1734	& 100 \\
  3	& 3	& 3014	& 100 \\
  \hline
\end{array}
$$

_Table 1. Average inventory levels and average fill rates of different products in different regions._

$$
\begin{array}{cccc}
  \hline
  \text{region} & \text{machine} & \text{ave regular (%)} & \text{ave overtime (%)} \\
  \hline
  1	& \text{blending}	  & 75.53	& 0 \\  
  1	& \text{packaging}	& 33.00	& 0 \\
  2	& \text{blending}	  & 100	  & 78.18 \\
  2	& \text{packaging}	& 51.38	& 0 \\
  3	& \text{blending}	  & 91.84	& 0 \\
  3	& \text{packaging}	& 40.22	& 0 \\
  \hline
\end{array}
$$

_Table 2. Average regular-time and overtime usage ratios of different machines in different regions._

$$
\begin{array}{ccc}
  \hline
  \text{region} & \text{week} & \text{promotion} \\
  \hline
  1	& 1	& \text{no} \\  
  1	& 2	& \text{yes} \\
  2	& 1 & \text{no} \\
  2	& 2	& \text{yes} \\
  3	& 1 & \text{yes} \\
  3	& 2	& \text{no} \\
  \hline
\end{array}
$$

_Table 3. Decisions on promotions of product 3 in different regions and weeks._

## 2. Minimum Speed-Up of Machines to Satisfy all the Demand

Speed-up factors $s_{\text{blend}}$ and $s_{\text{package}}$ are defined as new decision variables to represent the possible ratio of capacity expansion. Thus, the new maximum amount of regular times and overtimes will be $432000 * s_{\text{blend}}$, $86400 * s_{\text{blend}}$, $432000 * s_{\text{package}}$, and $86400 * s_{\text{package}}$.

Two sets of codes are modified to define the new decision variables and modify the constraints.

```
@variable(model, s_b >= 1)
@variable(model, s_p >= 1)
```

```
@constraint(model, [i = 1:L, t = 1:T],
  sum(mBR[i,p,t] for p = 1:P) <= 24*5*60*60 * s_b);
@constraint(model, [i = 1:L, t = 1:T],
  sum(mPR[i,p,t] for p = 1:P) <= 24*5*60*60 * s_p);
@constraint(model, [i = 1:L, t = 1:T],
  sum(mBO[i,p,t] for p = 1:P) <= 24*1*60*60 * s_b);
@constraint(model, [i = 1:L, t = 1:T],
  sum(mPO[i,p,t] for p = 1:P) <= 24*1*60*60 * s_p);
```

### 2-2. Comparison of KPIs in this Model and the Model in Task 2

$$
\begin{array}{cccc}
  \hline
  \text{region} & \text{product} & \text{ave inventory} & \text{ave fill rate (%)} \\
  \hline
  1	& 1	& 2110	& 100 \\
  1	& 2	& 1243	& 100 \\
  1 &	3	& 814	  & 100 \\
  2	& 1	& 1650	&100 \\
  2 & 2	& 1488	& 100 \\
  2	& 3	& 3732	& 100 \\
  3	& 1	& 4172	& 100 \\
  3	& 2 & 1734	& 100 \\
  3	& 3	& 3014	& 100 \\
  \hline
\end{array}
$$

_Table 5. Average inventory levels and average fill rates of different products in different regions._

$$
\begin{array}{cccc}
  \hline
  \text{region} & \text{machine} & \text{ave regular (%)} & \text{ave overtime (%)} \\
  \hline
  1	& \text{blending}	  & 73.44	 & 0 \\  
  1	& \text{packaging}	& 33.00	 & 0 \\
  2	& \text{blending}	  & 100.00 & 81.14197071 \\
  2	& \text{packaging}	& 51.38	 & 0 \\
  3	& \text{blending}	  & 89.29	 & 0 \\
  3	& \text{packaging}	& 40.22	 & 0 \\
  \hline
\end{array}
$$

_Table 6. Average used regular-time and overtime ratios of different machines in different regions._

$$
\begin{array}{ccc}
  \hline
  \text{region} & \text{week} & \text{promotion} \\
  \hline
  1	& 1	& \text{no} \\  
  1	& 2	& \text{yes} \\
  2	& 1 & \text{no} \\
  2	& 2	& \text{yes} \\
  3	& 1 & \text{yes} \\
  3	& 2	& \text{no} \\
  \hline
\end{array}
$$

_Table 7. Decisions on promotions of product 3 in different regions and weeks._
