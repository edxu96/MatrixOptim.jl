%------------------------------------------------------------------------
% Program for solving the LQ problem
%------------------------------------------------------------------------

alf=0.05;
b=-1;

A=alf;                          % System matrix 
B=b;        
n=length(A);
Q=alf^2;                        % Weight matrices in objective function
R=Q;
P=Q;

T=10;                           % Final time
x0=50000;                       % Initial state
% This is a good guess


function main()
	% Search for correct initial costates
	opt=optimset('fsolve');
	opt=optimset(opt,'Display','off');

	la0=131;                        % First guess on lambda
	la0=fsolve(@loss,la0,opt,A,B,x0,P,R,Q,T,n)

	% Simulation with correct initial costate
	xp0=[x0;la0'];
	[time,xpt]=ode45(@dlq,[0 T],xp0,[],A,B,P,R,Q,n);
	xt=xpt(:,1:n); lat=xpt(:,n+1:end); 
	ut=-inv(R)*B'*lat'; ut=ut';
end


function [outputs] = plot_result(arg)
	% The rest (until next function declaraion) is just plotting
	subplot(311);
	plot(time,xt); grid;
	xlabel('Time'); 
	ylabel('State');

	subplot(312);
	plot(time,lat); grid;
	xlabel('Time'); 
	ylabel('Costates ');

	subplot(313);
	plot(time,ut); grid;
	xlabel('Time'); ylabel('Control input ');
end


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


function dz = dlq(t, z, A, B, P, R, Q, n)
% Determine the derivative of x and la as function of t, x and la
% A and B are system matrices
% Q, R and P are weight matrices in the objective function
% n is number of states.
    x = z(1: n);
    la = z(n + 1: end);
    u = - inv(R) * B' * la;
    dz = [ A * x + B * u; -Q * x - A' * la];
end

