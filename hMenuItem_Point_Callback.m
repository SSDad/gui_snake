function hMenuItem_Point_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;

x0 = data_main.x0;
y0 = data_main.y0;
dx = data_main.dx;
dy = data_main.dy;

xi = data_main.Point.xi;
yi = data_main.Point.yi;
ixm = data_main.Point.ixm;

% show on gui
iSlice = round(data_main.hSlider.snake.Value);
data_main.hPlotObj.Point.XData = xi(ixm);
data_main.hPlotObj.Point.YData = yi(iSlice, ixm);

str = data_main.hPopup.Neighbour.String;
idx = data_main.hPopup.Neighbour.Value;
NP = str2num(str{idx});
data_main.Point.NP = NP;
data_main.hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
data_main.hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
data_main.hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
data_main.hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);

% point plot
xx = (1:data_main.nImages)';
yy = mean(yi(:, ixm-NP:ixm+NP), 2);
hPlotObj.PlotPoint.All.XData = xx;
hPlotObj.PlotPoint.All.YData = yy;
hPlotObj.PlotPoint.All.MarkerSize = 16;
hPlotObj.PlotPoint.All.Color = 'c';

hPlotObj.PlotPoint.Current.XData =xx(iSlice);
hPlotObj.PlotPoint.Current.YData = yy(iSlice);
hPlotObj.PlotPoint.Current.MarkerSize = 24;

% 2 line

% tumor plot
data_main.indSS = 1:data_main.nImages;
updateTumorPoints(data_main)
hPlotObj.Tumor.hgPoints.Visible = 'on';

data_main.hToggleButton.Manual.Visible = 'off';

%% save
guidata(hFig_main, data_main);                

set(hFig_main, 'keypressfcn', @fh_kpfcn);

