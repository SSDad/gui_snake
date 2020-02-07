function hMenuItem_Tumor_TrackContour_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;
hSlider = data_main.hSlider;

%% 
if strcmp(data_main.hMenuItem.Tumor.TrackContour.Checked, 'off')
    data_main.hMenuItem.Tumor.TrackContour.Checked = 'on';
    hPlotObj.Tumor.hgTrackContour.Visible = 'on';
    
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
    for n = 1:nImages
        if ~isempty(CC{n})
            hPlotObj.Tumor.TrackContour(n).XData = CC{n}(:, 2);
            hPlotObj.Tumor.TrackContour(n).YData = CC{n}(:, 1);
        end
    end
    linkaxes([hAxis.snake, hAxis.Tumor])
else
    data_main.hMenuItem.Tumor.TrackContour.Checked = 'off';
    hPlotObj.Tumor.hgTrackContour.Visible = 'off';
end    
    
%% save
% guidata(hFig_main, data_main);                