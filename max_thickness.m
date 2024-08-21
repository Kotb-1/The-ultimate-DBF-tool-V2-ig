function [X_cor,m] = max_thickness(NACA,name,path)

numNodes   = '486';
saveFlnmAF = ['Save_Airfoil' NACA '.dat'];

% Delete files if they exist
if (exist(saveFlnmAF,'file'))
    delete(saveFlnmAF);
end
if (exist('xfoil_input.txt','file'))
    delete('xfoil_input.txt');
end

% Create the airfoil
fid = fopen('xfoil_input.txt','w');
fprintf(fid,['NACA ' NACA '\n']);
fprintf(fid,'PPAR\n');
fprintf(fid,['N ' numNodes '\n']);
fprintf(fid,'\n\n');

% Save the airfoil data points
fprintf(fid,['PSAV ' saveFlnmAF '\n']);


% Close file
fclose(fid);
loc = [path name];
% Run XFoil using input file
cmd = [loc ' < xfoil_input.txt'];
[status,result] = system(cmd);





%% My Code
airfoil = readmatrix(saveFlnmAF);
upper = airfoil(airfoil(:,2)>=0,:);
lower = airfoil(airfoil(:,2)<0,:);
x_u = upper(:,1);
y_u = upper(:,2);
x_l = lower(:,1);
y_l = lower(:,2);


x_ref = 0:0.00001:1;

y_u_q = interp1(x_u,y_u,x_ref);
y_l_q = interp1(x_l,y_l,x_ref);

m = max(y_u_q-y_l_q);
cor = y_u_q-y_l_q == m;
X_cor = x_ref(cor);

%% Delete files if they exist again
if (exist(saveFlnmAF,'file'))
    delete(saveFlnmAF);
end
if (exist('xfoil_input.txt','file'))
    delete('xfoil_input.txt');
end

end