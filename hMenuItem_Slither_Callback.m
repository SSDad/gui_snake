function hMenuItem_Slither_Callback(src, evnt)

hFig_main = ancestor(src, 'Figure');
data_main = guidata(hFig_main);
pn = data_main.hPanel.Slither;
menu = data_main.hMenuItem.Slither;

if strcmp(menu.Checked, 'off')
    pn.Visible = 'on';
    menu.Checked = 'on';
else
    pn.Visible = 'off';
    menu.Checked = 'off';
end