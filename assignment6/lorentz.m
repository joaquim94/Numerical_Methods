function [ Tout,Yout ] = lorentz( tol,rho,sigma,beta,x0,Tfin,n_points )
%LORENTZ Integrate the Lorentz system given the parameters, conditions and
%number of points we want.
%Input arguments:
%tol: Tolerance for the integration.
%rho,sigma,beta: Parameters for the system.
%x0: Initial condition.
%Tfin: Final time.
%n_points: Number of points on the integration.
%
%Output arguments:
%Tout: Vector with the times.
%Yout: Points of the trajectory.
    
    F = @(t,x) [sigma*(x(2)-x(1));rho*x(1)-x(2)-x(1)*x(3);x(1)*x(2)-beta*x(3)];
    odeoptions = odeset('AbsTol',tol,'RelTol',tol);
    Tout = linspace(0,Tfin,n_points);
    [~,Yout] = ode45(F,Tout,x0,odeoptions);
end
