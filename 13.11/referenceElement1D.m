function theReferenceElement = referenceElement1D(degree)
%
% theReferenceElement = referenceElement1D(degree)
%

switch degree
    case 1
        GaussCoordinates = [-sqrt(3)/3; sqrt(3)/3];             %Punts d'integracio
        GaussWeights = [1 1];                                   %Pesos d'integracio
        N = [(1-GaussCoordinates)/2 (1+GaussCoordinates)/2];    %Funcions Ni avaluades als punts d'integracio
        dNdxi = [-1/2 1/2; -1/2 1/2];                           %Coeficients de la derivada del canvi de coordenades en cada punt d'integracio
        
    case 2
        GaussCoordinates = [-sqrt(3/5); 0; sqrt(3/5)];        %Punts d'integracio
        GaussWeights = [5/9 8/9 5/9];                           %Pesos d'integracio
        N = [0.5*GaussCoordinates.^2 - 0.5*GaussCoordinates, 0.5*GaussCoordinates.^2 + 0.5*GaussCoordinates, 1-GaussCoordinates.^2];
        dNdxi = [GaussCoordinates - 1/2, GaussCoordinates + 1/2, -2*GaussCoordinates];
    otherwise
        error(['No se puede utilizar una interpolacion de grado ',num2str(p)]);
end

theReferenceElement.IPcoord=GaussCoordinates;
theReferenceElement.IPweights=GaussWeights;
theReferenceElement.N = N;
theReferenceElement.dNdxi = dNdxi;

