function hPushButton_Slither2_Start_Callback(src, evnt)

global stopSlither

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hAxis = data_main.hAxis;
hPlotObj = data_main.hPlotObj;

x0 = data_main.x0;
y0 = data_main.y0;
dx = data_main.dx;
dy = data_main.dy;

II = data_main.Images;
sV = round(data_main.hSlider.snake.Value);
sV = 1;
J =  rgb2gray(II{sV});
J = rot90(J, 3);
[M, N] = size(J);

L = data_main.FreeHand.L;
L.Visible = 'off';
FC = L.Position;
hPlotObj.contMask.XData = FC(:, 1);
hPlotObj.contMask.YData = FC(:, 2);

% convert to ij
FC(:, 1) = (FC(:, 1)-data_main.x0)/data_main.dx+1;
FC(:, 2) = (FC(:, 2)-data_main.y0)/data_main.dy+1;
mask = poly2mask(FC(:,1), FC(:,2), M, N);

% sname
bw = activecontour(J, mask, 10);
B = bwboundaries(bw);
nP = [];
for m = 1:length(B)
    nP(m) = size(B{m}, 1);
end
[~, idx] = max(nP);

SC = fliplr(B{idx});
data_main.cont{sV} = SC; %save in pixel s

% show
data_main.hSlider.snake.Value = sV;
hPlotObj.snakeImage.CData = rot90(data_main.Images{sV}, 3);

hPlotObj.cont.XData = SC(:, 1)*dy+y0;
hPlotObj.cont.YData = SC(:, 2)*dx+x0;

%% snakes
% hWB = waitbar(0, 'Snake slithering...');
nImages = length(II);

% sgolay filter param
% windowWidth =  round(N/15)*2+1;
% polynomialOrder = 3;

str = data_main.hPopup.SGolayParam(1).String;
idx = data_main.hPopup.SGolayParam(1).Value;
windowWidth = str2num(str{idx});
str = data_main.hPopup.SGolayParam(2).String;
idx = data_main.hPopup.SGolayParam(2).Value;
polynomialOrder = str2num(str{idx});

% snake params
str = data_main.hPopup.SnakeParam(1).String;
idx = data_main.hPopup.SnakeParam(1).Value;
nIter = str2num(str{idx});

str = data_main.hPopup.SnakeParam(2).String;
idx = data_main.hPopup.SnakeParam(2).Value;
contractionBias = str2num(str{idx});

str = data_main.hPopup.SnakeParam(3).String;
idx = data_main.hPopup.SnakeParam(3).Value;
smoothFactor = str2num(str{idx});

% up
for n = sV+1:nImages
    J =  rgb2gray(II{n});
    J = rot90(J, 3);
    MC = data_main.cont{n-1};
    hPlotObj.contMask.XData = MC(:, 1)*dy+y0;
    hPlotObj.contMask.YData = MC(:, 2)*dx+x0;

    mask = poly2mask(MC(:,1), MC(:,2), M, N);
    bw = activecontour(J, mask, nIter, 'Chan-Vese',...
        'SmoothFactor', smoothFactor, 'ContractionBias', contractionBias);
    B = bwboundaries(bw);
    
    nP = [];
    for m = 1:length(B)
        nP(m) = size(B{m}, 1);
    end
    [~, idx] = max(nP);

    C = fliplr(B{idx});
    
    % smooth
    C(:, 1) = sgolayfilt(C(:, 1), polynomialOrder, windowWidth);
    C(:, 2) = sgolayfilt(C(:, 2), polynomialOrder, windowWidth);

    data_main.cont{n} = C;
%     waitbar((n-sV)/nImages, hWB);
    
    data_main.hSlider.snake.Value = n;
    hPlotObj.snakeImage.CData = rot90(data_main.Images{n}, 3);
    hPlotObj.cont.XData = C(:, 1)*dx+x0;
    hPlotObj.cont.YData = C(:, 2)*dy+y0;
    data_main.hText.nImages.String = [num2str(n), ' / ', num2str(data_main.nImages)];
    drawnow;
   
    if stopSlither
        stopSlither = false;
        break;
    end
    
end

% down
if sV > 1
    for n = sV-1:-1:1
        J =  rgb2gray(II{n});
    J = rot90(J, 3);
    C = data_main.cont{n+1};
        mask = poly2mask(C(:,2), C(:,1), M, N);
        bw = activecontour(J, mask, 10);
        B = bwboundaries(bw);
        data_main.cont{n} = B{1};
%         waitbar((nImages-n)/nImages, hWB);

    data_main.hSlider.snake.Value = n;
    hPlotObj.snakeImage.CData = rot90(data_main.Images{sV}, 3);
    hPlotObj.cont.XData = B{1}(:, 2);
    hPlotObj.cont.YData = B{1}(:, 1);

    end
end

% close(hWB);

data_main.SnakeDone = true;

CB =   data_main.cont{n};
hPlotObj.cont.XData = C(:, 1)*dx+x0;
hPlotObj.cont.YData = C(:, 2)*dy+y0;


% visboundaries(data_main.hAxis.snake, bw, 'Color', 'r'); 

%% save
guidata(hFig_main, data_main);                