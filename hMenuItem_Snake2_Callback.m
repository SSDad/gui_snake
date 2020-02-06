function hMenuItem_Snake2_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;

II = data_main.Images;
sV = round(data_main.hSlider.snake.Value);
J =  rgb2gray(II{sV});
J = rot90(J, 3);
[M, N] = size(J);

L = data_main.FreeHand.L;
C = L.Position;
mask = poly2mask(C(:,1), C(:,2), M, N);
bw = activecontour(J, mask, 10);
B = bwboundaries(bw);
nP = [];
for m = 1:length(B)
    nP(m) = size(B{m}, 1);
end
[~, idx] = max(nP);

data_main.cont{sV} = B{idx};

n = sV;
    data_main.hSlider.snake.Value = n;
    hPlotObj.snakeImage.CData = rot90(data_main.Images{sV}, 3);
    hPlotObj.cont.XData = B{idx}(:, 2);
    hPlotObj.cont.YData = B{idx}(:, 1);


%% snakes
hWB = waitbar(0, 'Snake slithering...');
nImages = length(II);

% up
for n = sV+1:nImages
    J =  rgb2gray(II{n});
    J = rot90(J, 3);
    C = data_main.cont{n-1};
    
    % smooth
    windowWidth = 45;
    polynomialOrder = 3;
    sX = sgolayfilt(C(:, 1), polynomialOrder, windowWidth);
    sY = sgolayfilt(C(:, 2), polynomialOrder, windowWidth);

%     mask = poly2mask(sY, sX, M, N);
%     mask = poly2mask(C(:,2), C(:,1), M, N);
    bw = activecontour(J, mask, 10);
    B = bwboundaries(bw);
    
    nP = [];
    for m = 1:length(B)
        nP(m) = size(B{m}, 1);
    end
    [~, idx] = max(nP);

    data_main.cont{n} = B{idx};
    waitbar((n-sV)/nImages, hWB);
    
    data_main.hSlider.snake.Value = n;
    hPlotObj.snakeImage.CData = rot90(data_main.Images{n}, 3);
    hPlotObj.cont.XData = B{idx}(:, 2);
    hPlotObj.cont.YData = B{idx}(:, 1);
    
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
        waitbar((nImages-n)/nImages, hWB);

    data_main.hSlider.snake.Value = n;
    hPlotObj.snakeImage.CData = rot90(data_main.Images{sV}, 3);
    hPlotObj.cont.XData = B{1}(:, 2);
    hPlotObj.cont.YData = B{1}(:, 1);

    end
end

close(hWB);

data_main.SnakeDone = true;

CB =   data_main.cont{n};
data_main.hPlotObj.cont.XData = CB(:, 2);
data_main.hPlotObj.cont.YData = CB(:, 1);


% visboundaries(data_main.hAxis.snake, bw, 'Color', 'r'); 

%% save
guidata(hFig_main, data_main);                