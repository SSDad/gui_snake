function hMenuItem_Tumor_bwSum_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;

if strcmp(data_main.hMenuItem.Tumor.bwSum.Checked, 'off')
    data_main.hMenuItem.Tumor.bwSum.Checked = 'on';
    updateTumorOverlay(data_main);
    linkaxes([hAxis.snake, hAxis.Tumor])
else
    data_main.hMenuItem.Tumor.bwSum.Checked = 'off';
    hPlotObj.Tumor.bwSum.Visible = 'off';
end

%% save
% guidata(hFig_main, data_main);                