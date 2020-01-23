
# Metsa-Oy Production and Supply Chain 3: Stochastic Dynamic

## 1, Introduction

## 2, Definition of Mathematical Expressions

$$
\begin{array}{c l c}
	  \hline
	  \text{Symbol} & \text{Definition} & \text{Expression} \\
	  \hline
	  T^1 & \text{type of timber 1} & \{\text{MAT}, \text{KUT}, \text{KOT} \} \\
	  T^2 & \text{type of timber 2} & \{\text{MAK}, \text{KUK}, \text{KOK} \} \\
		T & \text{type of timber} & T^1 \cup T^2 \\
		I^{T1}_{t = \text{MAT}} & \text{outputs of wood production corresponding to input MAT} & \{\text{MAS} \} \\
		I^{T1}_{t = \text{KUT}} & \text{outputs of wood production corresponding to input KUT} & \{\text{KUS}, \text{KUV} \} \\
		I^{T1}_{t = \text{KOT}} & \text{outputs of wood production corresponding to input KOT} & \{\text{KOS}, \text{KOV} \} \\
		I^{T2}_{t = \text{MAK}} & \text{outputs of wood production corresponding to output MAK} & \{\text{MAS} \} \\
		I^{T2}_{t = \text{KUK}} & \text{outputs of wood production corresponding to output KUK} & \{\text{KUS}, \text{KUV} \} \\
		I^{T2}_{t = \text{KOK}} & \text{outputs of wood production corresponding to output KOK} & \{\text{KOS}, \text{KOV} \} \\
	  I^{\text{saw}} & \text{outputs of wood production in saw mill} & \{\text{MAS}, \text{KUS}, \text{KOS} \} \\
	  I^{\text{plywood}} & \text{outputs of wood production in plywood mill} & \{\text{KUV}, \text{KOV} \} \\
		I & \text{outputs of wood production} & I^{\text{saw}} \cup I^{\text{plywood}} \\
		J & \text{outputs of pulp production} & \{\text{HSEL}, \text{LSEL} \} \\
		J^{T2}_{t = \text{MAK}} & \text{outputs of pulp production corresponding to input MAK} & \{\text{HSEL} \} \\
		J^{T2}_{t = \text{KUK}} & \text{outputs of pulp production corresponding to input KUK} & \varnothing \\
		J^{T2}_{t = \text{KOK}} & \text{outputs of pulp production corresponding to input KOK} & \{\text{LSEL} \} \\
		K & \text{regions to sell products} & \{\text{EU}, \text{IE}, \text{PA}, \text{KI} \} \\
    M & \text{three years in the planning horizon} & \{1, 2, 3 \} \\
		N & \text{four scenarios} & \{1, 2, 3, 4\} \\
	  \hline
\end{array}
$$

_Table 1, summary of sets_

