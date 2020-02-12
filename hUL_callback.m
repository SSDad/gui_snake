function hUL_callback(src, evnt)
    hFig_main = ancestor(src, 'Figure');
    data_main = guidata(hFig_main);
    
    allP = data_main.Point.AllPoint;
    if strcmp(src.Tag, 'UL')
        y1 = data_main.LinePos.y1;
        y2 = src.Position(1,2);
        data_main.LinePos.y2 = y2;
    else
        y2 = data_main.LinePos.y2;
        y1 = src.Position(1,2);
        data_main.LinePos.y1 = y1;
    end        
        
    if y2>y1
        data_main.Tumor.indSS = find(allP(:, 2) >= y1 & allP(:, 2) <= y2);
        guidata(hFig_main, data_main);

        if strcmp(data_main.hMenuItem.Tumor.bwSum.Checked, 'on')
            updateTumorOverlay(data_main);
        end
        
        if strcmp(data_main.hMenuItem.Tumor.TrackContour.Checked, 'on')
            updateTrackContour(data_main);
        end
        
        if strcmp(data_main.hMenuItem.Tumor.Points.Checked, 'on')
            updateTumorPoints(data_main);
        end
    end
    