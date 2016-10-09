function [ y,x ] = step_DOPRI45( h,x0,y0,foo,ord )
%STEP_DOPRI45: Un pas d'un Runge-Kutta d'ordre depenent de l'entrada (usem
%dos metodes:
%
%h: Pas a utilitzar.
%x0: Instant de partida.
%y0: Punt de partida.
%foo: Funcio que defineix el sistema.
%ord: Si es 4, prenem ordre 4. Si es 5, prenem ordre 5.
    
    k1 = foo(x0,y0);
    k2 = foo(x0+h/5,y0+h*k1/5);
    k3 = foo(x0+0.3*h,y0+h*(3*k1/40+9*k2/40));
    k4 = foo(x0+0.8*h,y0+h*(44*k1/45-56*k2/15+32*k3/9));
    k5 = foo(x0+8*h/9,y0+h*(19372*k1/6561-25360*k2/2187+64448*k3/6561-212*k4/729));
    x = x0+h;
    k6 = foo(x,y0+h*(9017*k1/3168-355*k2/33+46732*k3/5247+49*k4/176-5103*k5/18656));
    k7 = foo(x,y0+h*(35*k1/384+500*k3/1113+125*k4/192-2187*k5/6784+11*k6/84));
    
    switch(ord)
        case 4
            y = y0+h*(35*k1/384+500*k3/1113+125*k4/192-2187*k5/6784+11*k6/84);
        case 5
            y = y0+h*(5179*k1/57600+7571*k3/16695+393*k4/640-92097*k5/339200+187*k6/2100+k7/40);
        otherwise
            error('Ordre no implementat per aquest metode.')
    end
end

