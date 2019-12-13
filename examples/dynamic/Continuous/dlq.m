%------------------------------------------------------------------------
function dz=dlq(t,z,A,B,P,R,Q,n)
%------------------------------------------------------------------------
% Determine the derivative of x and la as function of t, x and la
% A and B are system matrices
% Q, R and P are weight matrices in the objective function
% n is number of states.
%------------------------------------------------------------------------
x=z(1:n); la=z(n+1:end);
u=-inv(R)*B'*la;
dz=[ A*x+B*u;
     -Q*x-A'*la];
