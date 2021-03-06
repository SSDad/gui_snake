function hMenuItem_Snake1_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;
x0 = data_main.x0;
y0 = data_main.y0;
dx = data_main.dx;
dy = data_main.dy;

L = data_main.FreeHand.L;
II = data_main.Images;

sV = round(data_main.hSlider.snake.Value);
I = rot90(rgb2gray(II{sV}), 3);
[M, N] = size(I);
C = L.Position;

% convert to ij
C(:, 1) = (C(:, 1)-data_main.x0)/data_main.dx+1;
C(:, 2) = (C(:, 2)-data_main.y0)/data_main.dy+1;

mask = poly2mask(C(:,1), C(:,2), M, N);

%% snakes
% hWB = waitbar(0, 'Snake slithering...');
nImages = length(II);

L.Visible = 'off';

windowWidth = 45;
polynomialOrder = 3;
for n = 1:nImages
    J =  rgb2gray(II{n});
    J = rot90(J, 3);
    bw = activecontour(J, mask, 8);
    B = bwboundaries(bw);
    
    nP = [];
    for m = 1:length(B)
        nP(m) = size(B{m}, 1);
    end
    
    [~, idx] = max(nP);
%     waitbar(n/nImages, hWB);
    
    % smooth
    sX = sgolayfilt(B{idx}(:, 2), polynomialOrder, windowWidth);
    sY = sgolayfilt(B{idx}(:, 1), polynomialOrder, windowWidth);
    data_main.cont{n} = [sX sY];
    
    % show
    data_main.hSlider.snake.Value = n;
    hPlotObj.snakeImage.CData = rot90(data_main.Images{n}, 3);
    hPlotObj.cont.YData = (sY-1)*dy+y0;
    hPlotObj.cont.XData = (sX-1)*dx+x0;
    data_main.hText.nImages.String = [num2str(n), ' / ', num2str(data_main.nImages)];
    drawnow;
end
% close(hWB);

data_main.SnakeDone = true;

CB =   data_main.cont{n};
data_main.hPlotObj.cont.YData = (CB(:, 2)-1)*dy+y0;
data_main.hPlotObj.cont.XData = (CB(:, 1)-1)*dx+x0;

data_main.hToggleButton.Manual.Visible = 'on';
data_main.hMenuItem.SaveSnakes.Enable = 'on';
data_main.hMenuItem.ReContour.Enable = 'on';
data_main.hMenuItem.ReContour.Checked = 'on';
% visboundaries(data_main.hAxis.snake, bw, 'Color', 'r'); 

%% save
guidata(hFig_main, data_main);                