clear all

%Plot the various results. Needs to have executed AFTER assignment10A.m

k = input('Select the plot:\n k=1 plot mu-vx for mu in (0.001,0.5)\n k=2 plot mu-vx for mu in (0.001,0.1)\n k=3 plot mu-x for mu in (0.001,0.5)\n k = ');
if isempty(k) k = 1; end

fileID = fopen('results.txt','r');
formatSpec = '%f %f %f %f';
sizeA = [4,Inf];

results = fscanf(fileID,formatSpec,sizeA); results = results';
fclose(fileID);

switch k
    case 1
        plot(results(:,1),results(:,3),'.','MarkerSize',1)
        title('Plot of mu-velocity in (0.001,0.5)')
        xlabel('mu'); ylabel('vx');
    case 2
        i = 1;
        while (results(i,1)<0.1)
            i = i+1;
        end
        plot(results(1:i,1),results(1:i,3),'.','MarkerSize',1)
        title('Plot of mu-velocity in (0.001,0.1)')
        xlabel('mu'); ylabel('vx');
    case 3
        plot(results(:,1),results(:,2),'.','MarkerSize',1)
        title('Plot of mu-x in (0.001,0.5)')
        xlabel('mu'); ylabel('x');
end