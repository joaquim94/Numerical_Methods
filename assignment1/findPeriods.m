clear all

%FINDPERIODS: This script implements a method to find (numerically) a
%fixed point of F^k, where F is the functions we are currently studying
%(with a parameter a that can be changed but defaults to -0.7), and k is a
%positive integer, near a starting point x0. This can help us to find
%periods of F of length k.

a = input('Value of constant a (default = -0.7): ');
if isempty(a) a=-0.7; end
k = input('Length of the periods we are looking for: ');
x1 = input('Value of the x-coordinate of the initial point: ');
x2 = input('Value of the y-coordinate of the initial point: ');

F = @(x) mapk(x,a,k) - x;
period = fsolve(F,[x1;x2]);