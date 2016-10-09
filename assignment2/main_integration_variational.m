clear all

%MAIN_INTEGRATION_VARIATIONAL: Integrate the variational equations and
%check that the determinant of the matrix is still 1 at the end of the period.

t0 = 0; tfin = 2*pi;
x0 = [1 0];
F = @(x) [x(2);-x(1);x(5);x(6);-x(3),-x(4)];
Id = [1 0 0 1];

y0 = [x0 Id];

k = input('Order of the tolerance (default = 12): ');
if isempty(k) k=12; end
tol = 10^(-k);

odeoptions = odeset('RelTol',tol,'AbsTol',tol);

%Integrate numerically the system:
[tout,yout] = ode45(F,[t0,tfin],y0,odeoptions);

%TODO: We want to transform the vector to matrix and compute its
%determinant.