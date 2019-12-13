Tspan=0:0.1:30;
x0=[1;0];
a=7;

[t,x]=ode45(@vdp,Tspan,x0,[],a);

z=x(:,1);
plot(t,z); grid; title('Van der Pool oscillator');
xlabel('time'); ylabel('position');
