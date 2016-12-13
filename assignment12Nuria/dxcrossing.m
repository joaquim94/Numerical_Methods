function [ dx ] = dxcrossing( x )
[t,z]=crossing(x);
dx=z(3);
end
