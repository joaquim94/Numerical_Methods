clear all

%Integrate the toy system, the harmonic oscillator:

t0 = 0;
oscillator = @(t,x) [x(2);-x(1)];

k = input('Order of the tolerance (default = 12): ');
if isempty(k) k=12; end
tol = 10^(-k);

odeoptions = odeset('RelTol',tol,'AbsTol',tol);

tfin = input('End time of integration (default = 2*PI): ');
if isempty(tfin) tfin = 2*pi; end

[tout,yout] = ode45(oscillator,[t0,tfin],[1;0],odeoptions);

plot(yout(:,1),yout(:,2),'-o','MarkerSize',0.5)
