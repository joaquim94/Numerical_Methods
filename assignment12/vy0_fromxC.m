function [ vy ] = vy0_fromxC( x,C,mu )
%[ vy ] = VY0_FROMXC( x,C,mu ) Compute the initial velocity vy such that a body
%starting at [x,0,0,vy] under the RTBP remains at the trajectory with value
%of C constant.
%Input arguments:
%x: Value of position on the x-axis.
%C: Value of Jacobi constant on the trajectory.
%mu: Value of the mass parameter.
%Output arguments:
%vy: Value of the velocity on the y-direction and negative.
    vy = - sqrt(x^2 + 2*(1-mu)/abs(x-mu) + 2*mu/abs(x-mu+1) + mu*(1-mu) - C);
end

