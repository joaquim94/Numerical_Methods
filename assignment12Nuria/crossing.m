function [ t,z ] = crossing( x )
%Poincare section {y=0}
%BIG LOOP
global TOL;
global options;
h = 0.1;
t = 0;
prod = 1;
z=[x,0,0,yprime(x)];
while prod >= 0
tf = t+h;
tspan=[t tf];
[odet,odex] = ode45(@rtbp,tspan,z,options);
y = odex(end,:);
prod = z(2)*y(2);
z = y;
t = tf;
end
%Newton
%SMALL LOOP
it = 0;
while abs(z(2)) > TOL && it < 1000
At = -z(2)/z(4);
tf = t+At;
tspan=[t tf];
[odet,odex] = ode45(@rtbp,tspan,z,options);
z = odex(end,:);
t = tf;
it=it+1;
end
end
