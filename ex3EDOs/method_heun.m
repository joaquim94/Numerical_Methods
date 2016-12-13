function [ T,X,passos ] = method_heun( foo,T0,x0,tol,h )
%[T,X,passos] = method_heun(foo,T0,x0,tol,h) Implementacio del metode de Heun amb pas variable.
%
%foo: Funcio que defineix el sistema. Ha de tenir per sortides vectors
%columna
%T0: Vector de dues components, la primera es l'instant en que comença la
%integracio, i la segona es el temps per acabar.
%x0: Punt inicial per la integracio, vector columna.
%tol:Tolerancia que exigim.
%h: Pas inicial.
    
    if tol==0 
        tol=1e-6;
    end
    
    T = T0(1);
    t = T;
    X = x0;
    passos=[];
    
    while t+h<T0(end)
        x0 = X(:,end);
        h = new_stepsize_heun(h,tol,t,x0,foo);
        passos=[passos,h];
        t = t+h;
        X = [X, step_heun(h/2,t+h/2,step_heun(h/2,t,x0,foo),foo)];
        T = [T, t];
    end
    
    h=T0(end)-t;
    X = [X, step_heun(h,T(end),X(:,end),foo)];
    T = [T,T0(end)];
    
end

