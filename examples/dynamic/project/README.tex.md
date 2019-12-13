

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
\begin{align}
	J &= \sum_{i=0}^{N-1} \frac{1}{2} m g \left( y_{i} + y_{i+1} \right) \\
	&= \sum_{i=0}^{N-1} \left( m g y_{i} + \frac{1}{2} m g l sin(\theta_i) \right)
\end{align}
$$

where

$$
\begin{align}
	\phi \left( \left[ \begin{array}{l}{z} \\ {y} \end{array} \right]_{N} \right) &= 0 \\
	L \left( \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i}, \theta_i \right) &= m g y_{i} + \frac{1}{2} m g l sin(\theta_i)
\end{align}
$$

### Solve the Problem

The Hamiltonian function is:

$$
H_i = m g y_{i} + \frac{1}{2} m g l \sin(\theta_i) + \lambda^z_{i+1} \left[ z_{i} + \cos \left(\theta_{i} \right) \right] + \lambda^y_{i+1} \left[ y_{i} + \sin \left(\theta_{i} \right)  \right]
$$

Euler-Lagrange equations are:

$$
\begin{align}
	z_{i+1} &= z_{i} + \cos \left(\theta_{i} \right) \\
	y_{i+1} &= y_{i} + \cos \left(\theta_{i} \right) \\
	\lambda^{z}_{i} &= \lambda^z_{i+1} \\
	\lambda^{y}_{i} &= m g + \lambda^y_{i+1} \\
	0 &= \left[ \frac{1}{2} m g l + \lambda^y_{i+1} \right] \cos(\theta_i) - \lambda^z_{i+1} \sin(\theta_i)
\end{align}
$$

where the boundary conditions are:

$$
\begin{align}
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{0} &= \left[ \begin{array}{l}{0} \\ {0}\end{array} \right] \\
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{N} &= \left[ \begin{array}{l}{h} \\ {0}\end{array} \right]
\end{align}
$$

When $h = 6, L = 10, M = 14, N = 6$, the results are:

The value of the costate vector at 0, $\left[ \lambda^{z}_{i}, \lambda^{y}_{i} \right]^{T}_{0}$, is:



Determine  Increase the number of elements in the chain to e.g. N = 100 and plot the chain again. Also determine the value of the costate vector in the beginning of the chain.

### Vertical Force and Costate Vector

Determine the vertical force in the origin (i = 0). Compare this with the costate at the origin. Discuss your observations. Give a qualified guess on the sign of horizontal force in the origin.
