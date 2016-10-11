clear all

%TESTING Test our program to find the Poincare section with the toy system (the
%harmonic oscillator).

oscillator = @(t,x) [x(2);-x(1)];
g = [0 1];

k = input('Order of the tolerance (default = 12): ');
if isempty(k) k=12; end
tol = 10^(-k);

t0 = input('Initial time (default = 0): ');
if isempty(t0) t0=0; end

def_dt = input('Default time step (default = 0.5): ');
if isempty(def_dt) def_dt=0.5; end

x0 = [1;0];

[Y,T] = poincare_section(oscillator,g,tol,t0,x0,def_dt);

n = length(T);
tfin = T(n);

ERROR = abs(abs(tfin)-pi);