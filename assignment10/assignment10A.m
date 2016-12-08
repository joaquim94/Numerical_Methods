clear all

%Create and fill the file results.txt with all the results:
%mu x vx T (half period).

default_dt = 3;
%refined_dt = 1;
%refined = [32,46,87,118,267,361,478,577,582,593:596,620:632,744,779,813,976,1020,1039,1054,1069:1075,1148,1220,1396,1399,1423:1480,1699,1819,1823,1827,2167];
s = 1e-4;
mu = [0.001:1e-5:0.015, 0.015:1e-4:0.05, 0.05:1e-3:0.49];
n = length(mu);
g = [0 1 0 0];

tol = input('Desired tolerance (default = 1e-8): ');
if isempty(tol) tol = 1e-8; end
begin_with = input('Select index to start debugging (default = 1): ');
if isempty(begin_with) begin_with = 1; end

fileID = fopen('results.txt','w');
for i=begin_with:n
    [v,L] = select_eigenvector(mu(i),3,1);
    x0 = L - s*v;
    F = RTBPfield(mu(i));
    [ycrossing,T] = poincare_section(F,g,tol,0,x0,default_dt);
    fprintf(fileID,'%.8f %.8f %.8f %.8f\n',mu(i),ycrossing(1),ycrossing(3),T);
    fprintf('Iteration %d/%d.\n',i,n)
end

fclose(fileID);
