


function err = loss(la0, A, B, x0, P, R, Q, T, n)
% Determine the error of the terminal condition as function of la0.
% A and B are system matrices
% Q, R and P are weight matrices in the objective function
% n is number of states.
% x0 is the initial state vector

	z0 = [x0; la0'];
	[time, zt] = ode45(@dlq, [0 T/2 T], z0, [], A, B, P, R, Q, n);
	zT = zt(end, :)';
	xT = zT(1:n);
	laT = zT(n+1:end)';
	err = laT - xT' * P;
end
