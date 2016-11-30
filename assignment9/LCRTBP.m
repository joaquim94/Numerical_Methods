function [ L,C ] = LCRTBP( mu )
%[ L,C ] = LCRTBP( mu ) We compute the three equilibrium points and their values of C
%(Jacobi constant) for mu.
%Input arguments:
%mu: A scalar mass parameter.
%Output arguments:
%L: A matrix 4x3, with the coordinates of the i-th equilibrium point at the
%column i.
%C: A row vector, with the values of the Jacobi constant at each
%equilibrium point.
    
    P = @(x) [x(1)^5 - (3-mu)*x(1)^4 + (3-2*mu)*x(1)^3 - mu*x(1)^2 + 2*mu*x(1) - mu, x(2)^5 + (3-mu)*x(2)^4 + (3-2*mu)*x(2)^3 - mu*x(2)^2 - 2*mu*x(2) - mu, x(3)^5 + (2+mu)*x(3)^4 + (1+2*mu)*x(3)^3 - (1-mu)*x(3)^2 - 2*(1-mu)*x(3) - (1-mu)];
    x0 = [nthroot(mu/(3*(1-mu)),3), nthroot(mu/(3*(1-mu)),3), 1 - 7/12* mu];
    opts = optimset('TolFun',5e-14,'TolX',5e-14,'Display','off');
    y = fsolve(P,x0,opts); y = [y(1) + 0.1 - 1, 0.1 - 1 - y(2), 0.1 + y(3)]; L = [y;zeros(3,3)];
    C = y.^2 + 2*(1-mu)./(abs(y-mu)) + 2*mu./(abs(y-mu+1)) + mu*(1-mu);
end

