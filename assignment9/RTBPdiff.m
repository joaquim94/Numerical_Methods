function [ DF ] = RTBPdiff( x,mu )
%[ DF ] = RTBPDIFF( x,mu ) Function that computes the Jacobian matrix of
%the system at a point.
%Input arguments:
%x: Position and velocity.
%mu: Mass parameter.
%Output arguments:
%DF: Jacobian 4x4 matrix of the RTBP field at x.
    
    r1 = sqrt((x(1)-mu)^2 + x(2)^2); r2 = sqrt((x(1)-mu+1)^2 + x(2)^2);
    df31 = 1 - (1-mu)*(x(2)^2 - 2*(x(1)-mu)^2)/(r1^5) - mu*(x(2)^2 - 2*(x(1)-mu+1)^2)/(r2^5);
    df32 = 3*x(2)*((1-mu)*(x(1)-mu)/(r1^5) + mu*(x(1)-mu+1)/(r2^5));
    df42 = 1 - (1-mu)/(r1^3) - mu/(r2^3) + 3*(x(2)^2)*((1-mu)/(r1^5) + mu/(r2^5));
    DF = [0,0,1,0;0,0,0,1;df31,df32,0,2;df32,df42,-2,0];
end

