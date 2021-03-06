function initTumorPanel(hFig_main)

data_main = guidata(hFig_main);
hPanel = data_main.hPanel;
hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;

hAxis.Tumor = axes('Parent',                   hPanel.Tumor, ...
                            'color',        'none',...
                            'xcolor', 'w',...
                            'ycolor', 'w', ...
                            'gridcolor',   'w',...
                            'Units',                    'normalized', ...
                            'HandleVisibility',     'callback', ...
                            'Position',                 [0.1 0.1 0.85 0.85]);


hold(hAxis.Tumor, 'on')

% tumor contour with 1x1 pixel size
[mask_GC, mask_TC, CC_GC, CC_TC, CC_RC] = getTumorContour(hFig_main);

% binary image
bwSum = sum(mask_GC, 3)+sum(mask_TC, 3);
hPlotObj.Tumor.bwSum = imshow(bwSum, data_main.RA, 'parent', hAxis.Tumor);
if any(bwSum(:))
    hAxis.Tumor.CLim = [min(bwSum(:)) max(bwSum(:))];
end
% linkaxes([hAxis.snake hAxis.Tumor]);

data_main.Tumor.mask_GC = mask_GC;
data_main.Tumor.mask_TC = mask_TC;
data_main.Tumor.CC_GC = CC_GC;
data_main.Tumor.CC_TC = CC_TC;
data_main.Tumor.RC_TC = CC_RC;

data_main.hMenuItem.Tumor.bwSum.Checked = 'on';

% contour
hPlotObj.Tumor.hgTrackContour = hggroup(hAxis.Tumor);
hPlotObj.Tumor.hgGatedContour = hggroup(hAxis.Tumor);
hPlotObj.Tumor.hgPoints = hggroup(hAxis.Tumor);
for n = 1:data_main.nImages
    hPlotObj.Tumor.TrackContour(n) = line(hPlotObj.Tumor.hgTrackContour, ...
        'XData',  [], 'YData',  [],  'Color', 'b', 'LineStyle', '-', 'LineWidth', 1);
    if ~isempty(CC_TC{n})
        hPlotObj.Tumor.TrackContour(n).XData = CC_TC{n}(:, 1);
        hPlotObj.Tumor.TrackContour(n).YData = CC_TC{n}(:, 2);
    end
    
    hPlotObj.Tumor.GatedContour(n) = line(hPlotObj.Tumor.hgGatedContour, ...
        'XData', [], 'YData', [],  'Color', 'g', 'LineStyle', '-', 'LineWidth', 1);
    if ~isempty(CC_GC{n})
        hPlotObj.Tumor.GatedContour(n).XData = CC_GC{n}(:, 1);
        hPlotObj.Tumor.GatedContour(n).YData = CC_GC{n}(:, 2);
    end
    
    hPlotObj.Tumor.Points(n) = line(hPlotObj.Tumor.hgPoints, 'XData', [], 'YData', [],...
        'Marker', '.',  'MarkerSize', 12, 'Color', 'r', 'LineStyle', 'none');
end

n = 1;
hPlotObj.Tumor.RefContour(n) = line(hAxis.Tumor, ...
    'XData', [], 'YData', [],  'Color', 'r', 'LineStyle', '-', 'LineWidth', 1);
if ~isempty(CC_RC{n})
    hPlotObj.Tumor.RefContour(n).XData = CC_RC{n}(:, 1);
    hPlotObj.Tumor.RefContour(n).YData = CC_RC{n}(:, 2);
end


%
% 
% for n = 1:data_main.nImages
%     if ~isempty(CC_GC{n})
%         hPlotObj.Tumor.GatedContour(n).XData = CC_GC{n}(:, 2);
%         hPlotObj.Tumor.GatedContour(n).YData = CC_GC{n}(:, 1);
%     end
%     if ~isempty(CC_TC{n})
%         hPlotObj.Tumor.TrackContour(n).XData = CC_TC{n}(:, 2);
%         hPlotObj.Tumor.TrackContour(n).YData = CC_TC{n}(:, 1);
%     end
% end

data_main.hMenuItem.Tumor.TrackContour.Checked = 'on';

% % turn on
% hPlotObj.Tumor.bwSum.Visible = 'on';

%% save data
data_main.hAxis = hAxis;
data_main.hPlotObj = hPlotObj;
guidata(hFig_main, data_main);