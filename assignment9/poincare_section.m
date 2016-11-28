function [ Y,T ] = poincare_section( f,g,tol,t0,x0,def_dt )
%[Y,T] = POINCARE_SECTION(f,g,tol,t0,x0,def_dt) We compute the first crossing time (T) and
%point (y) of the flow for the system x' = f(x). Arguments:
%f: Function defining the system.
%g: Vector ortogonal to the section (we assume it is always a hyperplane).
%tol: Tolerance that we accept.
%t0: Initial time.
%x0: Initial position.
%def_dt: Default time increment that will be used before crossing the
%section. If it is negative, we automatically have a backwards integration.
%
%Output arguments:
%Y: Array with the points used. The last column is the first crossing point.
%T: Array with the times used. The last one is the first crossing time.
    
    first_g_value = g*x0;
    odeoptions = odeset('RelTol',tol,'AbsTol',tol);
    Y = x0; T = t0;
    x = x0; t = t0;
    %If we begin at the section (or close enough), we make a first
    %integration step.
    if (abs(first_g_value) < tol)
        [tout,yout] = ode45(f,[t0,t0+def_dt],x0,odeoptions);
        t = t + def_dt; x = yout(end,:)';
        T = [T, tout']; Y = [Y, x];
        first_g_value = g*x;
    end
    
    %We take integration steps until the sign of g*x changes.
    g_value = g*x;
    while (first_g_value*g_value > 0)
        [tout,yout] = ode45(f,[t,t+def_dt],x,odeoptions);
        t = t + def_dt; x = yout(end,:)';
        T = [T, tout(end)]; Y = [Y, x];
        g_value = g*x;
    end
    
    %When we reach this point of the program, we have crossed the section.
    %Now we just need to refine the solution until we get close enough to it.
    while (abs(g_value) >= tol)
        F = f(t,x);
        %We take in count the possibility of encounter with a fixed point
        %for the flow.
        if (norm(F) < tol)
            error('Execution stopped. Found a fixed point for the map at x.');
        end
        
        dt = -g_value/(g*F);
        [~,yout] = ode45(f,[t,t+dt],x,odeoptions);
        t = t+dt; x = yout(end,:)';
        %Save the point only if it belongs to the principal branch of the orbit.
        x
        g_value = g*x
        if (first_g_value*g_value >= 0)
            T = [T, t]; Y = [Y, x];
        end
    end
end

