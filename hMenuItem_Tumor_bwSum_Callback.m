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
        cont = data_main.gatedContour;
        [bwCAll, bwSum, polyA, CC] = fun_getCC(cont, M, N);
        nImages = length(cont);
        save(ffn, 'bwSum', 'polyA', 'CC', 'M', 'N', 'nImages');
    end

    % Tumor plot
    hPlotObj.Tumor.bwSum.Visible = 'on';
    hPlotObj.Tumor.bwSum.CData = bwSum;
    linkaxes([hAxis.snake, hAxis.Tumor])
else
    data_main.hMenuItem.Tumor.bwSum.Checked = 'off';
    hPlotObj.Tumor.bwSum.Visible = 'off';
end

%% save
% guidata(hFig_main, data_main);                