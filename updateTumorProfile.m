function updateTumorProfile(data_main)

hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;
hPL = hPlotObj.Profile.PL;

bwSum = hPlotObj.Tumor.bwSum.CData;
pos = hPL.Position; 

prof = improfile(bwSum, pos(:, 1), pos(:, 2));

hPlotObj.Profile.Profile.XData = 1:length(prof);
hPlotObj.Profile.Profile.YData = prof;
