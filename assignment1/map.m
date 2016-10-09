function [ y ] = map( x,a )
%MAP: Here we implement the function
%F(x1,x2) = (x1+a*sin(x1+x2), x1+x2)
%Taking in count we are in a torus

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
    
    y = y';

