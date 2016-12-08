clear all

%Test the method to be used.

tol = input('Tolerance to be used (default=5e-8): ');
if isempty(tol) tol = 5e-8; end

mu = input('Value for mu (default=0.1): ');
if isempty(mu) mu = 0.1; end

F = RTBPfield(mu);
[L,C0] = LCRTBP(mu); Lx = L(1,3); C0 = C0(3);

C = input('Value for C: ');

x1 = Lx+1e-5; dx = 1e-3;
f = @(x) [0 0 1 0]*poincare_section(F,[0 1 0 0],tol/10,0,[x;0;0;-sqrt(x^2 + 2*(1-mu)/abs(x-mu) + 2*mu/abs(x-mu+1) + mu*(1-mu) - C)],3);
v1 = f(x1); x2 = x1+dx; v2 = f(x2);

while(v1*v2 > 0)
    x1 = x2; x2 = x2+dx;
    v1 = v2; v2 = f(x2);
end

X = bisection(f,[x1,x2],tol)