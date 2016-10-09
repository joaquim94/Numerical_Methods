clear all;

%Resolucio de -u_xx = f en (0,1) amb
%u(0)=u0 i u(1)=u1 i posterior calcul de l'error
u0=0; u1=sin(1);

%Malla
nOfElements = 20; degree=1;
[X,T]=createUniformMesh1D(0,1,nOfElements,degree);

%Reference element
referenceElement=referenceElement1D(degree);

%System
F = @(x) sin(x);
[K,f] = computeSystemLaplace1D(X,T,referenceElement,F);

%CC Dirichlet
f = f(2:end-1) - K(2:end-1,1)*u0 - K(2:end-1,end)*u1;
Ks = K(2:end-1,2:end-1);

%Solution
u = Ks\f;
u = [u0;u;u1];

%Calcul de les sigmes n ('derivades'):
sigma=(u(2:end)-u(1:end-1))./(X(2:end)-X(1:end-1));

%Calcul de les sigmes estrella.