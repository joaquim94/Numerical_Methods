function [ v ] = select_eigenvector( mu,i,sign )
%SELECT_EIGENVECTOR Input a mu, so it calculates the coordinates of the
%equilibrium points L1,L2,L3. Then, select which of the points we want by
%i. Finally, select whether we want the eigenvector of the positive
%eigenvalue (sign > 0) or the eigenvector of the negative eigenvalue (sign
%<0).
    
    [L,~] = LCRTBP(mu);
    x = L(:,i);
    [~,A] = RTBPfield(x,mu);
    [V,D] = eig(A);
    j = 1;
    while (j<4 &&(imag(D(j,j))~=0 || D(j,j)*sign < 0)) j = j+1; end
    v = V(:,j);
end

