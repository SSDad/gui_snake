clearvars
load('junk')
% refC = data_main.refContour;

hF = figure(99); clf
hA1 = subplot(221, 'parent', hF);

xx = C(:, 1);
yy = C(:,2);

% order
P = round(size(C, 1)/2);
[xx, yy]=fun_points2contour(xx, yy, P, 'ccw');

hL = line(xx, yy, 'LineStyle', '-', 'Marker', 'o');
axis equal ij
hold on

% rotate cw 90

xr = yy;
yr = xx;
hA2 = subplot(222, 'parent', hF);
plot(xr, yr)
axis equal ij

xr = 466-xr+1;
hA3 = subplot(223, 'parent', hF);
plot(xr, yr)
axis equal ij


% 
% % k = convhull(C);
% % 
% % hold on
% % plot(C(k,1), C(k,2))
% 
% 
% plot(Xout, Yout)