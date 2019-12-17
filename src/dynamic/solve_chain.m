

function [vec_guess_star, z_t, y_t] = solve_chain(s_data, dim)

	%% Chose the function to optimize
	vec_guess_star = optim_fsolve(s_data, dim);
	% vec_guess_star = optim_fmincon(s_data, dim);

	%% Calculate and print the final result
	[err, z_t, y_t] = cal_chain(vec_guess_star, s_data, dim, true);
	err
end


function vec_guess_star = optim_fsolve(s_data, dim)
	opt = optimoptions('fsolve', 'Display', 'iter');
	% , 'Algorithm', 'levenberg-marquardt'
	vec_guess_star = fsolve(@(vec_guess) ...
		cal_chain(vec_guess, s_data, dim, false), [- 22.3645; 68.6700], opt);
end
