function hMenuItem_PointPreProcess_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;

x0 = data_main.x0;
y0 = data_main.y0;
dx = data_main.dx;
dy = data_main.dy;
mI = data_main.mI;
nI = data_main.nI;
nImages = data_main.nImages;

xi = x0:dx:x0+dx*(nI-1);
yi = nan(nImages, nI);

hWB = waitbar(0, 'Finding points on Diaphragm...');

for iSlice = 1:nImages
    C = data_main.cont{iSlice};
    xx = (C(:, 1)-1)*dx+x0;
    yy = (C(:, 2)-1)*dy+y0;
    yMean = mean(yy);
    ind = find(yy>yMean);
    yyh = yy(ind);
    xxh = xx(ind);

    xm(iSlice) = mean(xxh);

    n1 = ceil((min(xxh)-x0)/dx);
    n2 = floor((max(xxh)-x0)/dx);
    
    for n = n1:n2
        x1 = [xi(n) xi(n)];
        y1 = [yMean+10 1e4];
        [~, yc] = polyxpoly(x1, y1, xxh, yyh);
        if length(yc)>1
            yi(iSlice, n) = max(yc);
        elseif length(yc)==1
            yi(iSlice, n) = yc;
        end
    end
    waitbar(iSlice/nImages, hWB, 'Finding points on Diaphragm...');
end
waitbar(1, hWB, 'Bingo!');
pause(2);
close(hWB);

[~, ixm] = min(abs(xi-mean(xm)));
data_main.Point.xi = xi;
data_main.Point.yi = yi;
data_main.Point.ixm = ixm;

%% save
guidata(hFig_main, data_main);                