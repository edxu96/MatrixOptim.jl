
## Free Dynamic Programming

Consider the problem of payment of a (study) loan which at the start of the period is 50.000 DKK. Let us focus on the problem for a period of 10 years. We are going to determine the optimal pay back strategy for this loan, i.e. to determine how much we have to pay each year. Assume that the rate of interests is 5% per year ($\alpha = 0.05$) (and that the loan is credited each year), then the dynamics of the problem can be described by:

$$
x_{i+1} = f(x_i, u_i) = (1 + \alpha) x_{i} - u_{i}
$$

where $x_i$ is the actual size of the loan (including interests) and $u_i$ is the annual payment.

On the one hand, we are interested in minimizing the amount we have to pay to the bank. On the other hand, we don't want to pay too much at one time. The objective function, which we might use in the minimization could be

$$
J = \frac{1}{2} p x_{N}^{2} + \sum_{i=0}^{N-1} \left(\frac{1}{2} q x_{i}^{2} + \frac{1}{2} r u_{i}^{2} \right)
$$

where $q = \alpha^2$. The weights $r$ and $p$ are at our disposal. Let us for a start choose $r = q$ and $p = q$ (but let the parameters be variable in your program in order to change them easily).

### Solution

$$
\begin{align}
	N &= 10 \\
	x_0 &= 50000 \\
	\phi(x_N) &= \frac{1}{2} p x_{N}^{2} \\
	L_i(x_i, u_i) &= \frac{1}{2} q x_{i}^{2} + \frac{1}{2} r u_{i}^{2}
\end{align}
$$

The Hamiltonian function of the problem is:

$$
H_i(x_i, u_i, \lambda_{i+1}) = \frac{1}{2} q x_{i}^{2} + \frac{1}{2} r u_{i}^{2} + \lambda_{i+1}^{T} \left[(1 + \alpha) x_{i} - u_{i}  \right]
$$

The Euler-Lagrange equations can be expressed as:

$$
\begin{align}
	x_{i+1} &= (1 + \alpha) x_{i} - u_{i} \\
	\lambda_{i} &= q x_{i} + (1 + \alpha) \lambda_{i+1} \\
	0 &= r u_{i} - \lambda_{i+1}
\end{align}
$$

The calculation procedure can be expressed as:

$$
\begin{align}
	\lambda_{i+1} &= (\lambda_{i} - q x_{i}) / (1 + \alpha) \\
	u_{i} &= \lambda_{i+1} / r \\
	x_{i+1} &= (1 + \alpha) x_{i} - u_{i}
\end{align}
$$
