function hMenuItem_LoadImages_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;
hSlider = data_main.hSlider;

% save path
td = tempdir;
fd_info = fullfile(td, 'TaehoTracking');
fn_info = fullfile(fd_info, 'info.mat');
if ~exist(fd_info, 'dir')
    [matFile, dataPath] = uigetfile('*.mat');
    mkdir(fd_info);
    save(fn_info, 'dataPath');
else
    if ~exist(fn_info, 'file')
        [matFile, dataPath] = uigetfile('*.mat');
        save(fn_info, 'dataPath');
    else
        load(fn_info);
        [matFile, ~] = uigetfile([dataPath, '*.mat']);
    end
end

data_main.dataPath = dataPath;
data_main.matFile = matFile;

ffn = fullfile(dataPath, matFile);
load(ffn)

nImages = length(imgWrite);
sV = round(nImages/2);
sV = 1;
I = rot90(imgWrite{sV}, 3);

hPlotObj.snakeImage.CData = I;

data_main.hText.nImages.String = [num2str(sV), ' / ', num2str(nImages)];
data_main.nImages = nImages;
data_main.indSS = 1:nImages;

% slider
hSlider.snake.Min = 1;
hSlider.snake.Max = nImages;
hSlider.snake.Value = sV;
hSlider.snake.SliderStep = [1 10]/(nImages-1);

% init. contour
data_main.cont = cell(nImages, 1);

data_main.hMenuItem.FreeHand.Enable = 'on';
data_main.Images = imgWrite;

data_main.gatedContour = gatedContour;
data_main.trackContour = trackContour;

%% initilization
data_main.FreeHand = [];

data_main.FreeHandDone = false;
data_main.SnakeDone = false;
data_main.AllPointDone = false;

data_main.hPlotObj.cont.XData = [];
data_main.hPlotObj.cont.YData = [];
data_main.hPlotObj.Point.XData = [];
data_main.hPlotObj.Point.YData = [];

data_main.hMenuItem.Snake.Enable = 'off';
data_main.hSlider.snake.Visible = 'on';

%% initial Tumor plot
data_main.hMenuItem.Snake.Enable = 'off';
data_main.hMenuItem.Tumor.bwSum.Enable = 'on';
data_main.hMenuItem.Tumor.TrackContour.Enable = 'on';

hPlotObj.Tumor.hgTrackContour = hggroup(hAxis.Tumor);
hPlotObj.Tumor.hgGatedContour = hggroup(hAxis.Tumor);
hPlotObj.Tumor.hgPoints = hggroup(hAxis.Tumor);
for n = 1:nImages
    hPlotObj.Tumor.TrackContour(n) = line(hPlotObj.Tumor.hgTrackContour, ...
        'XData', [], 'YData', [],  'Color', 'b', 'LineStyle', '-', 'LineWidth', 1);
    hPlotObj.Tumor.GatedContour(n) = line(hPlotObj.Tumor.hgGatedContour, ...
        'XData', [], 'YData', [],  'Color', 'g', 'LineStyle', '-', 'LineWidth', 1);
    hPlotObj.Tumor.Points(n) = line(hPlotObj.Tumor.hgPoints, 'XData', [], 'YData', [],  'Marker', '.',  'MarkerSize', 12, 'Color', 'r', 'LineStyle', 'none');
end

data_main.hPlotObj = hPlotObj;

%% save
guidata(hFig_main, data_main);                