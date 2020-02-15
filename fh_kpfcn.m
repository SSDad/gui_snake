function [] = fh_kpfcn(H, E)          

data_main = guidata(H);
hPlotObj = data_main.hPlotObj;

ixm = data_main.Point.ixm;
xi = data_main.Point.xi;
yi = data_main.Point.yi;
NP = data_main.Point.NP;

switch E.Key
    case 'rightarrow'
        ixm = ixm+1;
    case 'leftarrow'
        ixm = ixm-1;
%     case 'return'
%         hPlotObj.Point.Color = 'r';
%         set(H, 'keypressfcn', '');
    otherwise  
end

% update

% on image
iSlice = round(data_main.hSlider.snake.Value);
hPlotObj.Point.XData = xi(ixm);
hPlotObj.Point.YData = yi(iSlice, ixm);

hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);

% on point plot
yy = mean(yi(:, ixm-NP:ixm+NP), 2);
hPlotObj.PlotPoint.All.YData = yy;
hPlotObj.PlotPoint.Current.XData = iSlice;
hPlotObj.PlotPoint.Current.YData = yy(iSlice);

data_main.Point.ixm = ixm;

% on tumor points
updateTumorPoints(data_main)


guidata(H, data_main);
