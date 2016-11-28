clear all

mu = 0.008;
s = 1e-6;

[v,L] = select_eigenvector(mu,3,1);

tol = input('Desired tolerance (default=1e-12): ');
if isempty(tol) tol = 1e-12; end

x0 = L + s*v;

F = @(t,x) RTBPfield(x,mu);
[Y,T] = poincare_section(F,[0 1 0 0], tol, 0, L, 1);
plot(Y(1,:),Y(2,:),'.-')