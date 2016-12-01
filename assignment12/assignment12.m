clear all

%Global variables:
mu = 0.1;
dxini = 1e-4; dx = 1e-3;
default_dt = 1e-1;
dC = 1e-3;
tol = 1e-8;
N_ITER = 20;
C = 2.1:dC:3.189;

[L,Cx] = LCRTBP(mu); Lx = L(1,3); C0 = Cx(3);

fileID = fopen('results.txt','w');
for k=1:N_ITER
    %Implement the function returning x' at the Poincare section.
    func = @(x) integration([x,vy0_fromxC(x,C(k),mu)],mu,default_dt,tol);

    %Look for the first change of sign in func:
    x1 = Lx + dxini; f1 = func(x1);
    x2 = x1 + dx; f2 = func(x2);

    while (f1*f2 > 0)
        x1 = x2; x2 = x2 + dx;
        f1 = f2; f2 = func(x2);
    end

    X = bisection(func,[x1,x2],tol);
    VY = vy0_fromxC(X,C(k),mu); [~,T2] = integration([X,VY],mu,default_dt,tol);
    fprintf(fileID,'%.12f %.12f %.12f %.12f\n',C(k),X,VY,T2);
    fprintf('Iteration %d/%d.\n',k,N_ITER)
end
fclose(fileID);