clear all
rho = 28; sigma = 10; beta = 8/3; tol = 5*10^(-13);
final_time = 0.3; n_points = 3000; n_initial_conditions = 10;

%Compute the eigenvalues and eigenvectors at the origin numerically:
A = [-sigma,sigma,0;rho,-1,0;0,0,-beta];
[V,D] = eig(A);

%Select the attractor eigenvectors:
v = V(:,1); w = V(:,3);

%Select initial conditions and value for xsi
theta0 = linspace(0,2*pi,n_initial_conditions+1); theta0 = theta0(1:n_initial_conditions);
xsi = 1e-6;

%Allocate space for the points of the stable manifold.
S = zeros(n_points,3,n_initial_conditions);
%Compute all the values of the points.
for i=1:n_initial_conditions
    p0 = xsi*cos(theta0(i))*v + xsi*sin(theta0(i))*w;
    [~,S(:,:,i)] = lorentz(tol,rho,sigma,beta,p0,-final_time,n_points);
end