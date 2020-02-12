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

if data_main.SnakeDone
    CB =   data_main.cont{sV};
    if isempty(CB)
        data_main.hPlotObj.cont.XData = [];
        data_main.hPlotObj.cont.YData = [];
    else
        data_main.hPlotObj.cont.XData = (CB(:, 2)-1)*dy+y0;
        data_main.hPlotObj.cont.YData = (CB(:, 1)-1)*dx+x0;
    end
end

if data_main.AllPointDone
    data_main.hPlotObj.Point.XData = data_main.Point.AllPoint(sV, 1);
    data_main.hPlotObj.Point.YData = data_main.Point.AllPoint(sV, 2);
    
     hPlotObj.PlotPoint.Current.XData = sV;
     hPlotObj.PlotPoint.Current.YData = data_main.Point.AllPoint(sV, 2);
end


data_main.hText.nImages.String = [num2str(sV), ' / ', num2str(data_main.nImages)];