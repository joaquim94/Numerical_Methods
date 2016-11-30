clear all
%Compute the first crossing with y=0 and plot the trajectory on the
%direction of the unstable manifold.

s = 1e-8;

mu = input('Select the value(s) of mu to use (default=0.008): ');
if isempty(mu) mu = 0.008; end

tol = input('Desired tolerance (default=1e-12): ');
if isempty(tol) tol = 1e-12; end

odeoptions = odeset('Abstol',tol,'RelTol',tol);

figure (1)
hold on
plot(linspace(-2.5,1.5,1000),zeros(1000,1))
for i=1:length(mu)
    [v,L] = select_eigenvector(mu(i),3,1);

    x0 = L - s*v;

    F = @(t,x) RTBPfield(x,mu(i));
    [~,T] = poincare_section(F,[0 1 0 0], tol, 0, x0, 1);
    [tout,z] = ode45(F,[0,T],x0,odeoptions);

    plot(z(:,1),z(:,2),'.-','Markersize',1)
end

title('Plot for mu')
xlabel('x'); ylabel('y');