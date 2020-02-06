function hMenuItem_PlotPoint_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;

I = data_main.hPlotObj.snakeImage.CData;
x = data_main.Point.x;

for n = 1:data_main.nImages
    C = data_main.cont{n};
    xx = C(:, 2);
    yy = C(:, 1);

    [~, ind] = sort(abs(xx - x));
    px4 = xx(ind(1:4));
    py4 = yy(ind(1:4));

    [~, idx] = max(py4);
    ip = ind(idx);

    allP(n, :) = [xx(ip) yy(ip)];
end

data_main.Point.AllPoint = allP;
hPlotObj.PlotPoint.All.XData = 1:data_main.nImages;
hPlotObj.PlotPoint.All.YData = allP(:,2);
hPlotObj.PlotPoint.All.MarkerSize = 16;
hPlotObj.PlotPoint.All.Color = 'g';

hPlotObj.PlotPoint.Current.XData = data_main.Point.iSlice;
hPlotObj.PlotPoint.Current.YData = allP(data_main.Point.iSlice, 2);
hPlotObj.PlotPoint.Current.MarkerSize = 24;

data_main.AllPointDone = true;
data_main.hSlider.snake.Visible = 'on';
data_main.hMenuItem.SavePoints.Enable = 'on';

%% save
guidata(hFig_main, data_main);                