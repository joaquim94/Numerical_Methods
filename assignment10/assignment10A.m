clear all

defaultdt = 1;
s = 1e-6;
mu = [0.001:1e-5:0.015, 0.015:1e-4:0.05, 0.05:1e-3:0.49];
n = length(mu);
g = [0 1 0 0];
tol = input('Desired tolerance (default = 1e-14): ');
if isempty(tol) tol = 1e-14; end

fileID = fopen('results.txt','w');
for i=1:n
    L = LCRTBP(mu(i)); L = L(:,3);
    v = select_eigenvector(mu(i),3,1);
    x0 = L - s*v;
    F = @(t,x) [x(3);x(4);2*x(4) + x(1) - (1-mu(i))*(x(1)-mu(i))/(sqrt((x(1)-mu(i))^2 + x(2)^2)^3) - mu(i)*(x(1)-mu(i)+1)/(sqrt((x(1)-mu(i)+1)^2 + x(2)^2)^3); -2*x(3) + x(2)*(1 - (1-mu(i))/(sqrt((x(1)-mu(i))^2 + x(2)^2)^3) - mu(i)/(sqrt((x(1)-mu(i)+1)^2 + x(2)^2)^3))];
    [Y,T] = poincare_section(F,g,tol,0,x0,defaultdt);
    ycrossing = Y(end,:);
    fprintf(fileID,'mu: %f.6 x: %f.6 vx: %f.6\n',mu(i),ycrossing(1),ycrossing(3));
end

fclose(fileID);
