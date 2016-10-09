function [ H ] = new_stepsize_heun( H,tol,x,y,foo )
%NEW_STEPSIZE: Calculem el nou pas a partir de l'anterior (H), la
%tolerancia, i el punt actual, pel metode de Heun i dividint per dos el pas
    
    
    y1 = step_heun(H,x,y,foo);
    y2a = step_heun(H/2,x,y,foo);
    y2 = step_heun(H/2,x+H/2,y2a,foo);
    h=H*(8*norm(y1-y2)/(7*tol))^(-1/3);
    
    while (H/h)>2
        H=H/2;
        y1 = step_heun(H,x,y,foo);
        y2a = step_heun(H/2,x,y,foo);
        y2 = step_heun(H/2,x+H/2,y2a,foo);
        
        h=H*(8*norm(y1-y2)/(7*tol))^(-1/3);
    end
end

