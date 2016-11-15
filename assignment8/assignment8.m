clear all

%ASSIGNMENT8: Find the x-coordinate of the equilibrium points L1, L2, L3,
%and the value of the Jacobi constant at each point, for a set of values of
%mu between 0 and 0.5

%Global variables:

XL01 = [-0.60903511002320210;-1.2596998329023312;1.0416089085710609];
CL01 = [3.6869532298798946;3.5566844258406487;3.1895781504493819];
XL02 = [-0.43807595853836628;-1.2710486907398808;1.0828394642022439];
CL02 = [3.9646532763063704;3.7123933328511765;3.3573204210059799];

%Input variables:

tol = input('Desired tolerance (default 5e-14): ');
if isempty(tol) tol = 5e-14; end

N_VALUES = input('Number of values computed for the plot (default = 100): ');
if isempty(N_VALUES) N_VALUES = 100; end

P = @(x,mu) [x(1)^5 - (3-mu)*x(1)^4 + (3-2*mu)*x(1)^3 - mu*x(1)^2 + 2*mu*x(1) - mu; x(2)^5 + (3-mu)*x(2)^4 + (3-2*mu)*x(2)^3 - mu*x(2)^2 - 2*mu*x(2) - mu; x(3)^5 + (2+mu)*x(3)^4 + (1+2*mu)*x(3)^3 - (1-mu)*x(3)^2 - 2*(1-mu)*x(3) - (1-mu)];

%Jacobi constant function, knowing already that all the coordinates are
%zero, except for x:
C = @(x,mu) x.^2 + 2*(1-mu)./(abs(x-mu)) + 2*mu./(abs(x-mu+1)) + mu*(1-mu);

%Initial points as suggested in theory classes:
x0 = @(mu) [nthroot(mu/(3*(1-mu)),3); nthroot(mu/(3*(1-mu)),3); 1 - 7/12* mu];
opts = optimset('TolFun',tol,'TolX',tol,'Display','off');

%First task: check that for mu=0.1 and mu=0.2 the method is precise enough:
P01 = @(x) P(x,0.1);
P02 = @(x) P(x,0.2);

x01 = x0(0.1);
x02 = x0(0.2);

y01 = fsolve(P01,x01,opts); y01 = [y01(1) + 0.1 - 1; 0.1 - 1 - y01(2); 0.1 + y01(3)];
y02 = fsolve(P02,x02,opts); y02 = [y02(1) + 0.2 - 1; 0.2 - 1 - y02(2); 0.2 + y02(3)];
c01 = C(y01,0.1);
c02 = C(y02,0.2);

if (norm(y01-XL01,Inf) > tol || norm(c01-CL01,Inf) > tol || norm(y02-XL02,Inf) > tol || norm(c02-CL02,Inf) > tol)
    fprintf('ERROR: The test gave too much difference between the computed values and the data\n');
end

%Second task: produce a plot for (mu,x), and another for (mu,C):

Mu = linspace(10*tol,0.5,N_VALUES);
X = zeros(3,N_VALUES);
CL = zeros(3,N_VALUES);

for i=1:N_VALUES

    Pi = @(x) P(x,Mu(i));
    yi = fsolve(Pi,x0(Mu(i)),opts);
    X(:,i) = [yi(1) + Mu(i) - 1; Mu(i) - 1 - yi(2); Mu(i) + yi(3)];
    CL(:,i) = C(X(:,i),Mu(i));

end

figure (1)

plot(Mu,X(1,:),'r',Mu,X(2,:),'g',Mu,X(3,:),'b');
title('Plot mu - x:')
xlabel('mu')
ylabel('x')
legend('L1','L2','L3')

figure (2)

plot(Mu,CL(1,:),'r',Mu,CL(2,:),'g',Mu,CL(3,:),'b');
title('Plot mu - C:')
xlabel('mu')
ylabel('C')
legend('L1','L2','L3')
