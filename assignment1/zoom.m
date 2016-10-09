clear all

%ZOOM: Here we choose a point in the square [-pi,pi]x[-pi,pi]
%and represent the orbits close to that point.

x1 = input('Choose the x-coordinate of the point around which we are plotting: ');
x2 = input('Choose the y-coordinate of the point around which we are plotting: ');
z = input('Choose the length of the square we are zooming in (default = 0.5): ');
if isempty(z) z=0.5; end
a = input('Value of constant a (default = -0.7): ');
if isempty(a) a=-0.7; end
Nmax = input('Number of iterates per orbit (default = 100): ');
if isempty(Nmax) Nmax=100; end
n = input('Number of orbits (default = 20): ');
if isempty(n) n = 20; end

figure(1)
hold on
axis([x1-z,x1+z,x2-z,x2+z]);
title('Orbits of the map around the point');

initials = linspace(x1-z,x1+z,n);

for i=1:n
    x = zeros(2,Nmax);
    x(:,1) = [initials(i);x2];
    for j=2:Nmax
        x(:,j) = map(x(:,j-1),a);
    end
    plot(x(1,:),x(2,:),'r.','MarkerSize',1);
end