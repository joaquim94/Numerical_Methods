function [ H ] = new_stepsize_DOPRI45( H,tol,x,y,foo )
%[H] = new_stepsize_DOPRI45(H,tol,x,y,foo) Calcul del seguent pas a partir de
%tol: Tolerancia presa
%(x,y): Instant i posicio de l'anterior pas.
%foo: Funcio que defineix el sistema
    
    y4=step_DOPRI45(H,x,y,foo,4);
    y5=step_DOPRI45(H,x,y,foo,5);
    e=norm(y4-y5);
    if e<1e-10          %Aquesta es una "tolerancia inferior". Adaptar al gust.
        H=0.1;
    else
        H=H*(tol/e)^(1/5);
    end
    
    while e>tol
        %H=H*(tol/e)^(1/5);
        y4=step_DOPRI45(H,x,y,foo,4);
        y5=step_DOPRI45(H,x,y,foo,5);
        e=norm(y4-y5);
        H=H*(tol/e)^(1/5);
    end
    
end

