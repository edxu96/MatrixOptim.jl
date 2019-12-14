
# Find the Trajectory using Dynamic Optimization

In the report, it is important to give the results and an interpretation of those, but certainly also to describe the chosen method, its background and assumptions.

## 1, Trajectory of a Suspended Chain

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
	y_{i+1} &= y_{i} + \sin \left(\theta_{i} \right) \\
	\lambda^{z}_{i} &= \lambda^z_{i+1} \\
	\lambda^{y}_{i} &= m g + \lambda^y_{i+1} \\
	0 &= \left[ \frac{1}{2} m g l + \lambda^y_{i+1} \right] \cos(\theta_i) - \lambda^z_{i+1} \sin(\theta_i)
\end{align}
$$

where the boundary conditions are:

$$
\begin{align}
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{0} &= \left[ \begin{array}{l}{0} \\ {0}\end{array} \right] \\
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{N} &= \left[ \begin{array}{l}{h} \\ {0}\end{array} \right] \\
	\left[ \begin{array}{l}{\lambda_z} \\ {\lambda_y} \\ {\theta} \end{array} \right]_{N} &= \left[ \begin{array}{l}{\nu_z} \\ {\nu_y} \\ {1} \end{array} \right] \\
\end{align}
$$

The calculate procedure for iterations can be expressed by the following equations:

$$
\begin{align}
	\lambda^z_{i+1} &= \lambda^{z}_{i} \\
	\lambda^y_{i+1} &= \lambda^{y}_{i} - m g \\
	\theta_i &= \arctan \left[ \left( \lambda^y_{i+1} + \frac{1}{2} m g l \right) / \lambda^z_{i+1} \right] \\
	z_{i+1} &= z_{i} + \cos \left(\theta_{i} \right) \\
	y_{i+1} &= y_{i} + \sin \left(\theta_{i} \right) \\
\end{align}
$$

or the following equations according to Pontryagins Maximum principle:

$$
\begin{align}
	\lambda^z_{i+1} &= \lambda^{z}_{i} \\
	\lambda^y_{i+1} &= \lambda^{y}_{i} - m g \\
	\theta_i &= \arg \min_{-\pi/2 \leq \theta_i \leq \pi/2} \left\{ m g y_{i} + \frac{1}{2} m g l \sin(\theta_i) + \lambda^z_{i+1} \left[ z_{i} + \cos \left(\theta_{i} \right) \right] + \lambda^y_{i+1} \left[ y_{i} + \sin \left(\theta_{i} \right) \right] \right\} \\
	z_{i+1} &= z_{i} + \cos \left(\theta_{i} \right) \\
	y_{i+1} &= y_{i} + \sin \left(\theta_{i} \right) \\
\end{align}
$$

When $h = 6, L = 10, M = 14, N = 6$, the results are:

The value of the costate vector at 0, $\left[ \lambda^{z}_{i}, \lambda^{y}_{i} \right]^{T}_{0}$, is:

When $h = 6, L = 10, M = 14, N = 100$, the results are:

The value of the costate vector at 0, $\left[ \lambda^{z}_{i}, \lambda^{y}_{i} \right]^{T}_{0}$, is:

### Vertical Force and Costate Vector

Determine the vertical force in the origin (i = 0). Compare this with the costate at the origin. Discuss your observations. Give a qualified guess on the sign of horizontal force in the origin.

### Two Symmetric Half Chains

For $i=0,1, \ldots N-1$, we have:

$$
\begin{align}
	\left[\begin{array}{l}{z} \\ {y}\end{array}\right]_{i+1} = f \left( \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i}, \left[ \begin{array}{l}{u} \\ {v}\end{array} \right]_{i} \right) &= \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i} + \left[ \begin{array}{l}{u} \\ {v}\end{array} \right]_{i} \\
	= f \left( \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i}, \theta_{i} \right) &= \left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{i} + l \left[ \begin{array}{l}{\cos \left(\theta_{i} \right)} \\ {\sin \left(\theta_{i} \right)}\end{array} \right]
\end{align}
$$

where the boundary conditions are:

$$
\begin{align}
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{0} &= \left[ \begin{array}{l}{0} \\ {0}\end{array} \right] \\
	z_{N} &= h / 2
\end{align}
$$

When $N = 2n$

## 2, Trajectory of a Suspended Wire

Now, the chain is substituted by a wire and the problem becomes a continuous problem. Let $s$ the distance along the wire. The positions along the wire obey

$$
\frac{d}{d s} \left[ \begin{array}{l}{z_{s}} \\ {y_{s}}\end{array} \right] = f(\theta_s) = \left[ \begin{array}{c}{\cos \left( \theta_{s}\right)} \\ {\sin \left( \theta_{s} \right)}\end{array} \right]
$$

where the boundary conditions are:

$$
\begin{align}
	\left[ \begin{array}{l}{z} \\ {y} \end{array} \right]_{0} = \left[ \begin{array}{l}{0} \\ {0}\end{array} \right] \\
	\left[ \begin{array}{l}{z} \\ {y}\end{array} \right]_{L} = \left[ \begin{array}{l}{h} \\ {0} \end{array} \right]
\end{align}
$$

So the potential energy in steady state can be expressed by:

$$
J = \int_{0}^{S} M g y / S \mathrm{d} s
$$

where

$$
\begin{align}
	\phi(\theta_S) &= 0 \\
	L(y_s) &= \rho M g y / S
\end{align}
$$

The Hamiltonian function is:

$$
H_s = \rho M g y / S + \lambda^z \cos \left( \theta\right) + \lambda^y \sin \left( \theta\right)
$$

Euler-Lagrange equations are:

$$
\begin{align}
	\dot{z} &= \cos \left( \theta\right) \\
	\dot{y} &= \sin \left( \theta\right) \\
	- \lambda^z &= 0 \\
	- \lambda^y &= \rho M g / S \\
	0 &= - \lambda^z \sin \left( \theta\right) + \lambda^y \cos \left( \theta\right)
\end{align}
$$

or the following equations according to Pontryagins Maximum principle:

$$
\begin{align}
	- \lambda^z &= 0 \\
	- \lambda^y &= \rho M g / S \\
	\theta &= \arg \min_{-\pi/2 \leq \theta \leq \pi/2} \left[ \rho M g y / S + \lambda^z \cos \left( \theta\right) + \lambda^y \sin \left( \theta\right) \right] \\
	\dot{z} &= \cos \left( \theta\right) \\
	\dot{y} &= \sin \left( \theta\right)
\end{align}
$$

Plot the shape of the wire and discuss your observations. Determine the value of the costate vector in origin. Investigate the variation of the Hamiltonian function (i.e. the variation of the Hamiltonian as function of $s$). Plot the function as function of s and explain what you see - and why.
