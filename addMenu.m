function [hMenu, hMenuItem] = addMenu(hFig_main)

%% File
hMenu.File = uimenu('Parent',                 hFig_main,...
                    'HandleVisibility',      'off', ...
                    'Label',                     'File');

hMenuItem.ImageInfo  =   uimenu('Parent',               hMenu.File,...
                                'Label',                'Image Info',...
                                    'Checked',           'on',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_ImageInfo_Callback);
                
hMenuItem.LoadImages  =   uimenu('Parent',               hMenu.File,...
                                'Label',                'Load Images',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_LoadImages_Callback);
                            
hMenuItem.LoadSnakes  =   uimenu('Parent',               hMenu.File,...
                                'Label',                'Load Snakes',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_LoadSnakes_Callback);
                            
hMenuItem.SaveSnakes  =   uimenu('Parent',               hMenu.File,...
                                'Label',                'Save Snakes',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_SaveSnakes_Callback);

%% snake
hMenu.snake = uimenu('Parent',                 hFig_main,...
                    'HandleVisibility',      'off', ...
                    'Label',                     'Snake');
                                            
hMenuItem.FreeHand  =   uimenu('Parent',               hMenu.snake,...
                                'Label',                'Free Hand',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_FreeHand_Callback);
                            
hMenuItem.Slither  =   uimenu('Parent',               hMenu.snake,...
                                'Label',                'On/Off Slither',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_Slither_Callback);
                            
hMenuItem.ReContour  =   uimenu('Parent',               hMenu.snake,...
                                'Label',                'On/Off reContour',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_ReContour_Callback);
                            
%% Point                            
hMenu.Point = uimenu('Parent',                 hFig_main,...
                    'HandleVisibility',      'off', ...
                    'Label',                     'Points');
                                            
hMenuItem.PointPreProcess  =   uimenu('Parent',               hMenu.Point,...
                                'Label',                'preProcess',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_PointPreProcess_Callback);

hMenuItem.PointParam  =   uimenu('Parent',               hMenu.Point,...
                                'Label',                'On/Off - Neighbour Points',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_PointParam_Callback);

hMenuItem.Point  =   uimenu('Parent',               hMenu.Point,...
                                'Label',                'Points on Diaphragm',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_Point_Callback);
                            
% hMenuItem.PlotPoint  =   uimenu('Parent',               hMenu.Point,...
%                                 'Label',                'Points Plot',...
%                                     'Checked',           'off',...
%                                     'Enable',               'on', ...
%                                     'Separator',          'on', ...
%                                 'HandleVisibility', 'callback', ...
%                                 'Callback',            @hMenuItem_PlotPoint_Callback);
                            
hMenuItem.DeletePoint  =   uimenu('Parent',               hMenu.Point,...
                                'Label',                'On/Off Delete Contour',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_DeletePoint_Callback);

% hMenuItem.SavePoints  =   uimenu('Parent',               hMenu.Point,...
%                                 'Label',                'Save Points',...
%                                     'Checked',           'off',...
%                                     'Enable',               'off', ...
%                                     'Separator',          'on', ...
%                                 'HandleVisibility', 'callback', ...
%                                 'Callback',            @hMenuItem_SavePoints_Callback);
                            
%% Tumor                            
hMenu.Tumor = uimenu('Parent',                 hFig_main,...
                    'HandleVisibility',      'off', ...
                    'Label',                     'Tumor');
                                            
hMenuItem.Tumor.bwSum  =   uimenu('Parent',               hMenu.Tumor,...
                                'Label',                'Tumor Overlay',...
                                    'Checked',           'off',...
                                    'Enable',               'off', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_Tumor_bwSum_Callback);
                            
hMenuItem.Tumor.TrackContour  =   uimenu('Parent',               hMenu.Tumor,...
                                'Label',                'Contour Overlay',...
                                    'Checked',           'off',...
                                    'Enable',               'off', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_Tumor_TrackContour_Callback);
                            
hMenuItem.Tumor.Points  =   uimenu('Parent',               hMenu.Tumor,...
                                'Label',                'Diaphragm Points',...
                                    'Checked',           'off',...
                                    'Enable',               'off', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_Tumor_Points_Callback);

hMenuItem.Tumor.Profile  =   uimenu('Parent',               hMenu.Tumor,...
                                'Label',                'Profile',...
                                    'Checked',           'off',...
                                    'Enable',               'off', ...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_Tumor_Profile_Callback);
                            
%% Help                            
hMenu.Help = uimenu('Parent',                 hFig_main,...
                    'HandleVisibility',      'off', ...
                    'Label',                     'Help');
                                            
hMenuItem.Help.About  =   uimenu('Parent',               hMenu.Help,...
                                'Label',                'About MAXIM',...
                                    'Checked',           'off',...
                                    'Separator',          'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_Help_About_Callback);
                            
                            
