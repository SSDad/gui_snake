function updateTumorPoints(data_main)

hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;

hPlotObj.Tumor.hgPoints.Visible = 'on';

allP = data_main.Point.AllPoint;
indSS = data_main.indSS;

for n = 1:data_main.nImages
    hPlotObj.Tumor.Points(n).XData = [];
    hPlotObj.Tumor.Points(n).YData = [];
end

for n = 1:length(indSS)
    hPlotObj.Tumor.Points(n).XData = allP(indSS(n), 1);
    hPlotObj.Tumor.Points(n).YData = allP(indSS(n), 2);
end
