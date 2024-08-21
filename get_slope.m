function coefficients = get_slope(filename,path_w)

table1 = readmatrix([path_w,filename]);
j = isnan(table1);
jj = logical(sum(j,2));

y = table1(:,1);
x = table1(:,2);
if max(x)>max(y)
   x = table1(:,1);
   y = table1(:,2);
end
y(jj) = [];
x(jj) = [];
% Get coefficients of a line fit through the data.
coefficients = polyfit(x, y, 1);
end
