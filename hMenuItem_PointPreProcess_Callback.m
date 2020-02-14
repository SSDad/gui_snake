function hMenuItem_PointPreProcess_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
hPlotObj = data_main.hPlotObj;

x0 = data_main.x0;
y0 = data_main.y0;
dx = data_main.dx;
dy = data_main.dy;

xmin = 0;
xmax = inf;
for iSlice = 1:data_main.nImages
    C = data_main.cont{iSlice};
    xx = (C(:, 1)-1)*dx+x0;
    xmin = max(min(xx), xmin);
    xmax = min(max(xx), xmax);
    
    C(:, 2) = (C(:, 2)-1)*dy+y0;
    yMean(iSlice) = mean(yy);
end
    


iSlice = round(data_main.hSlider.snake.Value);

% convert to xy

% number of neighbour points
strNP =  data_main.hPopup.Neighbour.String;
idxNP = data_main.hPopup.Neighbour.Value;
NP = str2num(strNP{idxNP});
data_main.Point.NP = NP;

[xm, ym, xL, yL, xR, yR, yMean, xxn, yyn] = fun_findPointsOnDiaphragm(C, NP, dx);
data_main.Point.yMean = yMean;
data_main.Point.xxn = xxn;
data_main.Point.yyn = yyn;

% show on gui
data_main.hPlotObj.Point.XData = xm;
data_main.hPlotObj.Point.YData = ym;
data_main.hPlotObj.LeftPoints.XData = xL;
data_main.hPlotObj.LeftPoints.YData = yL;
data_main.hPlotObj.RightPoints.XData = xR;
data_main.hPlotObj.RightPoints.YData = yR;
    

% % point x - mean over all contour x
% x = mean(C(:, 2));
% xx = C(:, 2);
% yy = C(:, 1);
% 
% [~, ind] = sort(abs(xx - x));
% px4 = xx(ind(1:4));
% py4 = yy(ind(1:4));
% 
% [~, idx] = max(py4);
% 
% ip = ind(idx); % point index
% 
% % update points 
% data_main.hPlotObj.Point.XData = xx(ip);
% data_main.hPlotObj.Point.YData = yy(ip);
% 
% 
% [xLP, yLP, xRP, yRP] = fun_findNeighbourPoints(xx, yy, ip, NP);


% % find x increase
% xn = circshift(xx, -ip+1);
% if xn(10) > x(1)
%     direction = 1;
% else
%     direction = -1;
% end


% data_main.Point.idx = ip;
% data_main.Point.direction = direction;
data_main.Point.iSlice = iSlice;

data_main.Point.xm = xm;

data_main.hToggleButton.Manual.Visible = 'off';
data_main.hSlider.snake.Visible = 'off';

data_main.hText.Neighbour.Visible = 'on';
data_main.hPopup.Neighbour.Visible = 'on';

% set(hFig_main, 'CurrentAxes', data_main.hAxis.snake)
% figure(hFig_main);
%% save
guidata(hFig_main, data_main);                

set(hFig_main, 'keypressfcn', @fh_kpfcn);

