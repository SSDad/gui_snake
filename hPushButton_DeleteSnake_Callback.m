function hPushButton_DeleteSnake_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

iSlice = round(data_main.hSlider.snake.Value);

data_main.hPlotObj.cont.XData = [];
data_main.hPlotObj.cont.YData = [];
data_main.cont{iSlice} = [];

data_main.hPlotObj.Point.XData = [];
data_main.hPlotObj.Point.YData = [];
data_main.Point.AllPoint(iSlice, :) = [nan nan];

data_main.hPlotObj.PlotPoint.All.YData = data_main.Point.AllPoint(:, 2);
data_main.hPlotObj.PlotPoint.Current.YData = nan;

guidata(hFig_main, data_main);