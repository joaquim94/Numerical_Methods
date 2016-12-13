function [ dz ] = rtbp( t,z )
global mu;
Omegax = z(1) - (1-mu)*(z(1)-mu)/((((z(1)-mu)^2+z(2)^2)^(1/2))^3)
- mu*(z(1)-mu+1)/((((z(1)-mu+1)^2+z(2)^2)^(1/2))^3);
Omegay = z(2)*(1-(1-mu)/((((z(1)-mu)^2+z(2)^2)^(1/2))^3)
-mu/((((z(1)-mu+1)^2+z(2)^2)^(1/2))^3));
dz = [z(3);z(4);2*z(4)+Omegax;-2*z(3)+Omegay];
end
