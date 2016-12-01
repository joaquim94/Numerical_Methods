clear all

%Create and fill the file results.txt with all the results:
%mu x vx T (half period).

default_dt = 5;
s = 1e-6;
mu = [0.001:1e-5:0.015, 0.015:1e-4:0.05, 0.05:1e-3:0.49];
n = length(mu);
g = [0 1 0 0];
tol = input('Desired tolerance (default = 1e-12): ');
if isempty(tol) tol = 1e-12; end

fileID = fopen('results.txt','w');
for i=1:n
    m = mu(i);
    [v,L] = select_eigenvector(m,3,1);
    x0 = L - s*v;
    F = @(t,x) RTBPfield(x,m);
    [ycrossing,T] = poincare_section(F,g,tol,0,x0,default_dt);
    fprintf(fileID,'%.8f %.8f %.8f %.8f\n',mu(i),ycrossing(1),ycrossing(3),T);
    fprintf('Iteration %d/%d.\n',i,n)
end

fclose(fileID);
