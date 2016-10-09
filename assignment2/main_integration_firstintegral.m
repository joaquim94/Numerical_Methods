clear all

%MAIN_INTEGRATION_HAMILTONIAN: We integrate the harmonic oscillator, and
%check that its energy, H(x,y), is conserved along trajectories.

t0 = 0;
x0 = [1 0];
oscillator = @(t,x) [x(2);-x(1)];
H = @(x) 0.5*(x(:,1).^2+x(:,2).^2);
H0 = H(x0);

k = input('Order of the tolerance (default = 12): ');
if isempty(k) k=12; end
tol = 10^(-k);

odeoptions = odeset('RelTol',tol,'AbsTol',tol);

tfin = input('End time of integration (default = 2*PI): ');
if isempty(tfin) tfin = 2*pi; end

%Integrate numerically the system:
[tout,yout] = ode45(oscillator,[t0,tfin],x0,odeoptions);

%First integral condition:

n = length(tout);
e = zeros(n,1);
for i=1:n
   e(i) = H(yout(i,:))-H0; 
end

%We plot the logarithm of these errors, and check it doesn't fall below the
%critical line:

figure (1)
hold on
title('Logarithm of the errors in the first integral')
plot(tout,log(abs(e)),'r.','MarkerSize',1)