$$
\begin{array}{c l c c c}
		\hline
		\text{Symbol} & \text{Definition} & \text{Type} & \text{Unit} & \text{Set} \\
		\hline
		h_{m, t} & \text{purchasing amount of timber $t$ in the year $m$} & \text{integer} & 1000 m^3 & M, T \\
		y^I_{m, i} & \text{production amount of wood $i$ in the year $m$} & \text{linear} & 1000 m^3 & M, I \\
		y^J_{m, j} & \text{production amount of pulp $j$ in the year $m$} & \text{linear} & 1000 m^3 & M, J \\
		y^{\text{paper}}_{m} & \text{production amount of paper in the year $m$} & \text{linear} & 1000 m^3 & M \\
		z^I_{m, i, k} & \text{selling amount of wood in the region $k$ in the year $m$} & \text{linear} & 1000 m^3 & M, I, K \\
		z^J_{m, j, k} & \text{selling amount of pulp in the region $k$ in the year $m$} & \text{linear} & 1000 m^3 & M, J, K \\
		z^{\text{paper}}_{m, k} & \text{selling amount of paper in the region $k$ in the year $m$} & \text{linear} & 1000 m^3 & M, K \\
    x^{\text{saw}}_{m} & \text{capacity of saw mill} & \text{linear} & 1000 m^3 / \text{year} & M / \{3\} \\
    x^{\text{plywood}}_{m} & \text{capacity of plywood mill} & \text{linear} & 1000 m^3 / \text{year} & M / \{3\} \\
    x^J_{m, j} & \text{capacity of pulp production line} & \text{linear} & 1000 \text{ton} / \text{year} & M / \{3\}, J \\
    x^{\text{paper}}_{m} & \text{capacity of paper production line} & \text{linear} & 1000 \text{ton} / \text{year} & M / \{3\} \\
		x^{\text{saw}}_{n, 3} & \text{capacity of saw mill in the year $3$ decide in the year 2} & \text{linear} & 1000 m^3 / \text{year} & N \\
    x^{\text{plywood}}_{n, 3} & \text{capacity of plywood mill in the year $3$ decide in the year 2} & \text{linear} & 1000 m^3 / \text{year} & N \\
    x^J_{n, 3, j} & \text{capacity of pulp production line in the year $3$ decide in the year 2} & \text{linear} & 1000 \text{ton} / \text{year} & N, J \\
    x^{\text{paper}}_{n, 3} & \text{capacity of paper production line in the year $3$ decide in the year 2} & \text{linear} & 1000 \text{ton} / \text{year} & N \\
		\hline
\end{array}
$$

_Table 2, summary of decision variables_

$$
\begin{array}{c l c c}
		\hline
		\text{Symbol} & \text{Definition} & \text{Unit} & \text{Set} \\
		\hline
		\rho_{n, m} & \text{price coefficient of the scenario $n$ in the year $m$} & - & N, M \\
		\omega^I_i & \text{demand growth coefficient of wood $i$} & - & I \\
		\omega^J_j & \text{demand growth coefficient of pulp $j$} & - & J \\
		\omega^{\text{paper}} & \text{demand growth coefficient of paper} & - & - \\
		p^{\text{fuel}} & \text{price of fuel wood} & \text{euro} / (1000 m^3) & - \\
    \sigma & \text{annual discounting factor} & - & - \\
		\pi_{n} & \text{probability of scenario $n$} & - & N \\
		\alpha_t & \text{fixed cost factor of purchasing timber $t$} & \text{euro} / (1000 m^3) & T \\
		\beta_t & \text{unit cost factor of purchasing timber $t$} & \text{euro} / (1000 m^6) & T \\
		a^I_i & \text{relation of timber input and output in wood production $i$} & - & I\\
		b^I_i & \text{relation of timber output and output in wood production $i$ $i$} & - & I \\
		e^I_i & \text{relation of fuel output and output in wood production $i$} & - & I \\
		c^I_i & \text{cost of wood production $i$} & \text{euro} / (1000 m^3) & I \\
		r^{\text{saw}} & \text{original capacity of saw mill} & 1000 m^3 / \text{year} & - \\
		r^{\text{plywood}} & \text{original capacity of plywood mill} & 1000 m^3 / \text{year} & - \\
    o^{\text{saw}} & \text{capacity expansion cost of saw mill} & \text{euro} / (1000 m^3 / \text{year}) & - \\
    o^{\text{plywood}} & \text{capacity expansion cost of plywood mill} & \text{euro} / (1000 m^3 / \text{year}) & - \\
    \nu^{\text{saw}} & \text{max capacity expansion factor of saw mill} & - & - \\
    \nu^{\text{plywood}} & \text{max capacity expansion factor of saw mill} & - & - \\
		a^J_j & \text{input and output relation of pulp production $j$} & - & J \\
		c^J_j & \text{cost of pulp production $j$} & \text{euro} / (1000 \text{ton}) & J \\
		r^J_j & \text{original capacity of pulp production $j$} & 1000 \text{ton} / \text{year} & J \\
    o^J_j & \text{capacity expansion cost of pulp production $j$} & \text{euro} / (1000 m^3 / \text{year}) & - \\
    \nu^J_j & \text{max capacity expansion factor of pulp production $j$} & - & J \\
		a^{\text{paper}}_{t} & \text{relation of timber inputs in paper production} & - & T \\
		b^{\text{paper}}_{j} & \text{relation of pulp inputs in paper production} & - & J \\
		c^{\text{paper}} & \text{cost of paper production} & \text{euro} / (1000 \text{ton}) & - \\
		r^{\text{paper}} & \text{original capacity of paper production} & 1000 \text{ton} / \text{year} & - \\
    o^{\text{paper}} & \text{capacity expansion cost of paper production} & \text{euro} / (1000 m^3 / \text{year}) & - \\
    \nu^{\text{paper}} & \text{max capacity expansion factor of paper production} & - & - \\
		\gamma^{I}_{m, i, k} & \text{fixed price factor of wood $i$ in the region $k$ in the year $m$} & \text{euro} / (1000 m^3) & M, I, K \\
		\delta^{I}_{m, i, k} & \text{unit price factor of wood $i$ in the region $k$ in the year $m$} & \text{euro} / (10^6 m^6) & M, I, K \\
		\gamma^{J}_{m, j, k} & \text{fixed price factor of pulp $j$ in the region $k$ in the year $m$} & \text{euro} / (1000 \text{ton}) & M, J, K \\
		\delta^{J}_{m, j, k} & \text{unit price factor of pulp $j$ in the region $k$ in the year $m$} & \text{euro} / (10^6 \text{ton}^2) & M, J, K \\
		\gamma^{\text{paper}}_{m, k} & \text{fixed price factor of paper in the region $k$ in the year $m$} & \text{euro} / (1000 \text{ton}) & M, K \\
		\delta^{\text{paper}}_{m, k} & \text{unit price factor of paper in the region $k$ in the year $m$} & \text{euro} / (10^6 \text{ton}^2) & M, K \\
		\hline
