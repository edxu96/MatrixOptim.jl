
function [err, z_t, y_t, lambda_z_t, lambda_y_t] = cal_chain(vec_guess, s_data)

m = s_data.m;
g = s_data.g;
l = s_data.l;
n = s_data.n;
h = s_data.h;

%% Initialize the Vectors to Store the Results
z_t = zeros(n, 1);
y_t = zeros(n, 1);
lambda_z_t = zeros(n, 1);
lambda_y_t = zeros(n, 1);
theta_t = zeros(n-1, 1);

z_t(1) = s_data.z_0;
y_t(1) = s_data.y_0;
lambda_z_t(1) = vec_guess(1);
lambda_y_t(1) = vec_guess(1);

%% Begin Iteration
for j = 0:(n-1)
	i = j + 1;
	% [z_t(i); y_t(i); lambda_z_t(i); lambda_y_t(i)]

	lambda_z_t(i+1) = lambda_z_t(i);
	lambda_y_t(i+1) = lambda_y_t(i) - m * g;
	theta_t(i) = atan(lambda_y_t(i+1) + 0.5 * m * g * l / lambda_z_t(i+1));
	z_t(i+1) = z_t(i) + cos(theta_t(i));
	y_t(i+1) = y_t(i) + sin(theta_t(i));
end

%% the error in the end point condition
err = (z_t(i+1) - h)^2 + y_t(i+1)^2;
