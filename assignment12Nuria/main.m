clear all
format long
global TOL;
TOL = 1e-8;
global options;
options = odeset(’RelTol’,TOL,’AbsTol’,TOL);
global mu;
mu = 0.1;
Cmin=2.1;
Cmax=3.189;
AC=1e-3;
Cs=Cmin:AC:Cmax;
Cs=fliplr(Cs);
ics=zeros(1,length(Cs));
xL3 = L3(mu);
x3=xL3;
for i=1:length(Cs)
percentatge=100*i/length(Cs)
global C;
C = Cs(i);
Ax = 1e-3;
%
check = 1;
x1=x3;
x2=x1;
[t2,z2]=crossing(x1);
while check >= 0
x1=x2;
x2=x1+Ax;
t1=t2;
z1=z2;
[t2,z2]=crossing(x2);
check = z1(3)*z2(3);
end
x3=bisection(x1,x2);
ics(i)=x3;
end
