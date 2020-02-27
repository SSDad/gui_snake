function hMenuItem_Help_About_Callback(src, evnt)

hF = figure('MenuBar',            'none', ...
                    'Toolbar',              'none', ...
                    'HandleVisibility',  'callback', ...
                    'Name',                'About', ...
                    'NumberTitle',      'off', ...
                    'Units',                 'normalized',...
                    'Position',             [0.35 0.4 0.3 0.1],...
                    'Color',                 'black', ...
                    'Visible',               'on');
% hA = axes('parent', hF);


hText = uicontrol('Parent', hF, ...
                                'Style', 'text', ...
                                'Units',                     'normalized', ...
                                'Position', [0.1 0.7 0.8, 0.2], ...
                                'FontSize', 16, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1 1 1]*0,...
                                'ForegroundColor', 'c',...
                                'String', 'MAXIM v3.0 - 2020.02.27');

hText = uicontrol('Parent', hF, ...
                                'Style', 'text', ...
                                'Units',                     'normalized', ...
                                'Position', [0.1 0.3 0.8, 0.2], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1 1 1]*0,...
                                'ForegroundColor', 'c',...
                                'String', 'Zhen Ji & Taeho Kim ');
                            
hText = uicontrol('Parent', hF, ...
                                'Style', 'text', ...
                                'Units',                     'normalized', ...
                                'Position', [0. 0.1 1, 0.2], ...
                                'FontSize', 12, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', [1 1 1]*0,...
                                'ForegroundColor', 'c',...
                                'String', 'Department of Radiation Oncology, Washington University in St. Louis');                            