\end{array}
$$

_Table 3, summary of constants_

## 3, Objective Function

The Objective function composes of many parts:

$$
\begin{align}
    & f^{\text{timber}}_1 + f^{\text{wood}}_1 + f^{\text{pp}}_1 + g^{\text{timber}}_1 + g^{\text{fuel}}_1 + g^{\text{wood}}_1 + g^{\text{pulp}}_1 + g^{\text{paper}}_1 + f^{\text{cap}}_2 + \\
		& \sum_{n \in N} \pi_{n} \left\{ \sum_{m = 2}^3 \sigma^{m - 1} \left[f^{\text{timber}}_{n, m} + f^{\text{wood}}_{n, m} + f^{\text{pp}}_{n, m} + g^{\text{timber}}_{n, m} + g^{\text{fuel}}_{n, m} + g^{\text{wood}}_{n, m} + g^{\text{pulp}}_{n, m} + g^{\text{paper}}_{n, m} \right] + \sigma f^{\text{cap}}_{n, 3} \right\}
\end{align}
$$

- When m = 1, the variables are here-and-now decisions variables:

1. cost of timber procurement: $ f^{\text{timber}}_m = - \sum_{t \in T} h_{m, t} (\alpha_t + \beta_t h_{m, t}) $

2. cost of wood production: $ f^{\text{wood}}_m = - \sum_{i \in I} c^I_i y^I_{m, i} $

3. cost of pulp and paper production: $ f^{\text{pp}}_m = - \sum_{j \in J} c^J_j y^J_{m, j} - \sum_{m \in M} c^{\text{paper}} y^{\text{paper}}_m $

4. profit of left timbers selling:

$$
g^{\text{timber}}_m = \sum_{t \in T^1} \alpha_t \left(h_{m, t} - \sum_{i \in I^{T1}_t} a^I_i y^I_{m, i} \right) + \sum_{t \in T^2} \alpha_t \left(h_{m, t} + \sum_{i \in I^{T2}_t} b^I_i y^I_{m, i} - \sum_{j \in J^{T2}_t} a^J_j y^J_{m, j} - a^{\text{paper}}_t  y^{\text{paper}}_m \right)
$$

5. profit of fuel wood selling: $ g^{\text{fuel}}_m = \sum_{i \in I} p^{\text{fuel}} e^I_i y^I_{m, i} $

