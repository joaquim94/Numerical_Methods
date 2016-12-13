function [ z ] = fun( x,y )
%[z] = fun(x,y) Funcio que defineix la EDO per a provar el sistema.
    
    z = zeros(4,1);
    r = norm(y(1:2))^3;
    
    z(1)=y(3);
    z(3) = -y(1)/r;
    
    z(2)=y(4);
    z(4) = -y(2)/r;
end

