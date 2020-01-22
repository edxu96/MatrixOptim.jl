
# Metsa-Oy Production and Supply Chain 2: Dynamic

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
    x^{\text{saw}}_{m} & \text{capacity of saw mill} & \text{linear} & - & M^{2} \\
    x^{\text{plywood}}_{m} & \text{capacity of plywood mill} & \text{linear} & - & M^{2} \\
    x^J_{m, j} & \text{capacity of pulp production line} & \text{linear} & - & M^{2}, J \\
    x^{\text{paper}}_{m} & \text{capacity of paper production line} & \text{linear} & - & M^{2} \\
		\hline
\end{array}
$$

_Table 2, summary of decision variables_

$$
\begin{array}{c l c c}
		\hline
		\text{Symbol} & \text{Definition} & \text{Unit} & \text{Set} \\
		\hline
		p^{\text{fuel}} & \text{price of fuel wood} & \text{euro} / (1000 m^3) & - \\
    \sigma & \text{annual discounting factor} & - & - \\
		\alpha_t & \text{fixed cost factor of purchasing wood} & \text{euro} / (1000 m^3) & T \\
		\beta_t & \text{unit cost factor of purchasing wood} & \text{euro} / (1000 m^6) & T \\
		a^I_i & \text{relation of timber input and output in wood production} & - & I\\
		b^I_i & \text{relation of timber output and output in wood production} & - & I \\
		e^I_i & \text{relation of fuel output and output in wood production} & - & I \\
		c^I_i & \text{cost of wood production} & \text{euro} / (1000 m^3) & I \\
		r^{\text{saw}} & \text{original capacity of saw mill} & 1000 m^3 / \text{year} & - \\
		r^{\text{plywood}} & \text{original capacity of plywood mill} & 1000 m^3 / \text{year} & - \\
    o^{\text{saw}} & \text{capacity expansion cost of saw mill} & \text{euro} / (1000 m^3 / \text{year}) & - \\
    o^{\text{plywood}} & \text{capacity expansion cost of plywood mill} & \text{euro} / (1000 m^3 / \text{year}) & - \\
    \nu^{\text{saw}} & \text{max capacity expansion factor of saw mill} & - & - \\
    \nu^{\text{plywood}} & \text{max capacity expansion factor of saw mill} & - & - \\
		a^J_j & \text{input and output relation of pulp production} & - & J \\
		c^J_j & \text{cost of pulp production} & \text{euro} / (1000 \text{ton}) & J \\
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

The Objective function composes of seven parts:

$$
\sum_{m \in M} \sigma^{m - 1} \left[ f^{\text{timber}}_m + f^{\text{wood}}_m + f^{\text{pp}}_m + g^{\text{timber}}_m + g^{\text{fuel}}_m + g^{\text{wood}}_m + g^{\text{pulp}}_m + g^{\text{paper}}_m \right] + f^{\text{cap}}
$$

1. cost of timber procurement: $ f^{\text{timber}}_m = - \sum_{t \in T} h_{m, t} (\alpha_t + \beta_t h_{m, t}) $

2. cost of wood production: $ f^{\text{wood}}_m = - \sum_{i \in I} c^I_i y^I_{m, i} $

3. cost of pulp and paper production: $ f^{\text{pp}}_m = - \sum_{j \in J} c^J_j y^J_{m, j} - \sum_{m \in M} c^{\text{paper}} y^{\text{paper}}_m $

4. profit of left timbers selling:

$$
g^{\text{timber}}_m = \sum_{t \in T^1} \alpha_t \left(h_{m, t} - \sum_{i \in I^{T1}_t} a^I_i y^I_{m, i} \right) + \sum_{t \in T^2} \alpha_t \left(h_{m, t} + \sum_{i \in I^{T2}_t} b^I_i y^I_{m, i} - \sum_{j \in J^{T2}_t} a^J_j y^J_{m, j} - a^{\text{paper}}_t  y^{\text{paper}}_m \right)
$$

5. profit of fuel wood selling: $ g^{\text{fuel}}_m = \sum_{i \in I} p^{\text{fuel}} e^I_i y^I_{m, i} $

6. profit of wood selling: $ g^{\text{wood}}_m = \sum_{i \in I} \sum_{k \in K} z^I_{m, i, k} (\gamma^{I}_{m, i, k} - \delta^{I}_{m, i, k} z^I_{m, i, k}) $

7. profit of pulp selling: $ g^{\text{pulp}}_m = \sum_{j \in J} \sum_{k \in K} z^J_{m, j, k} (\gamma^{J}_{m, j, k} - \delta^{J}_{m, j, k} z^J_{m, j, k}) $

8. profit of paper selling: $ g^{\text{paper}}_m = \sum_{k \in K} z^{\text{paper}}_{m, k} (\gamma^{\text{paper}}_{m, k} - \delta^{\text{paper}}_{m, k} z^{\text{paper}}_{m, k}) $

9. cost of capacity expansion:

$$
f^{\text{cap}} = \sum_{m = 2}^{3} \sigma^{m - 2} \left[o^{\text{saw}} (x^{\text{saw}}_m - x^{\text{saw}}_{m-1}) + o^{\text{plywood}} (x^{\text{plywood}}_m - x^{\text{plywood}}_{m-1}) + \sum_{j \in J} o^J_j (x^J_{m, j} - x^J_{m-1, j}) + o^{\text{paper}} (x^{\text{paper}}_m - x^{\text{paper}}_{m-1}) \right]
$$

## 4, Constraints

Besides the constraints that all variables are non-negative, there are ten sets of constraints:

1. limit of timber amount in wood production:

$$
h_{m, t} \geq \sum_{i \in I^{T1}_t} a^I_{i} y^I_{m, i} \quad \forall t \in T^1, m \in M
$$

2. limit of timber amount in pulp and paper production:

$$
\left(h_{m, t} + \sum_{i \in I^{T2}_t} b^I_{i} y^I_{m, i} \right) \geq \sum_{j \in J^{T2}_t} a^J_j y^J_{m, j} + a^{\text{paper}}_{m, t} y^{\text{paper}}_m \quad \forall t \in T^2, m \in M
$$

3. limit of pulp amount in paper production:

$$
y^J_{m, j} \geq b^{\text{paper}}_j y^{\text{paper}}_{m} \quad \forall j \in J, m \in M
$$

4. limit of wood amount in selling:

$$
y^I_{m, i} \geq \sum_{k \in K} z^I_{m, i} \quad \forall i \in I, m \in M
$$

5. limit of pulp amount in selling:

$$
y^J_{m, j} - b^{\text{paper}}_j y^{\text{paper}}_{m} \geq \sum_{k \in K} z^J_{m, j, k} \quad \forall j \in J, m \in M
$$

6. limit of paper amount in selling:

$$
y^{\text{paper}}_{m} \geq \sum_{k \in K} z^{\text{paper}}_{m, k} \quad \forall m \in M
$$

7. limit of capacity in saw mill:

$$
\sum_{i \in I^{\text{saw}}} y^I_{m, i} \leq x^{\text{saw}}_{m} \quad \forall m \in M
$$

8. limit of capacity in plywood mill:

$$
\sum_{i \in I^{\text{plywood}}} y^I_{m, i} \leq x^{\text{plywood}}_{m} \quad \forall m \in M
$$

9. limit of capacity in pulp production:

$$
y^J_{m, j} \leq x^J_{m, j} \quad \forall j \in J, m \in M
$$

10. limit of capacity in paper production:

$$
y^{\text{paper}}_{m} \leq x^{\text{paper}}_{m} \quad \forall m \in M
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
