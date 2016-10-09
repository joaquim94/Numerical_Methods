a = 1; nu=1.e-2;
finalTime = 0.6;

%Numerical solution
nOfElements = 100; h=1/nOfElements; X = linspace(0,1,nOfElements+1);
u0 = exp(-100*(X'-0.4).^2); %initial condition
At = 0.001; nOfTimeSteps = round(finalTime/At); 
CourantNumber = a*At*nOfElements;
r = nu*At/h^2; Pe = a*h/(2*nu);
fprintf('\n r=%g  Pe=%g  CourantNum=%g\n',r,Pe,CourantNumber);
U=transientConvectionDiffusionEquation(X,u0,a,nu,At,nOfTimeSteps);

%Postprocess
figure(1), stepDib = round(nOfTimeSteps/10);
plot(X,U(:,1:stepDib:end))



