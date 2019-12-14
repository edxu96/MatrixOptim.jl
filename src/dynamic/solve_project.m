
function [vec_guess_star, z_t, y_t, lambda_z_t, lambda_y_t] = solve_project()

s_data = get_data_chain();

%% Chose the function to optimize
% vec_guess_star = optim_fsolve(s_data);
vec_guess_star = optim_fmincon(s_data);

[err_star, z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = ...
	cal_chain(vec_guess_star, s_data);

err_star
z_t
y_t
theta_t
lambda_z_t
lambda_y_t

%% Plot the results
% shg

end


function vec_guess_star = optim_fsolve(s_data)
	opt = optimoptions('fsolve', 'Display', 'iter');
	% , 'Algorithm', 'levenberg-marquardt'
	vec_guess_star = fsolve(@(vec_guess) cal_chain_vector(vec_guess, s_data), ...
		[10; 10], opt);
end


function [err, z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = ...
	cal_chain_vector(vec_guess, s_data)
	[z_n, y_n, z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = ...
		cal_chain(vec_guess, s_data);

	h = s_data.h;
	err = [z_n - h; y_n];
end


function vec_guess_star = optim_fmincon(s_data)
	fun_project = @(vec_guess) cal_chain_scalar(vec_guess, s_data);
	A = [];
	b = [];
	Aeq = [];
	beq = [];
	lb = [];
	ub = [];
	nonlcon = [];
	x0 = [10; 10];
	options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
	vec_guess_star = fmincon(fun_project, x0, A, b, Aeq, beq, lb, ub, ...
		nonlcon, options);
end


function err = cal_chain_scalar(vec_guess, s_data)
	[z_n, y_n, ~, ~, ~, ~, ~] = cal_chain(vec_guess, s_data);

	h = s_data.h;
	err = (z_n - h)^2 + y_n^2;
end
