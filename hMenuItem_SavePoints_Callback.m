function hMenuItem_SavePoints_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

dataPath = data_main.dataPath;
matFile = data_main.matFile;

 [~, fn1, ~] = fileparts(matFile);
 ffn = fullfile(dataPath, [fn1, '_points.mat']);
 
 points = data_main.Point.AllPoint;
 
 save(ffn, 'points');
 
% % turn off 'Delete Contour' button 
% data_main.hPushButton.DeleteSnake.Visible = 'off';
% data_main.hMenuItem.DeletePoint.Checked = 'off';