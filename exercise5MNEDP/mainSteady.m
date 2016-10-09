a = 1;

nu=input('nu = ');
Pe=a*0.1/(2*nu);
%Numerical solution
nOfElements = 10; X = linspace(0,1,nOfElements+1);
u=steadyConvectionDiffusionEquation(X,a,nu);

%Analytical solution
xa = [0:0.01:1]; ua = (1/a)*(xa-(1-exp(xa*a/nu))/(1-exp(a/nu)));

figure(1)
plot(X,u,'-o',xa,ua,'--')
