function [K,f] = computeSystemLaplace1D(X,T,referenceElement)

[nOfElements,nOfElementNodes] = size(T);
nOfNodes = size(X,1);

K=spalloc(nOfNodes,nOfNodes,3*nOfNodes);
f=zeros(nOfNodes,1);

%Bucle en elements
    for e=1:nOfElements
        Te = T(e,:); %nodes de l'element e
        Xe = X(Te,:); %coordenades nodes de l'element
        [Ke,fe] = elementalComputations(Xe,referenceElement);
        K(Te,Te) = K(Te,Te) + Ke;
        f(Te) = f(Te) + fe;
        %figure(1), spy(K), pause %per probar si el que hem fet t� sentit
    
    end
    
    function [Ke,fe] = elementalComputations(Xe,referenceElement)
    %h = Xe(2)-Xe(1);
    %Ke = (1/h)*[1 -1; -1 1];
    %fe = h*[-1;-1];
    
    w=referenceElement.IPweights;
    IPcoord=referenceElement.IPcoord;
    N= referenceElement.N;
    dNdxi = referenceElement.dNdxi;
    
    nOfElementNodes = size(Xe,1);
    fe=zeros(nOfElementNodes,1);
    Ke=zeros(nOfElementNodes);
    
    %Bucle en els punts d'integració
    for k=1:length(w)
        Nk = N(k,:); %Funcions de forma avaluades al punt d'integracio
        dNdxik = dNdxi(k,:);    %Diferencial del canvi de coordenades
        xk = Nk*Xe;    %Punts d'integracio transformats en [Xe,Xe+1]
        J = dNdxik*Xe;          
        dNdxk = J\dNdxik;       
        dvol=det(J)*w(k);       
        fe = fe + Nk'*source(xk)*dvol;
        %fe = fe + Nk'*(-2)*dvol;
        %fe = fe + Nk'*invent(xk)*dvol;
        
        Ke = Ke + dNdxk'*dNdxk*dvol;
    end
    end

end

