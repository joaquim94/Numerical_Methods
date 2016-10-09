function [errorL2,errorH1]=computeErrors(u,X,T,theReferenceElement)

IPcoord = theReferenceElement.IPcoord;
IPweight = theReferenceElement.IPweights;
N = theReferenceElement.N;
dNdxi = theReferenceElement.dNdxi;

nOfElements = size(T,1);

errorL2 = 0;
errorH1 = 0;

%Loop in elements
for i=1:nOfElements
    Te=T(i,:); %nodes in the element
    Xe=X(Te); %nodal coordinates in the element
    Ue=u(Te); %nodal values at the element
    for k=1:length(IPweight)
        Nk=N(k,:);
        Nkxi=dNdxi(k,:);
        xk = Nk*Xe;
        J = Nkxi*Xe;
        dx=IPweight(k)*det(J);
        Nkx=J\Nkxi;
        [uex,duex]=analytical(xk);
        errorL2 = errorL2 + (uex-Nk*Ue)^2*dx;
        errorH1 = errorH1 + (duex-Nkx*Ue)^2*dx;
    end      
end
errorH1=errorH1+errorL2;
errorL2 = sqrt(errorL2);
errorH1 = sqrt(errorH1);
  