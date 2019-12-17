

function [err, z_t, y_t] = cal_chain_sym(vec_guess, s_data, whe_print)
% Calculate `z_n` and `y_n` using guessed `lambda_z_0` and `lambda_z_0`
	m = s_data.m;
	g = s_data.g;
	l = s_data.l;
	n = s_data.n;

	%% Initialize the Vectors to Store the Results
	z_t = zeros(n / 2 + 1, 1);
	y_t = zeros(n / 2 + 1, 1);
	lambda_z_t = zeros(n / 2 + 1, 1);
	lambda_y_t = zeros(n / 2 + 1, 1);
	theta_t = zeros(n / 2, 1);

	z_t(1) = s_data.z_0;
	y_t(1) = s_data.y_0;
	lambda_z_t(1) = vec_guess(1);
	lambda_y_t(1) = vec_guess(2);

	%% Begin Iteration
	%% Notice that `i` starts from 1 to (n-1).
	for j = 0:(n / 2 - 1)
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

	n = s_data.n;
	h = s_data.h;
	z_n2 = z_t(n / 2 + 1);
	err = z_n2 - h / 2;
end



function theta_i = cal_theta_i(lambda_z_i1, lambda_y_i1, m, g, l)
% "_i1" indicates the index is (i+1)
	theta_i = atan((lambda_y_i1 + 0.5 * m * g) / lambda_z_i1);
end
