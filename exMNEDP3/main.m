clear all;

%Resolucio de -u_xx = f en (0,1) amb
%u(0)=u0 i u(1)=u1
u0=0; u1=0;

%Malla
nOfElements = 50; degree=2;
[X,T]=createUniformMesh1D(0,1,nOfElements,degree);

%Reference element
referenceElement=referenceElement1D(degree);

%System
[K,f] = computeSystemLaplace1D(X,T,referenceElement);

%CC Dirichlet
f = f(2:end-1) - K(2:end-1,1)*u0 - K(2:end-1,end)*u1;
K = K(2:end-1,2:end-1);

%Solution
u = K\f;
u = [u0;u;u1];

%Postprocess
figure(1),plot(X,u,'-o')