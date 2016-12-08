clear all

%Global variables:
mu = 0.1;
g = [0 1 0 0]; vel = [0 0 1 0];
dxini = 1e-5; dx = 1e-3;
default_dt = 3;
N_ITER = 20;
tol = 5e-8;
[L,Cx] = LCRTBP(mu); Lx = L(1,3); C0 = Cx(3);
F = RTBPfield(mu);

C = linspace(2.1,C0,N_ITER);

fileID = fopen('results.txt','w');
for k=1:N_ITER
    %Implement the function returning x' at the Poincare section.
    func = @(x) vel*poincare_section(F,g,tol/10,0,[x;0;0;-sqrt(x^2 + 2*(1-mu)/abs(x-mu) + 2*mu/abs(x-mu+1) + mu*(1-mu) - C(k))],default_dt);

    %Look for the first change of sign in func:
    x1 = Lx+dxini; f1 = func(x1);
    x2 = x1 + dx; f2 = func(x2);

    while (f1*f2 > 0)
        x1 = x2; x2 = x2 + dx;
        f1 = f2; f2 = func(x2);
    end

    X = bisection(func,[x1,x2],tol);
    VY = -sqrt(X^2 + 2*(1-mu)/abs(X-mu) + 2*mu/abs(X-mu+1) + mu*(1-mu) - C(k));
    [~,T2] = poincare_section(F,g,tol,0,[X;0;0;VY],default_dt);
    fprintf(fileID,'%.12f %.12f %.12f %.12f\n',C(k),X,VY,T2);
    fprintf('Iteration %d/%d.\n',k,N_ITER)
end
fclose(fileID);