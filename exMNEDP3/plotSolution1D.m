function plotSolution1D(X,T,u)
% plotSolution1D(X,T,u)

grado = size(T,2)-1;

if grado == 1
    plot(X,u,'b-*')
elseif grado == 2
    xi = linspace(-1,1,11)'; 
    N = [(xi-1).*xi/2   (1+xi).*xi/2    (1-xi).*(1+xi)];
    x_interp = []; u_interp = []; 
    for ielem = 1:size(T,1)
        Te = T(ielem,:);
        Xe = X(Te,:); 
        ue = u(Te); 
        x_interp = [x_interp; N*Xe]; 
        u_interp = [u_interp; N*ue];
    end
    plot(X,u,'b*', x_interp,u_interp,'b'); 
end
