clear all;


N = input('Indiqueu quants passos a fer: ');
%Resolucio de -u_xx = f en (0,1) amb
%u(0)=u0 i u(1)=u1
u0=0; u1=0;

%Element de referencia
referenceElement1=referenceElement1D(1);
referenceElement2=referenceElement1D(2);

e = zeros(2,N);

%Bucle en mida de la malla
for i=1:N
    nOfElements=10^i;
    [X1,T1]=createUniformMesh1D(0,1,nOfElements,1);
    [X2,T2]=createUniformMesh1D(0,1,nOfElements,2);
    
    [K1,f1] = computeSystemLaplace1D(X1,T1,referenceElement1);   %Sistema per grau 1
    [K2,f2] = computeSystemLaplace1D(X2,T2,referenceElement2);   %Sistema per grau 2
    
    f1 = f1(2:end-1) - K1(2:end-1,1)*u0 - K1(2:end-1,end)*u1;   %Condicions de contorn de Dirichlet
    K1 = K1(2:end-1,2:end-1);
    f2 = f2(2:end-1) - K2(2:end-1,1)*u0 - K2(2:end-1,end)*u1;
    K2 = K2(2:end-1,2:end-1);
    
    v1 = K1\f1;
    v2 = K2\f2;
    v1 = [u0;v1;u1];
    v2 = [u0;v2;u1];
    
    [e(1,i),~] = computeErrors(v1,X1,T1,referenceElement1);
    [e(2,i),~] = computeErrors(v2,X2,T2,referenceElement2);
    fprintf('\n He fet la iteracio %d', i);
end

fprintf('\n');
plot(1:N,log(e(1,:)),1:N,log(e(2,:)))
legend('Grau 1','Grau 2')
xlabel('log(nombre de passes)'); ylabel('log(error)');
title('Gràfiques de errors')