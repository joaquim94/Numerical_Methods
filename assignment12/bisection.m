function [ x ] = bisection( F,I0,tol )
%[a,b] = BISECTION(F,x0,tol) Implementation of the bisection method.
%Input arguments:
%F: The one-variable function whose zero we need to compute.
%I0: Initial interval, a two-component vector with F(I0(1))*F(I0(2)) < 0.
%tol: Tolerance for the stopping criteria of the method.
%Output arguments:
%x: Value of the zero for F between I0(1) and I0(2).

    if (F(I0(1))*F(I0(2)) > 0)
        error('Execution stopped. Invalid initial interval.');
    end
    
    x = (I0(1)+I0(2))/2;
    I = [x, I0];
    a = [F(I(1)), F(I(2)), F(I(3))];
    while (abs(a(1)) >= tol && abs(I(2)-I(3)) >= tol)
        if (a(1)*a(2) < 0)
            x = (I(1)+I(2))/2;
            I = [x, I(2),I(1)];
            a = [F(x), a(2), a(1)];
        else
            x = (I(1)+I(3))/2;
            I = [x, I(1),I(3)];
            a = [F(x),a(1),a(3)];
        end
    end
end

