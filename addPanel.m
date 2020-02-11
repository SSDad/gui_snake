function [hPanel, hAxis, hPlotObj, hSlider, hText, hToggleButton, hPushButton] = addPanel(hFig)

%% snake
hPanel.snake = uipanel('Parent',                    hFig,...    
                             'Title',                        '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'Position',                  [0, 0, .6, 1.],...
                                    'visible',                      'on', ...
                                'ForegroundColor',       'white',...
                                'BackgroundColor',       'black', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'black');

hAxis.snake = axes('Parent',                   hPanel.snake, ...
                            'color',        'none',...
                            'Units',                    'normalized', ...
                            'HandleVisibility',     'callback', ...
                            'Position',                 [0. 0. 1. 1.]);
hold(hAxis.snake, 'on');

% image
hPlotObj.snakeImage = imshow([], 'parent', hAxis.snake);
    
% contour
hPlotObj.cont = line(hAxis.snake,...
    'XData', [], 'YData', [], 'Color', 'c', 'LineStyle', '-', 'LineWidth', 1);

                            
% point on diaphragm
hPlotObj.Point = line(hAxis.snake,...
    'XData', [], 'YData', [], 'Color', 'r', 'LineStyle', 'none',...
    'Marker', '.', 'MarkerSize', 8);

hSlider.snake = uicontrol('Parent',  hPanel.snake,...
            'Style','slider',...
            'units', 'normalized',...
            'Position',[.01 .1 0.03 0.75],...
            'BackgroundColor', 'b',...
            'ForegroundColor', 'w',...
                'Callback', @hSlider_snake_Callback);
            
hText.nImages = uicontrol('Parent', hPanel.snake, ...
                                'Style', 'text', ...
                                'Units',                     'normalized', ...
                                'Position', [0.01 0.05 0.2, 0.03], ...
                                'FontSize', 16, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', 'b',...
                                'ForegroundColor', 'w',...
                                'String', 'iSlice / nSlices');
                            
hToggleButton.Manual = uicontrol('Parent', hPanel.snake, ...
                                'Style', 'togglebutton', ...
                                'Units',                     'normalized', ...
                                'Position', [0.05 0.9 0.2, 0.03], ...
                                'FontSize', 16, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1 1 1]*0.2,...
                                'ForegroundColor', 'g',...
                                'String', 'ReContour', ...
                                'Visible', 'off',...
                                'Callback', @hToggleButton_Manual_Callback);

hPushButton.DeleteSnake = uicontrol('Parent', hPanel.snake, ...
                                'Style', 'pushbutton', ...
                                'Units',                     'normalized', ...
                                'Position', [0.05 0.9 0.2, 0.03], ...
                                'FontSize', 16, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1 1 1]*0.2,...
                                'ForegroundColor', 'g',...
                                'String', 'Delete Contour', ...
                                'Visible', 'off',...
                                'Callback', @hPushButton_DeleteSnake_Callback);

                            
                            %% point plot                            
hPanel.PlotPoint = uipanel('Parent',                    hFig,...    
                             'Title',                        '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'Position',                  [0.6, 0.7, 0.4, 0.3],...
                                    'visible',                      'on', ...
                                'ForegroundColor',       'white',...
                                'BackgroundColor',       'black', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'black');
                            
    hAxis.PlotPoint = axes('Parent',                   hPanel.PlotPoint, ...
                                'color',        'none',...
                                'xcolor', 'w',...
                                'ycolor', 'w', ...
                                'gridcolor',   'w',...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 [0.1 0.1 0.85 0.85]);

                                
    hold(hAxis.PlotPoint, 'on')
    
    hPlotObj.PlotPoint.All = line(hAxis.PlotPoint, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 12, 'Color', 'c', 'LineStyle', '-');
    hPlotObj.PlotPoint.Current = line(hAxis.PlotPoint, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 16, 'Color', 'r', 'LineStyle', 'none');
    
%% tumor                           
hPanel.Tumor = uipanel('Parent',                    hFig,...    
                             'Title',                        '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'Position',                  [0.6, 0.3, .4, 0.4],...
                                    'visible',                      'on', ...
                                'ForegroundColor',       'white',...
                                'BackgroundColor',       'black', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'black');
                            
    hAxis.Tumor = axes('Parent',                   hPanel.Tumor, ...
                                'color',        'none',...
                                'xcolor', 'w',...
                                'ycolor', 'w', ...
                                'gridcolor',   'w',...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 [0.1 0.1 0.85 0.85]);

                                
    hold(hAxis.Tumor, 'on')
    
% image
hPlotObj.Tumor.bwSum = imshow([], 'parent', hAxis.Tumor);

%% profile plot                            
hPanel.Profile = uipanel('Parent',                    hFig,...    
                             'Title',                        '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'Position',                  [0.6, 0., 0.4, 0.3],...
                                    'visible',                      'on', ...
                                'ForegroundColor',       'white',...
                                'BackgroundColor',       'black', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'black');
                            
    hAxis.Profile = axes('Parent',                   hPanel.Profile, ...
                                'color',        'none',...
                                'xcolor', 'w',...
                                'ycolor', 'w', ...
                                'gridcolor',   'w',...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 [0.1 0.1 0.85 0.85]);

                                
    hold(hAxis.Profile, 'on')
    
    hPlotObj.Profile.Profile = line(hAxis.Profile, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 12, 'Color', 'c', 'LineStyle', 'none');
    hPlotObj.Profile.L1 = line(hAxis.Profile, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 16, 'Color', 'r', 'LineStyle', 'none');

