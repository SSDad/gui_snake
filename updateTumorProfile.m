function updateTumorProfile(data_main)

hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;
hPL = hPlotObj.Profile.PL;

bwSum = hPlotObj.Tumor.bwSum.CData;
pos = hPL.Position; 

prof = improfile(bwSum, pos(:, 1), pos(:, 2));

% line
hPlotObj.Profile.Profile.XData = 1:length(prof);
hPlotObj.Profile.Profile.YData = prof;

% patches
maxV = max(prof);

xL2 = find(prof == maxV, 1, 'first');
if prof(1) == 0
    xL1 = find(prof(1:xL2) == 0, 1, 'last');
else
    xL1 = 1;
end
hPlotObj.Profile.Patch1.XData = [xL1 xL2 xL2 xL1];
hPlotObj.Profile.Patch1.YData = [0 0 maxV maxV];
hPlotObj.Profile.Text1.Position = [xL1+2 maxV 0];
hPlotObj.Profile.Text1.String = num2str(xL2-xL1);

xR1 = find(prof == maxV, 1, 'last');
if prof(end) == 0
    junk = find(prof(xR1:end) == 0, 1, 'first');
    xR2 = junk+xR1-1;
else
    xR2 = length(prof);
end
hPlotObj.Profile.Patch2.XData = [xR1 xR2 xR2 xR1];
hPlotObj.Profile.Patch2.YData = [0 0 maxV maxV];
hPlotObj.Profile.Text2.Position = [xR2-4 maxV 0];
hPlotObj.Profile.Text2.String = num2str(xR2-xR1);