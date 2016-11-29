clear all

%Global variables:
mu = 0.1;
dxini = 1e-3; dx = 1e-3;
default_dt = 1e-1;
dC = 1e-3;
tol = 1e-12;
C = 3;

[L,Cx] = LCRTBP(mu); Lx = L(1,3); C0 = Cx(3);

%Implement the function returning x' at the Poincare section.
func = @(x) integration([x,vy0_fromxC(x,C,mu)],mu,default_dt,tol);

%Look for the first change of sign in func:
x1 = Lx + dxini; f1 = func(x1);
x2 = x1 + dxini; f2 = func(x2);

while (f1*f2 > 0)
    x1 = x2; x2 = x2 + dxini;
    f1 = f2; f2 = func(x2);
end

X = bisection(func,[x1,x2],tol);
VY = vy0_fromxC(X,C,mu); [~,T2] = integration([X,VY],mu,default_dt,tol);