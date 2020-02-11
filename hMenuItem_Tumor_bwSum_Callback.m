function hMenuItem_Tumor_bwSum_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;
hSlider = data_main.hSlider;

if strcmp(data_main.hMenuItem.Tumor.bwSum.Checked, 'off')
    data_main.hMenuItem.Tumor.bwSum.Checked = 'on';

    dataPath = data_main.dataPath;
    matFile = data_main.matFile;

    [~, fn1, ~] = fileparts(matFile);
    ffn = fullfile(dataPath, [fn1, '_Tumor.mat']);

    if exist(ffn, 'file')
        load(ffn)
    else
        [M, N, ~] = size(data_main.hPlotObj.snakeImage.CData);
        contGC = data_main.gatedContour;
        [bwCAll_GC, bwSum_GC, polyA_GC, CC_GC] = fun_getCC(contGC, M, N);
        
        contTC = data_main.trackContour;
        [bwCAll_TC, bwSum_TC, polyA_TC, CC_TC] = fun_getCC(contTC, M, N);
        
        nImages = length(contGC);
        save(ffn, 'bwSum_*', 'polyA_*', 'CC_*', 'M', 'N', 'nImages');
    end

    % Tumor plot
    hPlotObj.Tumor.bwSum.Visible = 'on';
    bwSum = bwSum_GC+bwSum_TC;
    hPlotObj.Tumor.bwSum.CData = bwSum;
    hAxis.Tumor.CLim = [min(bwSum(:)) max(bwSum(:))];
    linkaxes([hAxis.snake, hAxis.Tumor])
else
    data_main.hMenuItem.Tumor.bwSum.Checked = 'off';
    hPlotObj.Tumor.bwSum.Visible = 'off';
end

%% save
% guidata(hFig_main, data_main);                