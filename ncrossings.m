clear all

%NCROSSINGS Test our program to find the nth Poincare section with the toy 
%system (the harmonic oscillator).

oscillator = @(t,x) [x(2);-x(1)];
g = [0 1];

k = input('Order of the tolerance (default = 12): ');
if isempty(k) k=12; end
tol = 10^(-k);

time_crossings = input('Initial time (default = 0): ');
if isempty(time_crossings) time_crossings=0; end

def_dt = input('Default time step (default = 0.5): ');
if isempty(def_dt) def_dt=0.5; end

N = input('Number of crossings with the section (default = 2): ');
if isempty(N) N=2; end

crossings = [1;0];

for i=1:N
    t0 = time_crossings(i); x0 = crossings(:,i);
    [Y,T] = poincare_section(oscillator,g,tol,t0,x0,def_dt);
    n = length(T);
    time_crossings = [time_crossings, T(n)];
    crossings = [crossings, Y(:,n)];
end