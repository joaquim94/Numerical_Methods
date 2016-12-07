function [ DF ] = RTBPdiff( mu )
%[ DF ] = RTBPDIFF( mu ) Function that computes the Jacobian matrix of
%the system at a point x.
%Input arguments:
%mu: Mass parameter.
%Output arguments:
%DF: Jacobian 4x4 function of the RTBP field.
    
    DF = @(x) [0,0,1,0;0,0,0,1;1 - (1-mu)*(x(2)^2 - 2*(x(1)-mu)^2)/(sqrt((x(1)-mu)^2 + x(2)^2)^5) - mu*(x(2)^2 - 2*(x(1)-mu+1)^2)/(sqrt((x(1)-mu+1)^2 + x(2)^2)^5),3*x(2)*((1-mu)*(x(1)-mu)/(sqrt((x(1)-mu)^2 + x(2)^2)^5) + mu*(x(1)-mu+1)/(sqrt((x(1)-mu+1)^2 + x(2)^2)^5)),0,2;3*x(2)*((1-mu)*(x(1)-mu)/(sqrt((x(1)-mu)^2 + x(2)^2)^5) + mu*(x(1)-mu+1)/(sqrt((x(1)-mu+1)^2 + x(2)^2)^5)),1 - (1-mu)/(sqrt((x(1)-mu)^2 + x(2)^2)^3) - mu/(sqrt((x(1)-mu+1)^2 + x(2)^2)^3) + 3*(x(2)^2)*((1-mu)/(sqrt((x(1)-mu)^2 + x(2)^2)^5) + mu/(sqrt((x(1)-mu+1)^2 + x(2)^2)^5)),-2,0];
end

