function [ y ] = RTBPfield( x,mu )
%[ y ] = RTBPFIELD( x,mu ) Function defining the RTBP (without the variational equations).
%Input arguments:
%x: Position and velocity.
%mu: Mass parameter.
%Output arguments:
%y: 4x1 vector with velocity and accelerarion.
    
    y = zeros(4,1);
    y(1) = x(3); y(2) = x(4);
    r1 = sqrt((x(1)-mu)^2 + x(2)^2); r2 = sqrt((x(1)-mu+1)^2 + x(2)^2);
    y(3) = 2*x(4) + x(1) - (1-mu)*(x(1)-mu)/(r1^3) - mu*(x(1)-mu+1)/(r2^3);
    y(4) = -2*x(3) + x(2)*(1 - (1-mu)/(r1^3) - mu/(r2^3));
    
end

