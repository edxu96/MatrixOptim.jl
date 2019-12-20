%% main file
%% Edward J. Xu <edxu96@outlook.com>
%% Dec 13th, 2019

% cd ~/GitHub/MatrixOptim.jl/src/dynamic
% addpath('~/GitHub/MatrixOptim.jl/src/dynamic')


function main()
	% solve_exer_1()
	% solve_exer_2()
	% solve_exer_3()

	%% Trajectory of a Suspended Chain
	[z_t_1, y_t_1] = solve_project_discrete(false)

	%% Trajectory of a Suspended Chain using Two Symmetric Half Chains
	[z_t_1, y_t_1] = solve_project_discrete(true)

	%% Continuous Wire
	solve_project_conti(z_t_1, y_t_1)
end


function [z_t_1, y_t_1] = solve_project_discrete(whe_sym)

	s_data_1 = get_data_chain(6);  % When the number of sections is 6
	s_data_2 = get_data_chain(100);  % When the number of sections is 100

	if whe_sym
		%% Symmetric Method when N = 6
		[~, z_t_1, y_t_1] = solve_chain(s_data_1, true, 1);
		%% Symmetric Method when N = 100
		[~, z_t_2, y_t_2] = solve_chain(s_data_2, true, 1);
	else
		%% One Dimension Method when N = 6
		[~, z_t_1, y_t_1] = solve_chain(s_data_1, false, 1);
		%% Two Dimension Method using Pontryagins Maximum Principle when N = 6
		[~, z_t_1, y_t_1] = solve_chain(s_data_1, false, 2);
		%% One Dimension Method when N = 100
		[~, z_t_2, y_t_2] = solve_chain(s_data_2, false, 1);
	end

	% plot_chain_discrete(z_t_1, y_t_1, z_t_2, y_t_2)
end


function plot_chain_discrete(x1, y1, x2, y2)
	figure

	plot(x1, y1, 'b', x2, y2, 'r-.', 'LineWidth', 2)
	grid on
	% Set the axis limits
	% axis([0 2*pi -1.5 1.5])
	% Add title and axis labels
	title('Trajectories of Suspended Chains')
	xlabel('z')
	ylabel('y')
	legend('when N = 6','when N = 6')
end


function solve_project_conti(x2, y2)
	struct_data = get_data_chain_diff();

	[vec_s, mat_x_s] = solve_chain_diff(struct_data);

	plot_chain_conti(mat_x_s(:, 1), mat_x_s(:, 2), x2, y2)
end


function plot_chain_conti(vec_x, vec_y, x1, y1)
	figure

	plot(vec_x, vec_y, 'blue', x1, y1, 'r-.', 'LineWidth', 2)
	grid on
	% Set the axis limits
	% axis([0 2*pi -1.5 1.5])
	% Add title and axis labels
	title('Trajectories of Suspended a Chain and a Wire')
	xlabel('z')
	ylabel('y')
	legend('Suspended Wire','Suspended Chain with N = 100')

end

%%%% Exercises %%%%


function solve_exer_1()
	opt = optimset;
	opt = optimset(opt, 'Display', 'iter');
	fminsearch('fopt', [1; 1], opt)
end


function loss = fopt(u)
	loss = sum((u - [1; 3]).^2) + 1;
end


function solve_exer_2()
	opt = optimset;
	opt = optimset(opt, 'Display', 'off');
	fsolve('fz', [1; 1], opt)
end


function f = fz(u)
	f = u - [1; 3];
end


function [lambda_0_star, u_t, x_t, lambda_t] = solve_exer_3()
	% format bank

	opt = optimset('fsolve');
	opt = optimset(opt, 'Display', 'iter');

	lambda_0_star = fsolve('cal_fejlf', 0, opt);
	% Initial guess search of lambda_0 is 0
	[~, u_t, x_t, lambda_t] = fejlf(lambda_0_star);

	%% Plot the results
	subplot(211);
	bar(u_t); grid; title('Input sequence');
	axis([0 15 0 50000]);
	subplot(212);
	bar(x_t); grid; title('Balance');
	axis([0 15 0 50000]);
	shg
end


function [err, u_t, x_t, lambda_t] = cal_fejlf(lambda_0)
% Usage: [err,ut,xt,lambda_t]=fejlf(lambda_0)
%
% lambda_0: guess on the initial value of the costate.

[alf, a, b, x_0, n, q, r, p] = get_data();

%% Initialize the vectors to store the result
x_t = zeros(n, 1);
lambda_t = zeros(n, 1);
u_t = zeros(n, 1);

x_t(1) = x_0;
lambda_t(1) = lambda_0;
u_t(1) = 0;

%% Begin Iteration
for j = 0:(n - 1)
    i = j + 1;
    lambda_t(i+1) = (lambda_t(i) - q * x_t(i)) / a;
    u_t(i) = -b * lambda_t(i+1) / r;
    x_t(i+1) = a * x_t(i) + b * u_t(i);
end

%% the error in the end point condition
err = lambda_t(n) - p * x_t(n);

end


function [alf, a, b, x0, N, q, r, p] = get_data()
    alf = 0.05;
    a = 1 + alf;
    b = -1;
    x0 = 50000;
    N = 10;
    q = alf^2;
    r = q;
    p = q;

    %r=10*q;
    %r=q/10;
    %p=0;
    %p=100*q;
end
