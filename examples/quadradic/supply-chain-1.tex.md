
# Metsa-Oy Forest and Supply Chain 1: Static

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
	  \hline
\end{array}
$$

_Table 1, summary of sets_

$$
\begin{array}{c l c c c}
		\hline
		\text{Symbol} & \text{Definition} & \text{Type} & \text{Unit} & \text{Set} \\
		\hline
		h_t & \text{purchasing amount of timber $t$} & \text{integer} & 1000 m^3 & T \\
		y^I_{i} & \text{production amount of wood $i$} & \text{linear} & 1000 m^3 & I \\
		y^J_{j} & \text{production amount of pulp $j$} & \text{linear} & 1000 m^3 & J \\
		y^{\text{paper}} & \text{production amount of paper} & \text{linear} & 1000 m^3 & - \\
		z^I_{i, k} & \text{selling amount of wood $i$ in region $k$} & \text{linear} & 1000 m^3 & I, K \\
		z^J_{j, k} & \text{selling amount of pulp $j$ in region $k$} & \text{linear} & 1000 m^3 & J, K \\
		z^{\text{paper}}_{k} & \text{selling amount of paper in region $k$} & \text{linear} & 1000 m^3 & K \\
		\hline
\end{array}
$$

_Table 2, summary of decision variables_

$$
\begin{array}{c l c c}
		\hline
		\text{Symbol} & \text{Definition} & \text{Unit} & \text{Set} \\
		\hline
		\alpha_t & \text{fixed cost factor of purchasing wood $t$} & \text{euro} / (1000 m^3) & T \\
		\beta_t & \text{unit cost factor of purchasing wood $t$} & \text{euro} / (1000 m^6) & T \\
		a^I_i & \text{relation of timber input and output in wood production $i$} & - & I\\
		b^I_i & \text{relation of timber output and output in wood production $i$} & - & I \\
		e^I_i & \text{relation of fuel output and output in wood production $i$} & - & I \\
		c^I_i & \text{cost of wood production $i$} & \text{euro} / (1000 m^3) & I \\
		r^{\text{saw}} & \text{capacity of saw mill in wood production $i$} & 1000 m^3 / \text{year} & - \\
		r^{\text{plywood}} & \text{capacity of plywood mill in wood production $i$} & 1000 m^3 / \text{year} & - \\
		a^J_j & \text{input and output relation of pulp production $j$} & - & J \\
		c^J_j & \text{cost of pulp production $j$} & \text{euro} / (1000 \text{ton}) & J \\
		r^J_j & \text{capacity of pulp production $j$} & 1000 \text{ton} / \text{year} & J \\
		a^{\text{paper}}_{t} & \text{relation of timber inputs in paper production} & - & T \\
		b^{\text{paper}}_{j} & \text{relation of pulp inputs in paper production} & - & J \\
		c^{\text{paper}} & \text{cost of paper production} & \text{euro} / (1000 \text{ton}) & - \\
		r^{\text{paper}} & \text{capacity of paper production} & 1000 \text{ton} / \text{year} & - \\
		\gamma^{I}_{i, k} & \text{fixed price factor of wood $i$ in region $k$} & \text{euro} / (1000 m^3) & I, K \\
		\delta^{I}_{i, k} & \text{unit price factor of wood $i$ in region $k$} & \text{euro} / (10^6 m^6) & I, K \\
		\gamma^{J}_{j, k} & \text{fixed price factor of pulp $j$ in region $k$} & \text{euro} / (1000 \text{ton}) & J, K \\
		\delta^{J}_{j, k} & \text{unit price factor of pulp $j$ in region $k$} & \text{euro} / (10^6 \text{ton}^2) & J, K \\
		\gamma^{\text{paper}}_{k} & \text{fixed price factor of paper in region $k$} & \text{euro} / (1000 \text{ton}) & K \\
		\delta^{\text{paper}}_{k} & \text{unit price factor of paper in region $k$} & \text{euro} / (10^6 \text{ton}^2) & K \\
		p^{\text{fuel}} & \text{price of fuel wood} & \text{euro} / (1000 m^3) & - \\
		\hline
\end{array}
$$

_Table 3, summary of constants_

## 3, Objective Function

The Objective function composes of seven parts:

$$
f^{\text{timber}} + f^{\text{wood}} + f^{\text{pp}} + g^{\text{timber}} + g^{\text{fuel}} + g^{\text{wood}} + g^{\text{pulp}} + g^{\text{paper}}
$$

