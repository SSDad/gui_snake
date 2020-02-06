function hMenuItem_Point_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;

iSlice = round(data_main.hSlider.snake.Value);
C = data_main.cont{iSlice};

I = data_main.hPlotObj.snakeImage.CData;
[M, N, ~] = size(I);

x = N/2;
xx = C(:, 2);
yy = C(:, 1);

[~, ind] = sort(abs(xx - x));
px4 = xx(ind(1:4));
py4 = yy(ind(1:4));

[~, idx] = max(py4);

data_main.hPlotObj.Point.XData = px4(idx);
data_main.hPlotObj.Point.YData = py4(idx);

data_main.hPlotObj.Point.Color = 'g';
data_main.hPlotObj.Point.Marker = '.';
data_main.hPlotObj.Point.MarkerSize = 24;

ip = ind(idx);
% find x increase
xn = circshift(xx, -ip+1);
if xn(10) > x(1)
    direction = 1;
else
    direction = -1;
end

data_main.Point.idx = ip;
data_main.Point.direction = direction;
data_main.Point.iSlice = iSlice;

data_main.hToggleButton.Manual.Visible = 'off';
data_main.hSlider.snake.Visible = 'off';

% set(hFig_main, 'CurrentAxes', data_main.hAxis.snake)
% figure(hFig_main);
set(hFig_main, 'keypressfcn', @fh_kpfcn);

%% save
guidata(hFig_main, data_main);                