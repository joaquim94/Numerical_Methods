clear all

%Global variables:
s = 1e-6;
defaultdt = 1;
n_crossings = 1;
g = [0 1 0 0];

%Input variables:
tol = input('Desired tolerance (default = 5e-14): ');
if isempty(tol) tol = 5e-14; end

mu = input('Value for mu: ');
i = input('In which equilibrium point do you want to compute? (1,2 or 3) ');
sign = input('Write +1 if you are interested in the unstable manifold, -1 if you want the stable manifold: ');
if isempty(sign) sign = 1; end

v = select_eigenvector(mu,i,sign);

[L,C] = LCRTBP(mu);
L = L(:,i);
C = C(i);

%Functions for integration and Jacobi constant:
F = RTBPfield(mu);
J = @(x) 2*((x(1,:).^2+x(2,:).^2)/2 + (1-mu)./sqrt(((x(1,:)-mu).^2+x(2,:).^2)) + mu./sqrt((x(1,:)-mu+1).^2+x(2,:).^2) + mu*(1-mu)/2) - (x(3,:).^2+x(4,:).^2);

%Initial point:
x0 = L + s*v;
trajectory = [];

for j=1:n_crossings
    [Y,T] = poincare_section(F,g,tol,0,x0,defaultdt);
    trajectory = [trajectory, Y];
    x0 = Y(:,end);
end

error = abs(J(trajectory)-C); lerror = -log10(error);

if (norm(error,Inf) > tol) fprintf('ERROR: Jacobi constant is not as constant as expected!\n'); end

plot(trajectory(1,:),trajectory(2,:),'r')
