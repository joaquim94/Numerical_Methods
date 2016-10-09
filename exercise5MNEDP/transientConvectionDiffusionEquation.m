function U=transientConvectionDiffusionEquation(X,u0,a,nu,At,nOfTimeSteps)
% Solution of the steady CONVECTION-DIFFUSION equation
% u_t + a u_x - nu u_xx = 0      in (0,1)
% with homogeneus Dirichlet boundary conditions
% u(0)=u(1)=0
% with linear finite elements and a Galerkin formulation
% with nodes given by X
% Time integration with Euler method with time step At

%Elemental matrices FOR ELEMENT SIZE h=1 
Ke = [1 -1;-1 1];   %discretization of -u_xx
Ce = [-1 1;-1 1]/2; %discretization of  u_x
Me = (1/6)*[2 1;1 2]; %mass matrix

nOfNodes = length(X); nOfElements = nOfNodes-1;

%Matrices assembly: loop in elements
K = spalloc(nOfNodes,nOfNodes,3*nOfNodes); C=K; M=K;
for e=1:nOfElements
    Te = [e,e+1]; h=X(e+1)-X(e); %element size
    K(Te,Te) = K(Te,Te) + (1/h)*Ke; 
    C(Te,Te) = C(Te,Te) + Ce;
    M(Te,Te) = M(Te,Te) + h*Me;
end
A = a*C + nu*K;

%Boundary conditions BC
A=A(2:end-1,2:end-1); M=M(2:end-1,2:end-1);
u=u0(2:end-1);
figure(1), plot(X,[0;u;0]), pause(1)

%Loop in time steps
Ml = full(sum(M,2)); %Diagonal lumped mass matrix
U = u; stepDib=round(nOfTimeSteps/10);
for n=1:nOfTimeSteps
    t = Ml.*u - At*A*u;
    u = t./Ml;
    U = [U u];
    if mod(n,stepDib)==0
        figure(11), plot(X,[0;u;0]), pause(1)
    end
end
U = [zeros(1,nOfTimeSteps+1);U;zeros(1,nOfTimeSteps+1)]; %BC
