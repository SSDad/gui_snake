function hMenuItem_Tumor_Points_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;
hSlider = data_main.hSlider;

%% 
if strcmp(data_main.hMenuItem.Tumor.Points.Checked, 'off')
    data_main.hMenuItem.Tumor.Points.Checked = 'on';
    hPlotObj.Tumor.hgPoints.Visible = 'on';

    allP = data_main.Point.AllPoint;
    for n = 1:data_main.nImages
        hPlotObj.Tumor.Points(n).XData = allP(n, 1);
        hPlotObj.Tumor.Points(n).YData = allP(n, 2);
    end
else
    data_main.hMenuItem.Tumor.Points.Checked = 'off';
    hPlotObj.Tumor.hgPoints.Visible = 'off';
end
%% save
% guidata(hFig_main, data_main);                