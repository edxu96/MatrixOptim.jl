%% main file
%% Edward J. Xu <edxu96@outlook.com>
%% Dec 13th, 2019

% cd ~/GitHub/MatrixOptim.jl/src/dynamic
% addpath('~/GitHub/MatrixOptim.jl/src/dynamic')


function main()
	% solve_exer_1()
	% solve_exer_2()
	% solve_exer_3()
	% solve_chain()
	solve_project()
end

function solve_project()
	s_data_1 = get_data_chain(6);
	s_data_2 = get_data_chain(100);

	[vec_guess_star_1, z_t_1, y_t_1, ~, ~] = solve_chain(s_data_1);
	[vec_guess_star_2, z_t_2, y_t_2, ~, ~] = solve_chain(s_data_2);

	vec_guess_star_1
	vec_guess_star_2

	plot_chain(z_t_1, y_t_1, z_t_2, y_t_2)
end


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
