%% Ex 04: 热导测量

%% 动态法测铜
clc, clear, close all
data = transpose(readmatrix("D:\a_RemoteRepo\GH.UCAS-BasicPhysicsExperiment\04-热导测量\data\DY 20241210 电脑数据导出\铜可视 2.rdc", 'FileType', 'text'));
% 第一行是时间, 第二行是分割线（无用）
stc = MyPlot(data(1, :), data(3:end, :));
stc.leg.Visible = 'off';
stc.label.x.String = 'Time (s)';
stc.label.y.String = 'Ouput Voltage (mV)';
ylim([400 1200])
%MyExport_pdf_docked

% 读取峰值时间
data = data(:, data(1, :)> 2600);
for i = 1:12
    [Max(1, i), index] = max(data(2+i, :));
    Max(2, i) = data(1, index);
    %disp(['num ', num2str(i), ': max = ', num2str()])
end
Max
stc = MyPlot(data(1, :), data(3:end, :));

a = Max(2, 8);
Max(2, 8) = Max(2, 9);
Max(2, 9) = a;

[stc, fit] = MyFit_linear(Max(2, :), (0:2:22)*0.01);
stc.label.x.String = 'Time (s)';
stc.label.y.String = 'Reletive Peak Position (cm)';

rho = 8.92e3;
C = 0.385e3;
T = 180;
v = fit.p1
k = rho*C*T*v^2/(4*pi)

MyPrint_xlsx(Max, 1)

%% 动态法测铝
clc, clear, close all
data = transpose(readmatrix("D:\a_RemoteRepo\GH.UCAS-BasicPhysicsExperiment\04-热导测量\data\DY 20241210 电脑数据导出\铝 可视区.rda", 'FileType', 'text'));
data = data(1:10, :);
% 第一行是时间, 第二行是分割线（无用）
stc = MyPlot(data(1, :), data(3:10, :));
stc.leg.Visible = 'off';
stc.label.x.String = 'Time (s)';
stc.label.y.String = 'Ouput Voltage (mV)';
ylim([800 1900])
%MyExport_pdf_docked

% 读取峰值时间
data = data(:, data(1, :)> 2400 & data(1, :) > 2600);
for i = 1:8
    [Max(1, i), index] = max(data(2+i, :));
    Max(2, i) = data(1, index);
    %disp(['num ', num2str(i), ': max = ', num2str()])
end
Max
stc = MyPlot(data(1, :), data(3:end, :));


a = Max(2, 7);
Max(2, 7) = Max(2, 8);
Max(2, 8) = a;

[stc, fit] = MyFit_linear(Max(2, :), (0:2:14)*0.01);
stc.label.x.String = 'Time (s)';
stc.label.y.String = 'Reletive Peak Position (cm)';

rho = 2.7e3;
C = 0.880e3;
T = 180;
v = fit.p1
k = rho*C*T*v^2/(4*pi)

MyPrint_xlsx(Max, 1)

%% 温差电动势
t = [27.1  30.3  35.5  40.0  44.9  49.9];
U = [0.880  0.936  0.916  1.068  1.148  1.202];

t = [27.1  30.3    40.0  44.9  49.9];
U = [0.880  0.936    1.068  1.148  1.202];
[stc, fit] = MyFit_linear(t, U);
t_0  = fit.p2/(-fit.p1)
stc.label.x.String = 'Temprature $t\ (^\circ\mathrm{C})$';
stc.label.y.String = 'Potential $U \ (\mathrm{V})$';


%% 铜电阻
t = [30.3 35.0 40.0 45.1 50.0];
R = [57.8 58.8 59.9 61.1 62.2];
[stc, fit] = MyFit_linear(t, R);
R_x0 = fit.p2
alpha = fit.p1/fit.p2
vpa(alpha)
stc.label.x.String = 'Temprature $t\ (^\circ\mathrm{C})$';
stc.label.y.String = 'Resistance $R \ (\Omega)$';

%% 热敏电阻
t = [30.2 35.2 40.0 44.9 50.1];
R = [2253.7 1814.4 1482.7 1212.4 984.0];
stc = MyPlot(t, R);

y = log(R);
x = 1./(t + 273.15);
[stc, fit] = MyFit_linear(x, y);
R_x0 = fit.p2
alpha = fit.p1/fit.p2
vpa(alpha)
stc.label.x.String = '$\frac{1}{T}$';
stc.label.y.String = '$\ln R$';
%MyExport_pdf

A = exp(fit.p2)
B = fit.p1

f = @(t) A*exp(B./(t + 273.15))'
stc = MyPlot_FitAndRaw(f, t, R);
stc.label.x.String = 'Temprature $T\ (^\circ\mathrm{C})$';
stc.label.y.String = 'Resistance $R \ (\Omega)$';

%MyExport_pdf

%t = [40 42.6 45 47.5 48.5  50.1 52.5];
%U = [0 -0.66 -1.24 -1.90 -2.57]*10^(-3)-0.4;
U = [-400 -427 -452 -477 -501]*10^(-3)
t_1 = 40;
lambda = -0.4; m = -10e-3;
t = t_1 + (U - lambda)/m