1. cost of timber procurement: $ f^{\text{timber}} = - \sum_{t \in T} h_{t} (\alpha_t + \beta_t h_{t}) $

2. cost of wood production: $ f^{\text{wood}} = - \sum_{i \in I} c^I_i y^I_i $

3. cost of pulp and paper production: $ f^{\text{pp}} = - \sum_{j \in J} c^J_j y^J_j - c^{\text{paper}} y^{\text{paper}} $

4. profit of left timbers selling:

$$
g^{\text{timber}} = \sum_{t \in T^1} \alpha_t \left(h_t - \sum_{i \in I^{T1}_t} a^I_i y^I_i \right) + \sum_{t \in T^2} \alpha_t \left(h_t + \sum_{i \in I^{T2}_t} b^I_i y^I_i - \sum_{j \in J^{T2}_t} a^J_j y^J_j - a^{\text{paper}}_t y^{\text{paper}} \right)
$$

5. profit of fuel wood selling: $ g^{\text{fuel}} = \sum_{i \in I} p^{\text{fuel}} e^I_i y^I_i $

6. profit of wood selling: $ g^{\text{wood}} = \sum_{i \in I} \sum_{k \in K} z^I_{i, k} (\gamma^{I}_{i, k} - \delta^{I}_{i, k} z^I_{i, k}) $

7. profit of pulp selling: $ g^{\text{pulp}} = \sum_{j \in J} \sum_{k \in K} z^J_{j, k} (\gamma^{J}_{j, k} - \delta^{J}_{j, k} z^J_{j, k}) $

8. profit of paper selling: $ g^{\text{paper}} = \sum_{k \in K} z^{\text{paper}}_k (\gamma^{\text{paper}}_k - \delta^{\text{paper}}_k z^{\text{paper}}_k) $

## 4, Constraints

Besides the constraints that all variables are non-negative, there are ten sets of constraints:

1. limit of timber amount in wood production:

$$
h_t \geq \sum_{i \in I^{T1}_t} a^I_i y^I_i \quad \forall t \in T^1
$$

2. limit of timber amount in pulp and paper production:

$$
\left(h_t + \sum_{i \in I^{T2}_t} b^I_i y^I_i \right) \geq \sum_{j \in J^{T2}_t} a^J_j y^J_j + a^{\text{paper}}_t y^{\text{paper}} \quad \forall t \in T^2
$$

3. limit of pulp amount in paper production:

$$
y^J_j \geq b^{\text{paper}}_j y^{\text{paper}} \quad \forall j \in J
$$

4. limit of wood amount in selling:

$$
y^I_i \geq \sum_{k \in K} z^I_{i, k} \quad \forall i \in I
$$

5. limit of pulp amount in selling:

$$
y^J_j - b^{\text{paper}}_j y^{\text{paper}} \geq \sum_{k \in K} z^J_{j, k} \quad \forall j \in J
$$

6. limit of paper amount in selling:

$$
y^{\text{paper}} \geq \sum_{k \in K} z^{\text{paper}}_k
$$

7. limit of capacity in saw mill:

$$
\sum_{i \in I^{\text{saw}}} y^I_i \leq r^{\text{saw}}
$$

8. limit of capacity in plywood mill:

$$
\sum_{i \in I^{\text{plywood}}} y^I_i \leq r^{\text{plywood}}
$$

9. limit of capacity in pulp production:

$$
y^J_j \leq r^J_j \quad \forall j \in J
$$

10. limit of capacity in paper production:

$$
y^{\text{paper}} \leq r^{\text{paper}}
$$

## 5, Result

obj = $\underline{\underline{5.9649e6}}$

```
result_h_t = [0.0, -0.0, -0.0, 77.0, 80.0, 68.0]
result_y_i = [0.0, 0.0, 0.0, 0.0, 0.0]
result_y_j = [16.0, 16.0]
result_y_paper = 80.0
result_z_ik = [
	0.0 130.0 58.33 50.0; 
	0.0 60.0 54.17 46.67;
	0.0 35.0 31.25 32.0;
	0.0 190.0 150.0 97.22;
	537.5 292.86 162.5 126.67
	]
result_z_jk = [
	0.0 312.5 230.0 216.67;
	0.0 700.0 191.67 178.57142857142858
	]
result_z_paper_k = [24.85, 27.39, 6.16, 21.60]
```
