

function vec_guess_star = solve_chain(s_data, dim)

	%% Chose the function to optimize
	vec_guess_star = optim_fsolve(s_data, dim);
	% vec_guess_star = optim_fmincon(s_data, dim);

	%% Calculate and print the final result
	err = cal_chain(vec_guess_star, s_data, dim, true);
	err
end


function vec_guess_star = optim_fsolve(s_data, dim)
	opt = optimoptions('fsolve', 'Display', 'iter');
	% , 'Algorithm', 'levenberg-marquardt'
	vec_guess_star = fsolve(@(vec_guess) ...
		cal_chain(vec_guess, s_data, dim, false), [-10; -5], opt);
end


% function vec_guess_star = optim_fmincon(s_data)
% 	fun_project = @(vec_guess) cal_chain_scalar(vec_guess, s_data);
% 	A = [];
% 	b = [];
% 	Aeq = [];
% 	beq = [];
% 	lb = [];
% 	ub = [];
% 	nonlcon = [];
% 	x0 = [0; 0];
% 	options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
% 	vec_guess_star = fmincon(fun_project, x0, A, b, Aeq, beq, lb, ub, ...
% 		nonlcon, options);
% end
