% 实验专用做图纸
clc, clear, close all
%% 50 x 50
figure("Color", [1 1 1])
stc = axes;
grid on 
box off
axis equal
%xticks(1:1:50)

xline(0:1:50, 'LineWidth', 0.2)
xline(0:5:50, 'LineWidth', 0.4)
xline([0 50], 'LineWidth', 0.8)
xlim([0 50])
stc.XTick = '';
stc.XTick = 0:5:50;
stc.XMinorTick = 'on';
stc.XTickLabel = cell(zeros(1, 51));


yline(0:1:50, 'LineWidth', 0.2)
yline(0:5:50, 'LineWidth', 0.5)
yline([0 50], 'LineWidth', 1.0)
ylim([0 50])
stc.YTick = '';
stc.YTick = 0:5:50;
stc.YMinorTick = 'on';
stc.YTickLabel = cell(zeros(1, 51));


stc.TickDir = 'out';
%stc.TickLength = [0.02 0.06];

% Refer to https://github.com/YiDingg/Matlab to get this function
%MyExport_pdf  

%% 100 x 50
figure("Color", [1 1 1])
stc = axes;
grid on 
box off
axis equal
%xticks(1:1:50)

xline(0:1:100, 'LineWidth', 0.2)
xline(0:5:100, 'LineWidth', 0.4)
xline([0 50 100], 'LineWidth', 0.8)
xlim([0 100])
stc.XTick = '';
stc.XTick = 0:5:100;
stc.XMinorTick = 'on';
stc.XTickLabel = cell(zeros(1, 101));


yline(0:1:50, 'LineWidth', 0.2)
yline(0:5:50, 'LineWidth', 0.5)
yline([0 50], 'LineWidth', 1.0)
ylim([0 50])
stc.YTick = '';
stc.YTick = 0:5:50;
stc.YMinorTick = 'on';
stc.YTickLabel = cell(zeros(1, 51));


stc.TickDir = 'out';
%stc.TickLength = [0.02 0.06];

% Refer to https://github.com/YiDingg/Matlab to get this function
MyExport_pdf  

%% 100 x 100
figure("Color", [1 1 1])
stc = axes;
grid on 
box off
axis equal
%xticks(1:1:50)

xline(0:1:100, 'LineWidth', 0.2)
xline(0:5:100, 'LineWidth', 0.4)
xline([0 50 100], 'LineWidth', 0.8)
xlim([0 100])
stc.XTick = '';
stc.XTick = 0:5:100;
stc.XMinorTick = 'on';
stc.XTickLabel = cell(zeros(1, 101));


yline(0:1:100, 'LineWidth', 0.2)
yline(0:5:100, 'LineWidth', 0.5)
yline([0 50 100], 'LineWidth', 1.0)
ylim([0 100])
stc.YTick = '';
stc.YTick = 0:5:100;
stc.YMinorTick = 'on';
stc.YTickLabel = cell(zeros(1, 51));


stc.TickDir = 'out';
%stc.TickLength = [0.02 0.06];

% Refer to https://github.com/YiDingg/Matlab to get this function
MyExport_pdf  