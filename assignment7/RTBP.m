function [ y ] = RTBP( x,mu )
%RTBP function defining the 20-equations first order variational system.
    
    if size(x,1) ~= 1
        x = x';
    end
    Dfi = [x(5:8);x(9:12);x(13:16);x(17:20)];
    y = zeros(20,1);
    y(1) = x(3); y(2) = x(4);
    r1 = sqrt((x(1)-mu)^2 + x(2)^2); r2 = sqrt((x(1)-mu+1)^2 + x(2)^2);
    y(3) = 2*x(4) + x(1) - (1-mu)*(x(1)-mu)/(r1^3) - mu*(x(1)-mu+1)/(r2^3);
    y(4) = -2*x(3) + x(2)*(1 - (1-mu)/(r1^3) - mu/(r2^3));
    
    df31 = 1 - (1-mu)*(x(2)^2 - 2*(x(1)-mu)^2)/(r1^5) - mu*(x(2)^2 - 2*(x(1)-mu+1)^2)/(r2^5);
    df32 = 3*((1-mu)*(x(1)-mu)*x(2)/(r1^5) + mu*(x(1)-mu+1)*x(2)/(r2^5));
    df41 = 3*x(2)*((1-mu)*(x(1)-mu)/(r1^5) + mu*(x(1)-mu+1)/(r2^5));
    df42 = 1 - (1-mu)/(r1^3) - mu/(r2^3) + 3*((1-mu)*x(2)/(r1^5) + mu*x(2)/(r2^5));
    DF = [0,0,1,0;0,0,0,1;df31,df32,0,2;df41,df42,-2,0];
    
    Dfi = DF*Dfi;
    y(5:8) = Dfi(1,:);
    y(9:12) = Dfi(2,:);
    y(13:16) = Dfi(3,:);
    y(17:20) = Dfi(4,:);
end
