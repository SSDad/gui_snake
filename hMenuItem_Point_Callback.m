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

% turn off mask contour
hPlotObj.maskCont.Visible = 'off';

% show on gui
iSlice = round(data_main.hSlider.snake.Value);
str = data_main.hPopup.Neighbour.String;
idx = data_main.hPopup.Neighbour.Value;
NP = str2num(str{idx});
data_main.Point.NP = NP;

if ~isempty(data_main.cont{iSlice})
    hPlotObj.Point.XData = xi(ixm);
    hPlotObj.Point.YData = yi(iSlice, ixm);
    hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
    hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
    hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
    hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);
end
% point plot
xx = (1:data_main.nImages)';
if isempty(data_main.cont{iSlice})
    xx(iSlice) = nan;
end
yy = mean(yi(:, ixm-NP:ixm+NP), 2);
hPlotObj.PlotPoint.All.XData = xx;
hPlotObj.PlotPoint.All.YData = yy;
hPlotObj.PlotPoint.All.MarkerSize = 16;
hPlotObj.PlotPoint.All.Color = 'c';

hPlotObj.PlotPoint.Current.XData =xx(iSlice);
hPlotObj.PlotPoint.Current.YData = yy(iSlice);
hPlotObj.PlotPoint.Current.MarkerSize = 24;

allP = [xx yy];
data_main.Point.AllPoint = allP;

% 2 line
% [x1 y1
%  x2 y2]
Lim(1,1) = 1;
Lim(2,1) = size(allP,1);
Lim(1,2) = min(allP(:, 2));
Lim(2,2) = max(allP(:, 2));

posUL = Lim;
posUL(1, 2) = posUL(2, 2);
posLL = Lim;
posLL(2, 2) = posLL(1, 2);

hA = data_main.hAxis.PlotPoint;
if data_main.LineDone
    hPlotObj.UL.Position = posUL;
    hPlotObj.LL.Position = posLL;
else
    hPlotObj.UL = images.roi.Line(hA, 'InteractionsAllowed', 'translate', ...
        'Position', posUL, 'Tag', 'UL');

    hPlotObj.LL = images.roi.Line(hA, 'InteractionsAllowed', 'translate', ...
        'Color', 'g', 'Position', posLL, 'Tag', 'LL');

    addlistener(hPlotObj.UL, 'MovingROI', @hUL_callback);
    addlistener(hPlotObj.LL, 'MovingROI', @hUL_callback);

    data_main.LineDone = true;

    junk = data_main.nImages+3;
    hPlotObj.PlotPoint.Text.UL = text(hA, junk, 0, '', 'Color', 'w', 'FontSize', 12);
    hPlotObj.PlotPoint.Text.LL = text(hA, junk, 0, '', 'Color', 'w', 'FontSize', 12);
    hPlotObj.PlotPoint.Text.Gap = text(hA, junk, 0, '', 'Color', 'w', 'FontSize', 12);
end

% line position text
    hPlotObj.PlotPoint.Text.UL.Position(2) =posUL(2,2);
    hPlotObj.PlotPoint.Text.UL.String = num2str(posUL(2,2), '%4.1f');
    
    hPlotObj.PlotPoint.Text.LL.Position(2) = posLL(2,2);
    hPlotObj.PlotPoint.Text.LL.String = num2str(posLL(2,2), '%4.1f');
    
    hPlotObj.PlotPoint.Text.Gap.Position(2) = (posUL(2,2)+posLL(2,2))/2;
    hPlotObj.PlotPoint.Text.Gap.String = num2str(posUL(2,2)-posLL(2,2), '%4.1f');

data_main.LinePos.y1 = Lim(1, 2);
data_main.LinePos.y2 = Lim(2, 2);

% tumor plot
data_main.indSS = 1:data_main.nImages;
updateTumorPoints(data_main)
hPlotObj.Tumor.hgPoints.Visible = 'on';

data_main.hMenuItem.Tumor.Points.Enable = 'on';
data_main.hMenuItem.Tumor.Points.Checked = 'on';

data_main.hPlotObj = hPlotObj;

data_main.hToggleButton.Manual.Visible = 'off';

%% save
guidata(hFig_main, data_main);                

set(hFig_main, 'keypressfcn', @fh_kpfcn);

