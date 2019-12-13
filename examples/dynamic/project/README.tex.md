

The objective in this assignment is primely to apply dynamic optimization on a specific problem rather than determining the shape of a suspended chain or cable. (This can be found in just about any text book in mechanics). In the report, it is important to give the results and an interpretation of those, but certainly also to describe the chosen method, its background and assumptions.

### Rewrite the Cost Function in Standard Form

For $i=0,1, \ldots N-1$, we have:

$$
\begin{align}
	\left[\begin{array}{l}{z} \\ {y}\end{array}\right]_{i+1} = f \left( \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i}, \left[ \begin{array}{l}{u} \\ {v}\end{array} \right]_{i} \right) &= \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i} + \left[ \begin{array}{l}{u} \\ {v}\end{array} \right]_{i} \\
	= f \left( \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i}, \theta_{i} \right) &= \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i} + l \left[ \begin{array}{l}{\cos \left(\theta_{i} \right)} \\ {\sin \left(\theta_{i} \right)}\end{array} \right]
\end{align}
$$

where the end points are:

$$
\begin{align}
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{0} &= \left[ \begin{array}{l}{0} \\ {0}\end{array} \right] \\
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{N} &= \left[ \begin{array}{l}{h} \\ {0}\end{array} \right]
\end{align}
$$

The (steady state) potential energy can be written as:

$$
J = \sum_{i=0}^{N-1} \frac{1}{2} m g \left( y_{i} + y_{i+1} \right)
$$

where

$$
\begin{align}
	\phi \left( \left[ \begin{array}{l}{z} \\ {y} \end{array} \right]_{N} \right) &= 0 \\
	L \left( \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i} \right) &= \frac{1}{2} m g \left( y_{i} + y_{i+1} \right)
\end{align}
$$

### Solve the Problem

Solve the problem by using the relation in (3) and plot the shape of the chain (for N = 6). Determine the value of the costate vector at the beginning of the chain. Increase the number of elements in the chain to e.g. N = 100 and plot the chain again. Also determine the value of the costate vector in the beginning of the chain.

Euler-Lagrange equations are:

$$
\begin{align}
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i+1} &= \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i} + l \left[ \begin{array}{l}{\cos \left(\theta_{i} \right)} \\ {\sin \left(\theta_{i} \right)}\end{array} \right] \\
	\left[ \begin{array}{l}{\lambda^z} \\ {\lambda^y}\end{array}  \right]_{i} &= \left[ \begin{array}{l}{\lambda^z} \\ {\lambda^y}\end{array}  \right]_{i}
\end{align}
$$

###

Determine the vertical force in the origin (i = 0). Compare this with the costate at the origin. Discuss your observations. Give a qualified guess on the sign of horizontal force in the origin.
