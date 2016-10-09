function u=steadyConvectionDiffusionEquation(X,a,nu)
% Solution of the steady CONVECTION-DIFFUSION equation
% a u_x - nu u_xx = 1      in (0,1)
% with homogeneus Dirichlet boundary conditions
% u(0)=u(1)=0
% with linear finite elements and a Galerkin formulation
% with nodes given by X

%Elemental matrices FOR ELEMENT SIZE h=1 
fe = [1;1]/2;
Ke = [1 -1;-1 1];   %discretization of -u_xx
Ce = [-1 1;-1 1]/2; %discretization of  u_x
%Me = (1/6)*[2 1;1 2]; %mass matrix

nOfNodes = length(X); nOfElements = nOfNodes-1;

%Matrices assembly: loop in elements
f = zeros(nOfNodes,1);
K = spalloc(nOfNodes,nOfNodes,3*nOfNodes); C=K; %M=K;
for e=1:nOfElements
    Te = [e,e+1]; h=X(e+1)-X(e); %element size
    f(Te) = f(Te) + h*fe;
    K(Te,Te) = K(Te,Te) + (1/h)*Ke; 
    C(Te,Te) = C(Te,Te) + Ce;
    %M(Te,Te) = M(Te,Te) + h*Me;
end
A = a*C + nu*K; 

%Boundary conditions BC
A=A(2:end-1,2:end-1); f=f(2:end-1);

%System solution
u = A\f;
u = [0;u;0]; %BC
