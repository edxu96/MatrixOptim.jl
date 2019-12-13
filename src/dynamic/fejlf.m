

function [err, u_t, x_t, lambda_t] = fejlf(lambda_0)
% Usage: [err,ut,xt,lambda_t]=fejlf(lambda_0)
%
% lambda_0: guess on the initial value of the costate.

[alf, a, b, x_0, n, q, r, p] = get_para();

%% Initialize the vectors to store the result
x_t = zeros(3, 1);
lambda_t = zeros(3, 1);
u_t = zeros(3, 1);

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
