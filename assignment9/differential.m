function [ DF ] = differential( x,mu )
%DIFFERENTIAL Returns the jacobian matrix of the function defining the
%RTBP.
    
    r1 = sqrt((x(1)-mu)^2 + x(2)^2); r2 = sqrt((x(1)-mu+1)^2 + x(2)^2);
    df31 = 1 - (1-mu)*(x(2)^2 - 2*(x(1)-mu)^2)/(r1^5) - mu*(x(2)^2 - 2*(x(1)-mu+1)^2)/(r2^5);
    df32 = 3*((1-mu)*(x(1)-mu)*x(2)/(r1^5) + mu*(x(1)-mu+1)*x(2)/(r2^5));
    df41 = 3*x(2)*((1-mu)*(x(1)-mu)/(r1^5) + mu*(x(1)-mu+1)/(r2^5));
    df42 = 1 - (1-mu)/(r1^3) - mu/(r2^3) + 3*((1-mu)*x(2)/(r1^5) + mu*x(2)/(r2^5));
    DF = [0,0,1,0;0,0,0,1;df31,df32,0,2;df41,df42,-2,0];
    
end

