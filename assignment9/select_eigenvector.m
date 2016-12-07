function [ v,L ] = select_eigenvector( mu,i,sign )
%[ v,L ] = SELECT_EIGENVECTOR( mu,i,sign ) Input mu. Calculates the coordinates of the
%equilibrium points L1,L2,L3. Then, select which of the points we want by
%i. Finally, select whether we want the eigenvector of the positive
%eigenvalue (sign > 0) or the eigenvector of the negative eigenvalue (sign
%<0).
%Input arguments:
%mu: Mass parameter.
%i: 1, 2 or 3, to select the equilibrium point (on y=0).
%sign: +1 to denote the unstable manifold eigenvector, -1 to denote the
%stable manifold eigenvector.
%Output arguments:
%v: Vector selected.
%L: Coordinates of the equilibrium point L(i).
    
    [L,~] = LCRTBP(mu);
    L = L(:,i);
    DF = RTBPdiff(mu);
    A = DF(L);
    [V,D] = eig(A);
    j = 1;
    while (imag(D(j,j))~=0 || D(j,j)*sign < 0) j = j+1; end
    v = real(V(:,j));
end

