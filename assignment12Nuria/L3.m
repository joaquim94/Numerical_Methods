function [ xL3 ] = L3( mu )
%compute L3
global TOL;
x0 = 1 - 7*mu/12;
x = x0;
gx = (((1-mu)*(1+x)^2)/(1+2*mu+x*(2+mu+x)))^(1/3);
while abs(gx-x) >= TOL
x = gx;
gx = (((1-mu)*(1+x)^2)/(1+2*mu+x*(2+mu+x)))^(1/3);
end
xL3 = mu+x;
end
