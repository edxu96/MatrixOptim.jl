
# Linear Programming

## 1, Basic Structure

## 2, Supporting Tables

$$
\begin{array}{c c c}
	  \hline
	  \text{Symbol} & \text{Definition} & \text{Example} \\
	  \hline
	  T & \text{type of timber} & \{\text{MAT}, \text{KUT}, \text{KOT}, \text{MAK}, \text{KUK}, \text{KOK} \} \\
	  I & \text{product of wood processing} & \{\text{MAS}, \text{KUS}, \text{KOS}, \text{KUV}, \text{KOV} \} \\
		J & \text{pulp production} & \{\text{HSEL}, \text{LSEL} \} \\
		K & \text{region} & \{\text{EU}, \text{IE}, \text{PA}, \text{KI} \} \\
	  \hline
\end{array}
$$

_Table 1, summary of sets_

$$
\begin{array}{c l c c}
		\hline
		\text{Symbol} & \text{Definition} & \text{Type} & \text{Unit} & \text{Set} \\
		\hline
		h_{t} & \text{purchasing amount of of wood} & \text{integer} & 1000 m^3 & T \\
		x_{i} & \text{production amount in wood processing} & \text{linear} & m^3 & I \\
		y^{\text{pulp}}_{j} & \text{production amount of pulp} & \text{linear} & m^3 & J \\
		y^{\text{paper}} & \text{production amount of paper} & \text{linear} & m^3 & - \\
		z^{\text{wood}}_{j, k} & \text{selling amount of wood in different regions} & \text{linear} & m^3 & I, K \\
		z^{\text{pulp}}_{i, k} & \text{selling amount of pulp in different regions} & \text{linear} & m^3 & J, K \\
		z^{\text{paper}}_{k} & \text{selling amount of paper in different regions} & \text{linear} & m^3 & K \\
		\hline
\end{array}
$$

_Table 2, summary of decision variables_

$$
\begin{array}{c l c c}
		\hline
		\text{Symbol} & \text{Definition} & \text{Unit} & \text{Set} \\
		\hline
		\alpha & \text{fixed cost factor of purchasing wood} & \circ / 1000m^3 & - \\
		\beta & \text{unit cost factor of purchasing wood} & \circ / 1000m^6 & - \\
		a^{\text{wood}}_{i, t} & \text{input and output relation of wood processing} & - & I, T \\
		c^{\text{wood}}_{i} & \text{cost of wood processing} & \circ & I \\
		a^{\text{pulp}}_{j, t} & \text{input and output relation of pulp production} & - & J, T \\
		a^{\text{paper}}_{t} & \text{input and output relation of paper production} & - & T \\
		\gamma^{\text{wood}}_{i, k} & \text{fixed price factor of wood products in different regions} & \circ / m^3 & I, K \\
		\gamma^{\text{pulp}}_{j, k} & \text{fixed price factor of pulp in different regions} & \circ / m^3 & J, K \\
		\gamma^{\text{paper}}_{k} & \text{fixed price factor of paper in different regions} & \circ / m^3 & K \\
		\delta^{\text{wood}}_{i, k} & \text{unit price factor of wood products in different regions} & \circ / m^6 & I, K \\
		\delta^{\text{pulp}}_{j, k} & \text{unit price factor of pulp in different regions} & \circ / m^6 & J, K \\
		\delta^{\text{paper}}_{k} & \text{unit price factor of paper in different regions} & \circ / m^6 & K \\
		\hline
\end{array}
$$

_Table 3, summary of constants_


## 3, Examples

$$
\begin{align}
    \max \quad & \sum_{i \in I} 0.2 * 40 / 1000 * x_{i}  \\
		\text{s.t.} \quad & 
\end{align}
$$
