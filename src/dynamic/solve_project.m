
function [vec_guess_star, z_t, y_t, lambda_z_t, lambda_y_t] = solve_project()

s_data = get_data_chain();

opt = optimoptions('fsolve', 'Display', 'iter');
% , 'Algorithm', 'levenberg-marquardt'

vec_guess_star = fsolve(@(vec_guess) cal_chain(vec_guess, s_data), ...
	[10; 10], opt);
[err_star, z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = ...
	cal_chain(vec_guess_star, s_data)

% [err_star, z_t, y_t, theta_t, lambda_z_t, lambda_y_t] = ...
% 	cal_chain([2; 2], s_data)

%% Plot the results

% shg

end
