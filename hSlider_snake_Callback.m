function hSlider_snake_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);

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
    data_main.hPlotObj.cont.XData = CB(:, 2);
    data_main.hPlotObj.cont.YData = CB(:, 1);
end

if data_main.AllPointDone
    data_main.hPlotObj.Point.XData = data_main.Point.AllPoint(sV, 1);
    data_main.hPlotObj.Point.YData = data_main.Point.AllPoint(sV, 2);
    
     hPlotObj.PlotPoint.Current.XData = sV;
     hPlotObj.PlotPoint.Current.YData = data_main.Point.AllPoint(sV, 2);
end


data_main.hText.nImages.String = [num2str(sV), ' / ', num2str(data_main.nImages)];