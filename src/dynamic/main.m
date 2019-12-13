

addpath('~/GitHub/MatrixOptim.jl/src/dynamic')

opt = optimset;
opt = optimset(opt, 'Display', 'iter');
fminsearch('fopt', [1; 1], opt)


opt = optimset;
opt = optimset(opt, 'Display', 'off');
fsolve('fz', [1; 1], opt)
