function hMenuItem_SaveSnakes_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

dataPath = data_main.dataPath;
matFile = data_main.matFile;

[~, fn1, ~] = fileparts(matFile);
ffn = fullfile(dataPath, [fn1, '_snakes.mat']);

snakes = data_main.cont;

save(ffn, 'snakes');