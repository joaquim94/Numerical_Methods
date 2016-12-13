function [ y,x ] = step_heun( h,x0,y0,foo )
%[y,x] = step_heun(h,x0,y0,foo) Fem una passa del metode de Heun (Runge-Kutta d'ordre 2).
%Variables:
%
%h: Pas a usar.
%x0: Punt de partida pel pas per la variable independent.
%y0: El mateix per les variables dependents.
%foo: Funcio que defineix el sistema.
%(x,y): Instant i punt després d'executar el pas.
    
    k1 = foo(x0,y0);
    k2 = foo(x0+2*h/3,y0+2*h*k1/3);
    x = x0+h;
    y = y0+h/4*(k1 + 3*k2);
    
end

