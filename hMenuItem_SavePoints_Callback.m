function hMenuItem_SavePoints_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

dataPath = data_main.dataPath;
matFile = data_main.matFile;

 [~, fn1, ~] = fileparts(matFile);
 ffn = fullfile(dataPath, [fn1, '_points.mat']);
 
 points = data_main.Point.AllPoint;
 
 save(ffn, 'points');
 
% turn off 'Delete Contour' button 
data_main.hPushButton.DeleteSnake.Visible = 'off';
data_main.hMenuItem.DeletePoint.Checked = 'off';

% initialize horizontal 2 lines on PointsPlot
% [x1 y1
%  x2 y2]
Lim(1,1) = 1;
Lim(2,1) = size(points,1);
Lim(1,2) = min(points(:, 2));
Lim(2,2) = max(points(:, 2));

hA = data_main.hAxis.PlotPoint;

pos = Lim;
pos(1, 2) = pos(2, 2);
hUL = images.roi.Line(hA, 'InteractionsAllowed', 'translate', ...
    'Position', pos , 'Tag', 'UL');

pos = Lim;
pos(2, 2) = pos(1, 2);
hLL = images.roi.Line(hA, 'InteractionsAllowed', 'translate', ...
    'Color', 'c', 'Position', pos , 'Tag', 'LL');

addlistener(hUL, 'MovingROI', @hUL_callback);
addlistener(hLL, 'MovingROI', @hUL_callback);

data_main.LinePos.y1 = Lim(1, 2);
data_main.LinePos.y2 = Lim(2, 2);

guidata(hFig_main, data_main);
