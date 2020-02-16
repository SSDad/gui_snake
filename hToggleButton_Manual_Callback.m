function hToggleButton_Manual_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

x0 = data_main.x0;
y0 = data_main.y0;
dx = data_main.dx;
dy = data_main.dy;

bV = src.Value;
iSlice = round(data_main.hSlider.snake.Value);

if bV
    
    src.String = 'Slither';
    src.ForegroundColor = 'c';
    data_main.hSlider.snake.Visible = 'off';
    
    data_main.hPlotObj.cont.XData = [];
    data_main.hPlotObj.cont.YData = [];
    data_main.cont{iSlice} = [];

    src.Visible = 'off';
   
    L = images.roi.AssistedFreehand(data_main.hAxis.snake) ;
    draw(L);
    pause;

    src.Visible = 'on';

    data_main.FreeHand.L = L;
    data_main.FreeHand.iSlice = iSlice;

else
    L = data_main.FreeHand.L;
   
    I = data_main.hPlotObj.snakeImage.CData;
    [M, N, ~] = size(I);
    C = L.Position;
    
    % convert to ij
    C(:, 1) = (C(:, 1)-data_main.x0)/data_main.dx+1;
    C(:, 2) = (C(:, 2)-data_main.y0)/data_main.dy+1;
    
    mask = poly2mask(C(:,1), C(:,2), M, N);

    windowWidth = 45;
    polynomialOrder = 3;
    bw = activecontour(I, mask, 8);
    B = bwboundaries(bw);
    
    nP = [];
    for m = 1:length(B)
        nP(m) = size(B{m}, 1);
    end
    
    [~, idx] = max(nP);
    
    % smooth
    sX = sgolayfilt(B{idx}(:, 2), polynomialOrder, windowWidth);
    sY = sgolayfilt(B{idx}(:, 1), polynomialOrder, windowWidth);
    data_main.cont{iSlice} = [sX sY];
    
    % show
    data_main.hPlotObj.cont.YData = (sY-1)*dy+y0;
    data_main.hPlotObj.cont.XData = (sX-1)*dx+x0;
    
    L.Visible = 'off';

    src.String = 'ReContour';
    src.ForegroundColor = 'g';
    data_main.hSlider.snake.Visible = 'on';
end

guidata(hFig_main, data_main);


% hPlotObj = data_main.hPlotObj;
% 
% if data_main.FreeHandDone
%     data_main.FreeHand.L.Visible = 'off';
%     if  sV == data_main.FreeHand.iSlice
%         data_main.FreeHand.L.Visible = 'on';
%     end
% end
% 
% if data_main.SnakeDone
%     CB =   data_main.cont{sV};
%     data_main.hPlotObj.cont.XData = CB(:, 2);
%     data_main.hPlotObj.cont.YData = CB(:, 1);
% end
% 
% data_main.hText.nImages.String = [num2str(sV), ' / ', num2str(data_main.nImages)];