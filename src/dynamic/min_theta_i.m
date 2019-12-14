
%
% function [sol, fval, exitflag, output] = ...
% 	min_theta_i(z_i, y_i, lambda_z_i1, lambda_y_i1, m, g, l)
%
% theta_i = optimvar('theta_i', 'LowerBound', -pi/2, 'UpperBound', pi/2);
% obj = m * g * y_i + 0.5 * m * g * l * sin(theta_i) + ...
% 	lambda_z_i1 * (z_i + cos(theta_i)) + lambda_y_i1 * (y_i + sin(theta_i));
% prob = optimproblem('Objective',obj);
% x_0.theta_i = 0;
%
% [sol, fval, exitflag, output] = solve(prob, x_0);


% function [sol_theta_i, fval, exitflag, output] = ...
% 	min_theta_i(z_i, y_i, lambda_z_i1, lambda_y_i1, m, g, l)
%
% x = optimvar('x', 2, 1, 'LowerBound', [-1.0; 0.0], 'UpperBound', [1.0; 1.0]);
% obj = m * g * y_i + 0.5 * m * g * l * x(1) + ...
% 	lambda_z_i1 * (z_i + x(2)) + lambda_y_i1 * (y_i + x(1));
% prob = optimproblem('Objective', obj);
% nlcons = x(1)^2 + x(2)^2 - 1 <= 10E-6;
% prob.Constraints.circlecons = nlcons;
% x_0.x = [1 / sqrt(2); 1 / sqrt(2)];
%
% [sol, fval, exitflag, output] = solve(prob, x_0);
% sol_theta_i = asin(sol.x(1));
% % sol_x = sol.x;


function sol_theta_i = ...
	min_theta_i(z_i, y_i, lambda_z_i1, lambda_y_i1, m, g, l)

fun = @(theta_i) m * g * y_i + 0.5 * m * g * l * sin(theta_i) + ...
	lambda_z_i1 * (z_i + cos(theta_i)) + lambda_y_i1 * (y_i + sin(theta_i));
A = [];
b = [];
Aeq = [];
beq = [];
lb = -pi / 2;
ub = pi / 2;
nonlcon = [];
x0 = 0;
options = optimoptions('fmincon', 'Display', 'off', 'Algorithm', 'sqp');
sol_theta_i = fmincon(fun, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);
