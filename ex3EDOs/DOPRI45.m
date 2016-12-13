function [ T,X,I ] = DOPRI45( foo,T0,x0,tol,h )
%[T,X,I] = DOPRI45(foo,T0,x0,tol,h) Implementacio del metode DOPRI45 amb pas variable.
%
%foo: Funcio que defineix el sistema. Ha de tenir per sortides vectors
%columna
%T0: Vector amb instants de temps: el primer és on comença la integració,
%i els seguents son instants on volem integrar el sistema (ordenats creixentment).
%x0: Punt inicial per la integracio, vector columna.
%tol:Tolerancia que exigim.
%h: Pas inicial.
%
%T: Instants en els que s'ha integrat.
%X: Solucio aproximada als instants.
%I: Indexos ens els que es troben els punts demanats.
    
    if tol==0 
        tol=1e-6;
    end
    
    n=length(T0);
    T = T0(1);
    t = T;
    X = x0;
    I=ones(1,n);
    
    for k=2:n  
        while t+h<T0(k)
            t = t+h;
            X = [X, step_DOPRI45(h,t,x0,foo,4)];
            T = [T, t];
            x0 = X(:,end);
            h = new_stepsize_DOPRI45(h,tol,t,x0,foo);
            %t = t+h;
            %X = [X, step_DOPRI45(h,t,x0,foo,4)];
            %T = [T, t];
        end
        
        h=T0(k)-t;
        X = [X, step_heun(h,T(end),X(:,end),foo)];
        T = [T,T0(k)];
        I(k) = length(T);
        t=T0(k);
    end
    
end
