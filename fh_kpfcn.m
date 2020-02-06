function [] = fh_kpfcn(H, E)          

data_main = guidata(H);
idx = data_main.Point.idx;
iSlice = data_main.Point.iSlice;
C = data_main.cont{iSlice};
xx = C(:, 1);
yy = C(:, 2);
direction = data_main.Point.direction;
nidx = idx;

switch E.Key
    case 'rightarrow'
        nidx = idx+direction;
    case 'leftarrow'
        nidx = idx-direction;

    case 'return'
        data_main.hPlotObj.Point.Color = 'r';
        set(H, 'keypressfcn', '');
    otherwise  
end

if nidx == 0
    nidx = length(xx);
elseif nidx > length(xx)
    nidx = 1;
end

x = C(nidx, 2);
y = C(nidx, 1);
data_main.hPlotObj.Point.XData = x;
data_main.hPlotObj.Point.YData = y;
data_main.Point.idx = nidx;
data_main.Point.x = x;
data_main.Point.y = y;

guidata(H, data_main);
