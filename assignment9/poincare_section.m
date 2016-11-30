function [ Y,T ] = poincare_section( f,g,tol,t0,x0,def_dt )
%[Y,T] = POINCARE_SECTION(f,g,tol,t0,x0,def_dt) We compute the first crossing time (T) and
%point (y) of the flow for the system x' = f(x).
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
%N_MAX_ITERATIONS: To avoid certain exceptions of looping, we impose a
%maximum number of iterations, and the integrator to take a half step if it
%surpasses it.
    
    N_MAX_ITERATIONS = 100;
    
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
    while (first_g_value*g_value > 0)
        [~,yout] = ode45(f,[T,T+def_dt],Y,odeoptions);
        T = T + def_dt; Y = yout(end,:)';
        g_value = g*Y;
    end
    
    k = 0;
    
    %When we reach this point of the program, we have crossed the section.
    %Now we just need to refine the solution until we get close enough to it.
    while (abs(g_value) >= tol)
        k = k+1;
        F = f(T,Y);
        %We take in count the possibility of encounter with a fixed point
        %for the flow.
        if (norm(F) < tol)
            error('Execution stopped. Found a fixed point for the map at x.');
        end
        
        dt = -g_value/(g*F);
        [~,yout] = ode45(f,[T,T+dt],Y,odeoptions);
        T = T+dt; Y = yout(end,:)';
        g_value = g*Y;
        
        %"Bisection" step, to avoid the cases when the loop gets stuck
        %between two steps.
        if (k==N_MAX_ITERATIONS)
            dt = -g_value/(2*g*f(T,Y));
            [~,yout] = ode45(f,[T,T+dt],Y,odeoptions);
            T = T+dt; Y = yout(end,:)';
            g_value = g*Y;
            k = 0;
        end
    end
end