6. profit of wood selling: $ g^{\text{wood}}_{m} = \sum_{i \in I} \sum_{k \in K} (\omega^{I}_i)^{m-1} z^I_{m, i, k} (\gamma^{I}_{i, k} - \delta^{I}_{i, k} z^I_{m, i, k}) $

7. profit of pulp selling: $ g^{\text{pulp}}_{m} = \sum_{j \in J} \sum_{k \in K} (\omega^{J}_j)^{m-1} z^J_{m, j, k} (\gamma^{J}_{j, k} - \delta^{J}_{j, k} z^J_{m, j, k}) $

8. profit of paper selling: $ g^{\text{paper}}_{m} = \sum_{k \in K} (\omega^{\text{paper}})^{m-1} z^{\text{paper}}_{m, k} (\gamma^{\text{paper}}_{k} - \delta^{\text{paper}}_{k} z^{\text{paper}}_{m, k}) $

- When m = 2 or 3, the variables are wait-and-see decisions variables:

1. cost of timber procurement: $ f^{\text{timber}}_{n, m} = - \sum_{t \in T} h_{n, m, t} (\alpha_t + \beta_t h_{n, m, t}) $

2. cost of wood production: $ f^{\text{wood}}_{n, m} = - \sum_{i \in I} c^I_i y^I_{n, m, i} $

3. cost of pulp and paper production: $ f^{\text{pp}}_{n, m} = - \sum_{j \in J} c^J_j y^J_{n, m, j} - \sum_{m \in M} c^{\text{paper}} y^{\text{paper}}_{n, m} $

4. profit of left timbers selling:

$$
g^{\text{timber}}_{n, m} = \sum_{t \in T^1} \alpha_t \left(h_{n, m, t} - \sum_{i \in I^{T1}_t} a^I_i y^I_{n, m, i} \right) + \sum_{t \in T^2} \alpha_t \left(h_{n, m, t} + \sum_{i \in I^{T2}_t} b^I_i y^I_{n, m, i} - \sum_{j \in J^{T2}_t} a^J_j y^J_{n, m, j} - a^{\text{paper}}_t  y^{\text{paper}}_{n, m} \right)
$$

5. profit of fuel wood selling: $ g^{\text{fuel}}_{n, m} = \sum_{i \in I} p^{\text{fuel}} e^I_i y^I_{n, m, i} $

6. profit of wood selling: $ g^{\text{wood}}_{n, m} = \sum_{i \in I} \sum_{k \in K} \rho_{n, m} (\omega^{I}_i)^{m-1} z^I_{n, m, i, k} (\gamma^{I}_{i, k} - \delta^{I}_{i, k} z^I_{n, m, i, k}) $

7. profit of pulp selling: $ g^{\text{pulp}}_{n, m} = \sum_{j \in J} \sum_{k \in K} \rho_{n, m} (\omega^{J}_j)^{m-1} z^J_{n, m, j, k} (\gamma^{J}_{j, k} - \delta^{J}_{j, k} z^J_{n, m, j, k}) $

8. profit of paper selling: $ g^{\text{paper}}_{n, m} = \sum_{k \in K} \rho_{n, m} (\omega^{\text{paper}})^{m-1} z^{\text{paper}}_{n, m, k} (\gamma^{\text{paper}}_{k} - \delta^{\text{paper}}_{k} z^{\text{paper}}_{n, m, k}) $

- Cost of capacity expansion:

$$
\begin{align}
		f^{\text{cap}}_2 = o^{\text{saw}} (x^{\text{saw}}_2 - x^{\text{saw}}_{1}) + o^{\text{plywood}} (x^{\text{plywood}}_2 - x^{\text{plywood}}_{1}) + \sum_{j \in J} o^J_j (x^J_{2, j} - x^J_{1, j}) + o^{\text{paper}} (x^{\text{paper}}_2 - x^{\text{paper}}_1) \\
		f^{\text{cap}}_{n, 3} = o^{\text{saw}} (x^{\text{saw}}_{n, 3} - x^{\text{saw}}_{2}) + o^{\text{plywood}} (x^{\text{plywood}}_{n, 3} - x^{\text{plywood}}_{2}) + \sum_{j \in J} o^J_j (x^J_{n, 3, j} - x^J_{2, j}) + o^{\text{paper}} (x^{\text{paper}}_{n, 3} - x^{\text{paper}}_{2})
