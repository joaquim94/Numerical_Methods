clear all

%Test2: Here we generate n orbits with n initial conditions given by 
%equidistributed points in the x-axis, with 100 iterates each.

a = input('Value of constant a (default = -0.7): ');
if isempty(a) a=-0.7; end
Nmax = input('Number of iterates per orbit (default = 100): ');
if isempty(Nmax) Nmax=100; end

n = input('Number of orbits: ');

figure(1)
hold on
axis([-pi,pi,-pi,pi]);
title('Orbits of the map');

initials = linspace(-pi,pi,n);

for i=1:n
    x = zeros(2,Nmax);
    x(1,1) = initials(i);
    for j=2:Nmax
        x(:,j) = map(x(:,j-1),a);
    end
    plot(x(1,:),x(2,:),'r.','MarkerSize',1);
end