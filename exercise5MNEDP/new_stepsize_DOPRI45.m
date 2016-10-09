function [ H ] = new_stepsize_DOPRI45( H,tol,x,y,foo )
%NEW_STEPSIZE_DOPRI45: Calculem el nou pas a partir de l'anterior (H), la
%tolerancia (tol), i el punt actual (x,y), pel metode de DOPRI45
    
    y4 = step_DOPRI45(H,x,y,foo,4);
    y5 = step_DOPRI45(H,x,y,foo,5);
    e = norm(y4-y5);
    
    while e>tol
        H = H*(tol/e)^(1/5);
        y4 = step_DOPRI45(H,x,y,foo,4);
        y5 = step_DOPRI45(H,x,y,foo,5);
        e = norm(y4-y5);
    end
    
end