\end{align}
$$

## 4, Constraints

When $m = 1$, the constraints are the same as those in dynamic model. When $m = 2 \text{ or } 3$, besides the constraints that all variables are non-negative, there many ten sets of constraints:

1. limit of timber amount in wood production:

$$
h_{n, m, t} \geq \sum_{i \in I^{T1}_t} a^I_{i} y^I_{n, m, i} \quad \forall t \in T^1, m \in \{2, 3\}, n \in N
$$

2. limit of timber amount in pulp and paper production:

$$
\left(h_{n, m, t} + \sum_{i \in I^{T2}_t} b^I_{i} y^I_{n, m, i} \right) \geq \sum_{j \in J^{T2}_t} a^J_j y^J_{n, m, j} + a^{\text{paper}}_{t} y^{\text{paper}}_{n, m} \quad \forall t \in T^2, m \in \{2, 3\}, n \in N
$$

3. limit of pulp amount in paper production:

$$
y^J_{n, m, j} \geq b^{\text{paper}}_j y^{\text{paper}}_{n, m} \quad \forall j \in J, m \in \{2, 3\}, n \in N
$$

4. limit of wood amount in selling:

$$
y^I_{n, m, i} \geq \sum_{k \in K} z^I_{n, m, i, k} \quad \forall i \in I, m \in \{2, 3\}, n \in N
$$

5. limit of pulp amount in selling:

$$
y^J_{n, m, j} - b^{\text{paper}}_j y^{\text{paper}}_{n, m} \geq \sum_{k \in K} z^J_{n, m, j, k} \quad \forall j \in J, m \in \{2, 3\}, n \in N
$$

6. limit of paper amount in selling:

$$
y^{\text{paper}}_{n, m} \geq \sum_{k \in K} z^{\text{paper}}_{n, m, k} \quad \forall m \in \{2, 3\}, n \in N
$$

7. limit of capacity in saw mill:

$$
\begin{align}
    & \sum_{i \in I^{\text{saw}}} y^I_{n, m, i} \leq x^{\text{saw}}_{n, m} \quad \forall m \in \{2, 3\}, n \in N \\
		& x^{\text{saw}}_{1, 2} = x^{\text{saw}}_{n, 2} \quad \forall n \in \{2, 3, 4\}
\end{align}
$$

8. limit of capacity in plywood mill:

$$
\begin{align}
    & \sum_{i \in I^{\text{plywood}}} y^I_{m, i} \leq x^{\text{plywood}}_{m} \quad \forall m \in \{2, 3\}, n \in N \\
		& x^{\text{plywood}}_{1, 2} = x^{\text{plywood}}_{n, 2} \quad \forall n \in \{2, 3, 4\}
\end{align}
$$

9. limit of capacity in pulp production:

$$
\begin{align}
		& y^J_{n, m, j} \leq x^J_{n, m, j} \quad \forall j \in J, m \in \{2, 3\}, n \in N \\
		& x^J_{1, 2, j} = x^J_{n, 2, j} \quad \forall n \in \{2, 3, 4\}, j \in J
\end{align}
$$

10. limit of capacity in paper production:

$$
\begin{align}
    & y^{\text{paper}}_{n, m} \leq x^{\text{paper}}_{n, m} \quad \forall m \in \{2, 3\}, n \in N \\
		& x^{\text{paper}}_{1, 2} = x^{\text{paper}}_{n, 2} \quad \forall n \in \{2, 3, 4\}
\end{align}
$$

11. relation between capacity expansion factors

$$
\begin{align}
    & x_{1} = r \quad \forall x, r \\
    & x_{2} \geq x_{1} \quad \forall x \\
    & x_{3} \geq x_{2} \quad \forall x \\
    & x_{m} \leq \nu r \quad \forall x, m \in M \\
\end{align}
$$
