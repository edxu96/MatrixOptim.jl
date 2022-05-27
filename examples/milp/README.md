
# Linear Programming

## 1, Basic Structure

## 2, Supporting Tables

$$
\begin{array}{c c c}
	\hline
	\text{Symbol} & \text{Definition} & \text{Example} \\
	\hline
	T & \text{Time Units} & (12:15, 12:45), (12:45, 13:15) \\
	J & \text{Controllable generation technologies} & \{\text{Gas Turbine}, \text{Biomass Power Generation}\} \\
	\hline
\end{array}
$$

_Table 1, summary of sets_

$$
\begin{array}{c l c c}
	\hline
	\text{Symbol} & \text{Definition} & \text{Unit} & \text{Set} \\
	\hline
	y_{j} & \text{Capacity of different generation technologies} & \text{MW} & J \\
	x_{j, t} & \text{Average power output during time interval} & \text{MW} & J, T \\
	z & \text{Percent of new wind turbine compared with installed} & \text{MW} & {\text{wind}} \\
	\hline
\end{array}
$$

_Table 2, summary of decision variables_

$$
\begin{array}{c l c c}
	\hline
	\text{Symbol} & \text{Definition} & \text{Unit} & \text{Set} \\
	\hline
	w_{t} & \text{Historical wind power output of installed turbines} & \text{MW} & T \\
	d_{t} & \text{Historical electricity demand} & \text{MW} & T \\
	a & \text{Length of the time interval} & \text{hour} & - \\
	c^{fix}_{j} & \text{Fixed cost per capacity of conventional generation technologies} & \text{DKK / MW} & J \\
	c^{fix, wind} & \text{Fixed cost per percent capacity of wind turbines} & \text{DKK / %} &{\text{wind}} \\
	c^{var}_{j} & \text{Production cost per unit output of different generation technologies} & \text{DKK / MW} & J \\
	s^{max}_{j} & \text{Max percent of controllable increment power output} & \text{%} & J \\
	\beta^{min}_{j} & \text{Minimum percent of load percent of full load} & \text{%} & J \\
	\hline
\end{array}
$$

_Table 2, summary of constants_

## 3, Examples
