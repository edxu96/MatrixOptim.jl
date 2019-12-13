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
la0=131;                        % First guess on lambda
% This is a good guess

% Search for correct initial costates
opt=optimset('fsolve');
opt=optimset(opt,'Display','off');
la0=fsolve(@loss,la0,opt,A,B,x0,P,R,Q,T,n)

% Simulation with correct initial costate
xp0=[x0;la0'];
[time,xpt]=ode45(@dlq,[0 T],xp0,[],A,B,P,R,Q,n);
xt=xpt(:,1:n); lat=xpt(:,n+1:end); 
ut=-inv(R)*B'*lat'; ut=ut';

%------------------------------------------------------------------------
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
%------------------------------------------------------------------------
