function updateTrackContour(data_main)

hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;

hPlotObj.Tumor.hgTrackContour.Visible = 'on';
hPlotObj.Tumor.hgGatedContour.Visible = 'on';

dataPath = data_main.dataPath;
matFile = data_main.matFile;
[~, fn1, ~] = fileparts(matFile);
ffn = fullfile(dataPath, [fn1, '_Tumor.mat']);
load(ffn)

% Contour plot

indSS = data_main.indSS;

for n = 1:nImages
    hPlotObj.Tumor.GatedContour(n).Visible = 'off';
    hPlotObj.Tumor.TrackContour(n).Visible = 'off';
end

for iSS = 1:length(indSS)
    n = indSS(iSS);
    if ~isempty(CC_GC{n})
        hPlotObj.Tumor.GatedContour(n).Visible = 'on';
    end
    if ~isempty(CC_TC{n})
        hPlotObj.Tumor.TrackContour(n).Visible = 'on';
    end
end
