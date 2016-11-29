function [ vx,T ] = integration( x0,mu,def_dt,tol )
%[ vx,T ] = integration( x0,mu,def_dt,tol ) Compute the x-velocity of a body in the RTBP starting at
%[x 0 0 vy] and at the first crossing with the x-axis.
%Input arguments:
%x0: Initial point x0 = [x vy];
%mu: Mass parameter.
%def_dt: Default increment of time (needed for Poincare section).
%tol: Tolerance for stopping criteria.
%Output arguments:
%vx: Velocity on the x-direction at the first crossing.
%T: End-time of the integration (half of the period when vx=0).
    
    g = [0 1 0 0];
    y0 = [x0(1); 0; 0; x0(2)];
    func = @(t,x) RTBPfield(x,mu);
    [yout,tout] = poincare_section(func,g,tol,0,y0,def_dt);
    vx = yout(3,end); T = tout(end);
end

