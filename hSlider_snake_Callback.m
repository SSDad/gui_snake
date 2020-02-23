function hSlider_snake_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

x0 = data_main.x0;
y0 = data_main.y0;
dx = data_main.dx;
dy = data_main.dy;

sV = round(get(src, 'Value'));

hPlotObj = data_main.hPlotObj;
hPlotObj.snakeImage.CData = rot90(data_main.Images{sV}, 3);

if data_main.FreeHandDone
    data_main.FreeHand.L.Visible = 'off';
%     if  sV == data_main.FreeHand.iSlice
%         data_main.FreeHand.L.Visible = 'on';
%     end
end

% contour
if data_main.SnakeDone
    CB =   data_main.cont{sV};
    if isempty(CB)
        data_main.hPlotObj.cont.XData = [];
        data_main.hPlotObj.cont.YData = [];
    else
        data_main.hPlotObj.cont.YData = (CB(:, 2)-1)*dy+y0;
        data_main.hPlotObj.cont.XData = (CB(:, 1)-1)*dx+x0;
    end
    
    CM =  data_main.maskCont{sV};
    if isempty(CM)
        data_main.hPlotObj.maskCont.XData = [];
        data_main.hPlotObj.maskCont.YData = [];
    else
        data_main.hPlotObj.maskCont.YData = (CM(:, 2)-1)*dy+y0;
        data_main.hPlotObj.maskCont.XData = (CM(:, 1)-1)*dx+x0;
    end
    
end

if data_main.LineDone
    % points on contour
    iSlice = sV;
    xi = data_main.Point.xi;
    yi = data_main.Point.yi;
    ixm = data_main.Point.ixm;
    data_main.hPlotObj.Point.XData = xi(ixm);
    data_main.hPlotObj.Point.YData = yi(iSlice, ixm);

    NP = data_main.Point.NP;
    hPlotObj.LeftPoints.XData = xi(ixm-NP:ixm-1);
    hPlotObj.LeftPoints.YData = yi(iSlice, ixm-NP:ixm-1);
    hPlotObj.RightPoints.XData = xi(ixm+1:ixm+NP);
    hPlotObj.RightPoints.YData = yi(iSlice, ixm+1:ixm+NP);
    
    % point of current slice on points plot
    hPlotObj.PlotPoint.Current.XData = iSlice;
    hPlotObj.PlotPoint.Current.YData = mean(yi(iSlice, ixm-NP:ixm+NP));
end    

data_main.hText.nImages.String = [num2str(sV), ' / ', num2str(data_main.nImages)];