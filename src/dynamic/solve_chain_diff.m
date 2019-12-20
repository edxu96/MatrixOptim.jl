

function [vec_s, mat_x_s] = solve_chain_diff(struct_data)

	z_0 = struct_data.z_0;
	y_0 = struct_data.y_0;
	s_total = struct_data.s_total;

	% Search for correct initial costates
	opt = optimset('fsolve');
	opt = optimset(opt, 'Display', 'off', 'Algorithm', 'Levenberg-Marquardt');

	vec_la_0 = [-1; 1];
	vec_la_0_star = fsolve(@(vec_la_0) cal_chain_diff(vec_la_0, struct_data), ...
		vec_la_0, opt);

	% Calculate with optimal values
	vec_x_0_star = [z_0; y_0; vec_la_0_star];
	[err, vec_s, mat_x_s] = cal_chain_diff(vec_la_0_star, struct_data);
	err

	% [time, mat_z_t] = ode45(@(s, theta) cal_chain_diff(s, theta, struct_data), ...
	% 	[0 s_total], vec_x_0_star, []);
	% vec_zy_s = mat_x_s(:, 1:2); 
	% vec_la_s = mat_x_s(:, 3:4); 
end
