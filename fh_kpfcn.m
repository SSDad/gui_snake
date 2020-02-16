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

xx = (1:data_main.nImages)';
data_main.Point.AllPoint = [xx yy];

% 2 line update
data_main.PlotObj.hUL.Position = [1 max(yy); data_main.nImages max(yy)];
data_main.PlotObj.hLL.Position = [1 min(yy); data_main.nImages min(yy)];
data_main.LinePos.y1 = min(yy);
data_main.LinePos.y2 = max(yy);

    y1 =data_main.LinePos.y1;
    y2 = data_main.LinePos.y2;
    hPlotObj.PlotPoint.Text.UL.Position(2) = y2;
    hPlotObj.PlotPoint.Text.UL.String =num2str(y2, '%4.1f');
    hPlotObj.PlotPoint.Text.LL.Position(2) = y1;
    hPlotObj.PlotPoint.Text.LL.String =num2str(y1, '%4.1f');
    hPlotObj.PlotPoint.Text.Gap.Position(2) = (y2+y1)/2;
    hPlotObj.PlotPoint.Text.Gap.String =num2str(y2-y1, '%4.1f');

data_main.Point.ixm = ixm;

% on tumor points
updateTumorPoints(data_main)


guidata(H, data_main);
