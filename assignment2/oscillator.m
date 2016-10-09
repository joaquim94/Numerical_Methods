function [ y ] = oscillator( t,x )
%OSCILLATOR: Compute the value of a function to implement the harmonic
%oscillator

    y = zeros(2,1);
    y(1) = x(2);
    y(2) = -x(1);
end

