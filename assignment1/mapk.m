function [ y ] = mapk( x,a,k )
%MAPK: Here we implement the function
%F(x1,x2) = (x1+a*sin(x1+x2), x1+x2)
%Taking in count we are in a torus, and acting k times.

for j=1:k
    y(1) = x(1) + a*sin(x(1)+x(2));
    y(2) = x(1) + x(2);
    
    for i=1:2
        if y(i) < -pi
            y(i) = y(i) + 2*pi;
        else if y(i) >= pi
                y(i) = y(i) - 2*pi;
            end
        end
    end
    x = y;
end

    y = y';
end

