

function [err, z_t, y_t] = cal_chain(vec_guess, s_data, dim, whe_print)
% Calculate `z_n` and `y_n` using guessed `lambda_z_0` and `lambda_z_0`
% using either 1 dimensional method or 2 dimensional method.

	if dim == 1
		[z_t, y_t, ~, ~] = cal_chain_1d(vec_guess, s_data, whe_print);
	elseif dim == 2
		[z_t, y_t, ~, ~] = cal_chain_2d(vec_guess, s_data, whe_print);
	end

	%% Calculate the error
	n = s_data.n;
	h = s_data.h;
	z_n = z_t(n + 1);
	y_n = y_t(n + 1);
	err = [z_n - h; y_n];
end


function [z_t, y_t, lambda_z_t, lambda_y_t] = cal_chain_2d(...
		vec_guess, s_data, whe_print)

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
		[u_t(i), v_t(i)] = optim_2d_fmincon(z_t(i), y_t(i), lambda_z_t(i+1), ...
			lambda_y_t(i+1), m, g, l);
		z_t(i+1) = z_t(i) + u_t(i);
		y_t(i+1) = y_t(i) + v_t(i);
	end

	if whe_print
		z_t
		y_t
		u_t
		v_t
		lambda_z_t
		lambda_y_t
	end
end


% function [u_i, v_i] = optim_2d(z_i, y_i, lambda_z_i1, lambda_y_i1, m, g, l)
% % Trigonometric	functions cannot be used in `solve`
%
% 	x = optimvar('x', 2, 1, 'LowerBound', [-l; -l], 'UpperBound', [l; l]);
% 	obj = m * g * y_i + 0.5 * m * g * x(2) + ...
% 		lambda_z_i1 * (z_i + x(1)) + lambda_y_i1 * (y_i + x(2));
% 	prob = optimproblem('Objective', obj);
% 	% nlcons = x(1)^2 + x(2)^2 - 1 <= 10E-6;
% 	nlcons = x(1)^2 + x(2)^2 == l^2;
% 	prob.Constraints.circlecons = nlcons;
% 	x_0.x = [l / sqrt(2); - l / sqrt(2)];
% 	% opt = optimoptions('fmincon', 'Display', 'off');
%
% 	[sol, fval, exitflag, output] = solve(prob, x_0);
% 	u_i = sol.x(1);
% 	v_i = sol.x(2);
% end


function [u_i, v_i] = optim_2d_fmincon(z_i, y_i, lambda_z_i1, lambda_y_i1, ...
		m, g, l)
% Trigonometric	functions can be used in `fmincon`

	fun = @(x) m * g * y_i + 0.5 * m * g * x(2) + ...
		lambda_z_i1 * (z_i + x(1)) + lambda_y_i1 * (y_i + x(2));
	A = [];
	b = [];
	Aeq = [];
	beq = [];
	lb = [-1; -1] * l;
	ub = [1; 1] * l;
	nonlcon = @(x) get_nonlcon(x, l);
	x0 = [l; 0]; % [l / sqrt(2); - l / sqrt(2)];
	options = optimoptions('fmincon', 'Display', 'off');
	% , 'Algorithm', 'sqp'
	sol = fmincon(fun, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
	u_i = sol(1);
	v_i = sol(2);
end


function [c, ceq] = get_nonlcon(x, l)
	c = [];
	ceq = x(1)^2 + x(2)^2 - l^2;
end


function [z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = cal_chain_1d(...
		vec_guess, s_data, whe_print)

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
		% theta_t(i) = cal_theta_i_pontryagins_fmincon(z_t(i), y_t(i), ...
		% 	lambda_z_t(i+1), lambda_y_t(i+1), m, g, l);
		% theta_t(i) = cal_theta_i_pontryagins_fsolve(z_t(i), y_t(i), ...
		% 	lambda_z_t(i+1), lambda_y_t(i+1), m, g, l);
		z_t(i+1) = z_t(i) + l * cos(theta_t(i));
		y_t(i+1) = y_t(i) + l * sin(theta_t(i));
	end

	if whe_print
		z_t
		y_t
		theta_t
		lambda_z_t
		lambda_y_t
	end
end


function theta_i = cal_theta_i(lambda_z_i1, lambda_y_i1, m, g, l)
% "_i1" indicates the index is (i+1)
	theta_i = atan((lambda_y_i1 + 0.5 * m * g) / lambda_z_i1);
end


function theta_i = cal_theta_i_pontryagins_fmincon(z_i, y_i, lambda_z_i1, ...
		lambda_y_i1, m, g, l)

	fun = @(theta) m * g * y_i + 0.5 * m * g * l * sin(theta) + ...
		lambda_z_i1 * (z_i + l * cos(theta)) + ...
		lambda_y_i1 * (y_i + l * sin(theta));
	A = [];
	b = [];
	Aeq = [];
	beq = [];
	lb = - pi;
	ub = pi;
	nonlcon = [];
	x0 = - pi / 4;
	options = optimoptions('fmincon', 'Display', 'off');
	% , 'Algorithm', 'sqp'
	theta_i = fmincon(fun, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
end


function theta_i = cal_theta_i_pontryagins_fsolve(z_i, y_i, lambda_z_i1, ...
		lambda_y_i1, m, g, l)

	options = optimoptions('fsolve', 'Display', 'off', ...
		'Algorithm', 'levenberg-marquardt');
	%
	theta_i = fsolve(@(theta) m * g * y_i + ...
		0.5 * m * g * l * sin(theta) + ...
		lambda_z_i1 * (z_i + l * cos(theta)) + ...
		lambda_y_i1 * (y_i + l * sin(theta)), 0, options);
end
