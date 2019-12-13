

function [err,ut,xt,lat] = fejlf(la0)
% Usage: [err,ut,xt,lat]=fejlf(la0)
%
% err is the error in the end point condition (should be zero).
% la0 is the guess on the initial value of the costate.
%
% ut is the optimal input sequence
% xt is the resulting state trajectory
% lat is the resulting costate trajectory

[alf, a, b, x0, N, q, r, p] = get_para();

la = la0;
x = x0;
ut = [];
lat = la;
xt = x;
for i = 0:N-1
    la = (la - q * x) / a;
    u = -b * la / r;
    x = a * x + b * u;
    xt = [xt; x];
    lat = [lat; la];
    ut = [ut; u];
end

err = la - p * x;

end
