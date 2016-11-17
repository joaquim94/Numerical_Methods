clear all

%OPTASSIGNMENT8: Compute the stability of the monodromy matrix of the
%elliptical RTBP.

%Input variables:
tol = input('Desired tolerance (default=5e-10): ');
if isempty(tol) tol = 5e-10; end

N_ITER = input('Number of iterations (default=100): ');
if isempty(N_ITER) N_ITER = 100; end

mu = linspace(10*tol,0.5,N_ITER);
e = linspace(0,1-10*tol,N_ITER);

odeoptions = odeset('AbsTol',tol,'RelTol',tol);

results = zeros(N_ITER);
DFI0 = [1;0;0;0;0;1;0;0;0;0;1;0;0;0;0;1];
for i=1:N_ITER
    XL4 = [mu(i)-0.5,sqrt(3)/2,0,0];
    %XL5 = [mu(i)-0.5,-sqrt(3)/2,0,0];
    r1 = sqrt((XL4(1)-mu(i))^2 + XL4(2)^2);
    r2 = sqrt((XL4(1)-mu(i)+1)^2 + XL4(2)^2);
    for j=1:N_ITER
        F = @(t) [0,0,1,0;0,0,0,1;(1-(1-mu(i))*(XL4(2)^2-2*(XL4(1)-mu(i))^2)/r1^5 - mu(i)*(XL4(2)^2-2*(XL4(1)-mu(i)+1)^2)/r2^5)/(1+e(j)*cos(t)),3*((1-mu(i))*(XL4(1)-mu(i))/r1^5 + mu(i)*(XL4(1)-mu(i)+1)*XL4(2)/r2^5)/(1+e(j)*cos(t)), 0, 2; 3*((1-mu(i))*(XL4(1)-mu(i))/r1^5 + mu(i)*(XL4(1)-mu(i)+1)*XL4(2)/r2^5)/(1+e(j)*cos(t)),(1 - (1-mu(i)/r1^3 - mu(i)/r2^3 + 3*XL4(2)*((1-mu(i))/r1^5 + mu(i)/r2^5)))/(1+e(j)*cos(t)),-2,0];
        variational = @(t,x) [F(t)*x(1:4);F(t)*x(5:8);F(t)*x(9:12);F(t)*x(13:16)];
        [~,Y] = ode45(variational,[0,2*pi],DFI0,odeoptions);
        DFI = [Y(1:4)',Y(5:8)',Y(9:12)',Y(13:16)'];
        E = eig(DFI); E = abs(E);
        results(i,j) = max(E);
    end
    
    imagesc(results)
end