

function [z_n, y_n, z_t, y_t, lambda_z_t, lambda_y_t] = cal_chain(...
		vec_guess, s_data)
% Calculate `z_n` and `y_n` using guessed `lambda_z_0` and `lambda_z_0`

	% [z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = cal_chain_1d(...
	% 	vec_guess, s_data);
	[z_t, y_t, u_t, v_t, lambda_z_t, lambda_y_t] = cal_chain_2d(...
		vec_guess, s_data);

	n = s_data.n;
	z_n = z_t(n + 1);
	y_n = y_t(n + 1);
end


function [z_t, y_t, u_t, v_t, lambda_z_t, lambda_y_t] = cal_chain_2d(...
		vec_guess, s_data)

	m = s_data.m;
	g = s_data.g;
	l = s_data.l;
	n = s_data.n;

	%% Initialize the Vectors to Store the Results
	z_t = zeros(n + 1, 1);
	y_t = zeros(n + 1, 1);
	lambda_z_t = zeros(n + 1, 1);
	lambda_y_t = zeros(n + 1, 1);
	u_t = zeros(n, 1);
	v_t = zeros(n, 1);

	z_t(1) = s_data.z_0;
	y_t(1) = s_data.y_0;
	lambda_z_t(1) = vec_guess(1);
	lambda_y_t(1) = vec_guess(2);

	%% Begin Iteration
	%% Notice that `i` starts from 1 to (n-1).
	for j = 0:(n-1)
		i = j + 1;
		% [z_t(i); y_t(i); lambda_z_t(i); lambda_y_t(i)]
		lambda_z_t(i+1) = lambda_z_t(i);
		lambda_y_t(i+1) = lambda_y_t(i) - m * g;
		[u_t(i), v_t(i)] = optim_2d(z_t(i), y_t(i), lambda_z_t(i+1), ...
			lambda_y_t(i+1), m, g, l);
		z_t(i+1) = z_t(i) + u_t(i);
		y_t(i+1) = y_t(i) + v_t(i);
	end
end


function [u_i, v_i] = optim_2d(z_i, y_i, lambda_z_i1, lambda_y_i1, m, g, l)
% Trigonometric	functions cannot be used in `solve`

	x = optimvar('x', 2, 1, 'LowerBound', [-1.0; -1.0] * l, ...
		'UpperBound', [1.0; 1.0] * l);
	obj = m * g * y_i + 0.5 * m * g * x(2) + ...
		lambda_z_i1 * (z_i + x(1)) + lambda_y_i1 * (y_i + x(2));
	prob = optimproblem('Objective', obj);
	% nlcons = x(1)^2 + x(2)^2 - 1 <= 10E-6;
	nlcons = x(1)^2 + x(2)^2 == l^2;
	prob.Constraints.circlecons = nlcons;
	x_0.x = [l / sqrt(2); l / sqrt(2)];
	% opt = optimoptions('fmincon', 'Display', 'off');

	[sol, fval, exitflag, output] = solve(prob, x_0);
	u_i = sol.x(1);
	v_i = sol.x(2);
end


function [z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = cal_chain_1d(...
		vec_guess, s_data)

	m = s_data.m;
	g = s_data.g;
	l = s_data.l;
	n = s_data.n;

	%% Initialize the Vectors to Store the Results
	z_t = zeros(n + 1, 1);
	y_t = zeros(n + 1, 1);
	lambda_z_t = zeros(n + 1, 1);
	lambda_y_t = zeros(n + 1, 1);
	theta_t = zeros(n, 1);

	z_t(1) = s_data.z_0;
	y_t(1) = s_data.y_0;
	lambda_z_t(1) = vec_guess(1);
	lambda_y_t(1) = vec_guess(2);

	%% Begin Iteration
	%% Notice that `i` starts from 1 to (n-1).
	for j = 0:(n-1)
		i = j + 1;
		% [z_t(i); y_t(i); lambda_z_t(i); lambda_y_t(i)]
		lambda_z_t(i+1) = lambda_z_t(i);
		lambda_y_t(i+1) = lambda_y_t(i) - m * g;
		theta_t(i) = cal_theta_i(lambda_z_t(i+1), lambda_y_t(i+1), m, g, l);
		% theta_t(i) = cal_theta_i_pontryagins(z_i, y_i, lambda_z_i1, ...
		% 	lambda_y_i1, m, g, l);
		z_t(i+1) = z_t(i) + l * cos(theta_t(i));
		y_t(i+1) = y_t(i) + l * sin(theta_t(i));
	end
end


function theta_i = cal_theta_i(lambda_z_i1, lambda_y_i1, m, g, l)
	theta_i = atan((lambda_y_i1 + 0.5 * m * g) / lambda_z_i1);
end
