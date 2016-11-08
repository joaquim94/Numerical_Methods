function [ Tout, Yout ] = integration( mu, Tspan, X0, tol )
%INTEGRATION Integration of the RTBP problem with variational equations.
%mu: Value of mu (between 0 and 1/2).
%Tspan: Times at which the solution must be computed.
%X0: Initial point (point and velocity: 4 coordinates).
%tol: Tolerance to be used.
    
    I = eye(4);
    if size(X0,1) ~= 1
        X0 = X0';
    end
    point0 = [X0, I(1,:), I(2,:), I(3,:), I(4,:)];
    
    odeoptions = odeset('RelTol',tol,'AbsTol',tol);
    
    F = @(t,x) RTBP(x,mu);
    
    [Tout,Yout] = ode45(F,Tspan,point0,odeoptions);
end

