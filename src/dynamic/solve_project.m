
function [vec_guess_star, z_t, y_t, lambda_z_t, lambda_y_t] = solve_project()

s_data = get_data_chain();

opt = optimset('fsolve');
opt = optimset(opt, 'Display', 'iter');

vec_guess_star = fsolve(@(vec_guess) cal_chain(vec_guess, s_data), [0; 0], opt);
[~, z_t, y_t, lambda_z_t, lambda_y_t] = cal_chain(vec_guess_star, s_data);

z_t
y_t

%% Plot the results

% shg

end
