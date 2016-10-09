function [X,T]=createUniformMesh1D(a,b,nElem,grado)
% [X,T]=createUniformMesh1D(a,b,nElem,grado)

nnodes = nElem*grado+1; %numero de nodos

X=linspace(a,b,nnodes)';
%Matriu connectivitat
switch grado
    case 1
        T=[1:nnodes-1;2:nnodes]'; %lineal
    case 2
        aux = [1:2:nnodes-2]';
        T=[aux,aux+2,aux+1]; %cuadratico
    otherwise
        error('Elemento no implementado')
end
