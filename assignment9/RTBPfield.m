function [ F ] = RTBPfield( mu )
%[ F ] = RTBPFIELD( x,mu ) Function defining the RTBP (without the variational equations).
%Input arguments:
%mu: Mass parameter.
%Output arguments:
%F: 4x1 function that gives the field at the point and time (t,x) (x represents position and velocity).
    
    F = @(t,x) [x(3);x(4);2*x(4) + x(1) - (1-mu)*(x(1)-mu)/(sqrt((x(1)-mu)^2 + x(2)^2)^3) - mu*(x(1)-mu+1)/(sqrt((x(1)-mu+1)^2 + x(2)^2)^3);-2*x(3) + x(2)*(1 - (1-mu)/(sqrt((x(1)-mu)^2 + x(2)^2)^3) - mu/(sqrt((x(1)-mu+1)^2 + x(2)^2)^3))];
end

