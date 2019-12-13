

function [alf, a, b, x0, N, q, r, p] = get_para()
% get_para Description
%	[alf, a, b, x0, N, q, r, p] = get_para()

alf = 0.05;
a = 1 + alf;
b = -1;
x0 = 50000;
N = 10;
q = alf^2;
r=q;
p=q;

%r=10*q;
%r=q/10;
%p=0;
%p=100*q;


end % function end: 'get_para'
