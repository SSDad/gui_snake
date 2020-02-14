function hMenuItem_LoadImages_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPanel = data_main.hPanel;
hAxis = data_main.hAxis;
hSlider = data_main.hSlider;

%% load data
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

hWB = waitbar(0, 'Loading data...');

data_main.dataPath = dataPath;
data_main.matFile = matFile;

ffn = fullfile(dataPath, matFile);
load(ffn)

data_main.dx = 3.5;
data_main.dy = 3.5;
data_main.x0 = 0;
data_main.y0 = 0;

data_main.Images = imgWrite;
nImages = length(imgWrite);
data_main.nImages = nImages;
data_main.indSS = 1:nImages;
sV = round(nImages/2);
sV = 1;
data_main.sliderValue = sV;


data_main.gatedContour = gatedContour;
data_main.trackContour = trackContour;

waitbar(1/3, hWB, 'Initializing GUI...');
%% initialize snake panel
guidata(hFig_main, data_main);
initSnakePanel(hFig_main);
data_main = guidata(hFig_main);

%% data initilization
data_main.cont = cell(nImages, 1);
data_main.FreeHand = [];
data_main.FreeHandDone = false;
data_main.SnakeDone = false;
data_main.AllPointDone = false;

waitbar(2/3, hWB, 'Initializing GUI...');
%% initialize Tumor panel
guidata(hFig_main, data_main);
initTumorPanel(hFig_main)
data_main = guidata(hFig_main);

data_main.Tumor.indSS = 1:nImages;

%% enable menus
data_main.hMenuItem.FreeHand.Enable = 'on';
data_main.hMenuItem.Tumor.Profile.Enable = 'on';

data_main.hMenuItem.Tumor.bwSum.Checked = 'on';
data_main.hMenuItem.Snake.Enable = 'off';
data_main.hMenuItem.Tumor.bwSum.Enable = 'on';
data_main.hMenuItem.Tumor.TrackContour.Enable = 'on';

%% save
guidata(hFig_main, data_main);

waitbar(1, hWB, 'Bingo!');
pause(3);
close(hWB);