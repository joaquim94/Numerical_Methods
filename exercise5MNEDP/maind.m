a = 1;
nu=1e-3;
h=nu/a;

%Numerical solution
X = 0:h:1;
u=steadyConvectionDiffusionEquation(X,a,nu);

%Analytical solution
xa = 0:h:1; ua = (1/a)*(xa-(1-exp(xa*a/nu))/(1-exp(a/nu)));

figure(1)
plot(X,u,'-o',xa,ua,'--')
