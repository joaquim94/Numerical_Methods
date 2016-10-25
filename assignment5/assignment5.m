clear all

%Input the variables

tol = input('Tolerance (default= 5*10^(-14)): ');
if isempty(tol) tol = 5*10^(-14); end
mu = input('Mu (between 0 and 1/2): ');
time_init = input('Initial time (default=0): ');
if isempty(time_init) time_init = 0; end
time_final = input('Final time (input a negative time for backwards integration): ');
y0 = input('Initial position [x0,y0]: ');
v0 = input('Initial velocity [u0,v0]: ');
x0 = [y0,v0]';

%Define the functions we need:
%Omega function.
Omega = @(x) (x(1,:).^2+x(2,:).^2)/2 + (1-mu)./sqrt(((x(1,:)-mu).^2+x(2,:).^2)) + mu./sqrt((x(1,:)-mu+1).^2+x(2,:).^2) + mu*(1-mu)/2;
%Function defining the system.
F = @(t,x) [x(3); x(4); 2*x(4) + x(1) - (1-mu)*(x(1)-mu)/(((x(1)-mu)^2+x(2)^2)^(3/2)) - mu*(x(1)-mu+1)/(((x(1)-mu+1)^2 + x(2)^2)^(3/2)); -2*x(3) + x(2)*(1 - (1-mu)/(((x(1)-mu)^2 + x(2)^2)^(3/2)) - mu/(((x(1)-mu+1)^2 + x(2)^2)^(3/2)))];
%Jacobian integral.
J = @(x) 2*Omega(x(1:2,:)) - (x(3,:).^2+x(4,:).^2);

%Compute an orbit for the system:
odeoptions = odeset('RelTol',tol,'AbsTol',tol);

J0 = J(x0);
[~,orbit] = ode45(F,[time_init,time_final],x0,odeoptions);
abserror = abs(J(orbit')-J0);

%Plots:
%plot(orbit(:,1),orbit(:,2),'.')
%plot(1:length(abserror),-log(abserror),'.')
