function dx=vdp(t,x,a)

x1=x(1); x2=x(2);
dx=[x2; a*(1-x1^2)*x2-x1];
