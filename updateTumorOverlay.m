function updateTumorOverlay(data_main)

hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;
hSlider = data_main.hSlider;

dataPath = data_main.dataPath;
matFile = data_main.matFile;

[~, fn1, ~] = fileparts(matFile);
ffn = fullfile(dataPath, [fn1, '_Tumor.mat']);

if exist(ffn, 'file')
    load(ffn)
else
    [M, N, ~] = size(data_main.hPlotObj.snakeImage.CData);
    contGC = data_main.gatedContour;
    [bwCAll_GC, mask_GC, bwSum_GC, polyA_GC, CC_GC] = fun_getCC(contGC, M, N);

    contTC = data_main.trackContour;
    [bwCAll_TC, mask_TC, bwSum_TC, polyA_TC, CC_TC] = fun_getCC(contTC, M, N);

    nImages = length(contGC);
    save(ffn, 'bwSum_*', 'mask_*', 'polyA_*', 'CC_*', 'M', 'N', 'nImages');
end

% Tumor plot
hPlotObj.Tumor.bwSum.Visible = 'on';

indSS = data_main.indSS;
bwSum = sum(mask_GC(:,:,indSS), 3)+sum(mask_TC(:,:,indSS), 3);
hPlotObj.Tumor.bwSum.CData = bwSum;
hAxis.Tumor.CLim = [min(bwSum(:)) max(bwSum(:))];