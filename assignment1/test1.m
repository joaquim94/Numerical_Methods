clear all

%Test1: Here we generate n orbits with n initial conditions given by the
%user, with 100 iterates each.

a = input('Value of constant a (default = -0.7): ');
if isempty(a) a=-0.7; end
Nmax = input('Number of iterates per orbit (default = 100): ');
if isempty(Nmax) Nmax=100; end

n0 = input('Number of initial conditions: ');

figure (1)
hold on
axis([-pi,pi,-pi,pi]);
title('Orbits of the system');

for i=1:n0
    x1 = input('Initial condition for x: ');
    x2 = input('Initial condition for y: ');
    x = [x1; x2];
    for j=1:Nmax
        x = [x, map(x(:,j),a)];
    end
    
    plot(x(1,:),x(2,:),'r.')
end