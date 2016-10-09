function [ ] = representa( v0,h,tol )
%REPRESENTA: dibuixa la grafica de la trajectoria pel problema de força
%central amb posicio inicial (1,0) i velocitat inicial (0,v0). No genera
%cap sortida.
    
    %[~,X] = method_heun(@fun,[0,2*pi],[1;0;0;v0],tol,h);
    [~,X] = DOPRI45(@fun,[0,2*pi],[1;0;0;v0],tol,h);
    plot(X(1,:),X(2,:),'-o')
    
end

