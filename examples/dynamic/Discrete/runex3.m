format bank
parms

% The search for la0
la0=10;

opt=optimset('fsolve');
opt=optimset(opt,'Display','iter');

la=fsolve('fejlf',la0,opt)
[err,ut,xt,lat]=fejlf(la);

subplot(211);
bar(ut); grid; title('Input sequence');
axis([0 15 0 50000]);
subplot(212);
bar(xt); grid; title('Balance');
axis([0 15 0 50000]);
shg