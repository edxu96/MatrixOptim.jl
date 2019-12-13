
function la = solve_exer_3()

format bank

[alf, a, b, x0, N, q, r, p] = get_para();

% The search for la0
la0 = 10;

opt = optimset('fsolve');
opt = optimset(opt, 'Display', 'iter');

la = fsolve('fejlf', la0, opt)
[err,ut,xt,lat]=fejlf(la);

subplot(211);
bar(ut); grid; title('Input sequence');
axis([0 15 0 50000]);
subplot(212);
bar(xt); grid; title('Balance');
axis([0 15 0 50000]);
shg

end
