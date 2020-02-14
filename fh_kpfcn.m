function [] = fh_kpfcn(H, E)          

data_main = guidata(H);
xm = data_main.Point.xm;
NP = data_main.Point.NP;
yMean = data_main.Point.yMean;
xxn = data_main.Point.xxn;
yyn = data_main.Point.yyn;
dx = data_main.dx;

% x0 = data_main.x0;
% y0 = data_main.y0;
% dx = data_main.dx;
% dy = data_main.dy;
% 
% % idx = data_main.Point.idx;
% iSlice = data_main.Point.iSlice;
% C = data_main.cont{iSlice};
% 
% % convert to xy
% C(:, 1) = (C(:, 1)-1)*dx+x0;
% C(:, 2) = (C(:, 2)-1)*dy+y0;
% 
% xx = C(:, 1);
% yy = C(:, 2);

% direction = data_main.Point.direction;
% nidx = idx;

switch E.Key
    case 'rightarrow'
        xm = xm+1;
    case 'leftarrow'
        xm = xm-1;
    case 'return'
        data_main.hPlotObj.Point.Color = 'r';
        set(H, 'keypressfcn', '');
    otherwise  
end

data_main.Point.xm = xm;

% update
x1 = [xm xm];
y1 = [yMean+10 1e4];

[xm, ym] = polyxpoly(x1, y1, xxn, yyn);

xL = xm-(1:NP)*dx;
xR = xm+(1:NP)*dx;
for n = 1:NP
    x1 = [xL(n) xL(n)];
    [~, yL(n)] = polyxpoly(x1, y1, xxn, yyn);

    x1 = [xR(n) xR(n)];
    [~, yR(n)] = polyxpoly(x1, y1, xxn, yyn);
end

% show on gui
data_main.hPlotObj.Point.XData = xm;
data_main.hPlotObj.Point.YData = ym;
data_main.hPlotObj.LeftPoints.XData = xL;
data_main.hPlotObj.LeftPoints.YData = yL;
data_main.hPlotObj.RightPoints.XData = xR;
data_main.hPlotObj.RightPoints.YData = yR;

guidata(H, data_main);
