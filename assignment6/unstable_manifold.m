clear all
rho = 28; sigma = 10; beta = 8/3; tol = 5*10^(-13);
final_time = 20; n_points = 3000;

%Compute the eigenvalues and eigenvectors at the origin numerically:
A = [-sigma,sigma,0;rho,-1,0;0,0,-beta];
[V,D] = eig(A);

%Select the coordinate of the invariant manifold.
j=1;
while D(j,j)<=0 j=j+1; end

%Initial conditions for first value of xsi.
u = V(:,j);
xsi = 1e-6;
p0 = xsi*u;
q0 = -xsi*u;
[~,W61] = lorentz(tol,rho,sigma,beta,p0,final_time,n_points);
[~,W62] = lorentz(tol,rho,sigma,beta,q0,final_time,n_points);

%Initial conditions for second value of xsi.
xsi = 1e-4;
p0 = xsi*u;
q0 = -xsi*u;
[~,W41] = lorentz(tol,rho,sigma,beta,p0,final_time,n_points);
[~,W42] = lorentz(tol,rho,sigma,beta,q0,final_time,n_points);

figure (1)
title('Unstable manifold')
plot3(W61(:,1),W61(:,2),W61(:,3),'g',W41(:,1),W41(:,2),W41(:,3),'+r')