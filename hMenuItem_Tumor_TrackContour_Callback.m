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
    hPlotObj.Tumor.hgGatedContour.Visible = 'on';
    
    dataPath = data_main.dataPath;
    matFile = data_main.matFile;

    [~, fn1, ~] = fileparts(matFile);
    ffn = fullfile(dataPath, [fn1, '_Tumor.mat']);

    if exist(ffn, 'file')
        load(ffn)
%     else
%         [M, N, ~] = size(data_main.hPlotObj.snakeImage.CData);
%         cont = data_main.gatedContour;
%         [bwCAll, bwSum, polyA, CC] = fun_getCC(cont, M, N);
%         nImages = length(cont);
%         save(ffn, 'bwSum', 'polyA', 'CC', 'M', 'N', 'nImages');
    end

    % Tumor plot
    for n = 1:nImages
        if ~isempty(CC_GC{n})
            hPlotObj.Tumor.GatedContour(n).XData = CC_GC{n}(:, 2);
            hPlotObj.Tumor.GatedContour(n).YData = CC_GC{n}(:, 1);
        end
        if ~isempty(CC_TC{n})
            hPlotObj.Tumor.TrackContour(n).XData = CC_TC{n}(:, 2);
            hPlotObj.Tumor.TrackContour(n).YData = CC_TC{n}(:, 1);
        end
    end
    linkaxes([hAxis.snake, hAxis.Tumor])
else
    data_main.hMenuItem.Tumor.TrackContour.Checked = 'off';
    hPlotObj.Tumor.hgTrackContour.Visible = 'off';
    hPlotObj.Tumor.hgGatedContour.Visible = 'off';
end    
    
%% save
% guidata(hFig_main, data_main);                