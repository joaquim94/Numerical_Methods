function [dy] = yprime(x)
global mu;
global C;
dy=-abs(sqrt(x^2+2*(1-mu)/abs(x-mu)+2*mu/abs(x-mu+1)+mu*(1-mu)-C));
end
