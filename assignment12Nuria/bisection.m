function [ c ] = bisection( a,b )
global TOL;
%check
dxa=dxcrossing(a);
dxb=dxcrossing(b);
ehem = dxa*dxb;
if ehem > 0
ehem
elseif dxa==0
c=a;
elseif dxb==0
c=b;
else c = (a+b)/2;
dxc=dxcrossing(c);
while abs(dxc) > TOL
c = (a+b)/2;
dxc=dxcrossing(c);
if dxc*dxa < 0
b = c;
dxb=dxc;
else
a = c;
dxa=dxc;
end
end
end
end
