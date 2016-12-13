function [ Y,T ] = poincare_section( f,g,tol,t0,x0,def_dt )
%[Y,T] = POINCARE_SECTION(f,g,tol,t0,x0,def_dt) We compute the first crossing time (T) and
%point (Y) of the flow for the system x' = f(x).
%Arguments:
%f: Function defining the system.
%g: Vector ortogonal to the section (we assume it is always a hyperplane).
%tol: Tolerance that we accept.
%t0: Initial time.
%x0: Initial position.
%def_dt: Default time increment that will be used before crossing the
%section. If it is negative, we automatically have a backwards integration.
%
%Output arguments:
%Y: Column vector with coordinates of first crossing point.
%T: The first crossing time.
%
%Parameters:
%N_MAX_ITERATIONS: Maximum number of iterations before executing a def_dt
%step.

    N_MAX_ITERATIONS = 50;
    
    first_g_value = g*x0;
    odeoptions = odeset('RelTol',tol,'AbsTol',tol);
    Y = x0; T = t0;
    %If we begin at the section (or close enough), we make a first
    %integration step.
    if (abs(first_g_value) < tol)
        [~,yout] = ode45(f,[T,T+def_dt],x0,odeoptions);
        T = T + def_dt; Y = yout(end,:)';
        first_g_value = g*Y;
    end
    
    %We take integration steps until the sign of g*x changes.
    g_value = g*Y;
    while (not(any(first_g_value*g_value < 0)))
        Y = Y(:,end);
        [tout,yout] = ode45(f,[T,T+def_dt],Y,odeoptions);
        T = T + def_dt; Y = yout';
        g_value = yout*g';
    end
    
    Y = Y(:,end);
    i=1;
    while (first_g_value*g_value(i) > 0) i=i+1; end
    T1 = tout(i-1); T2 = tout(i); Taux = (T1+T2)/2;
    G1 = g_value(i-1); G2 = g_value(i);
    [~,yout] = ode45(f,[T,Taux],Y,odeoptions);
    T = Taux; Y = yout(end,:)';
    g_value = g*Y;
    
    %When we reach this point of the program, we have crossed the section.
    %Now we just need to refine the solution until we get close enough to it.
    k = 0;
    while (abs(g_value) >= tol)
        F = f(T,Y);
        k = k+1;
        
        %Make a special step if we reach the maximum number of refinement
        %steps.
        if k==N_MAX_ITERATIONS
            Taux = (T1+T2)/2;
            [~,yout] = ode45(f,[T,Taux],Y,odeoptions);
            T = Taux; Y = yout(end,:)';
            g_value = g*Y;
            k = 0;
            F = f(T,Y);
        end
        
        %We take in count the possibility of encounter with a fixed point
        %for the flow.
        if (norm(F) < tol)
            error('Execution stopped. Found a fixed point for the map at x.');
        end
        
        dt = -g_value/(g*F);
        [~,yout] = ode45(f,[T,T+dt],Y,odeoptions);
        T = T+dt; Y = yout(end,:)';
        g_value = g*Y;
        if (first_g_value*g_value > 0 && abs(g_value) < abs(G1))
            T1 = T; G1 = g_value;
        end
        if (first_g_value*g_value < 0 && abs(g_value) < abs(G2))
            T2 = T; G2 = g_value;
        end
    end
end
