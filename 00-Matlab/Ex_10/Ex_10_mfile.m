%% 计算刻线密度
l = 12 % 单位 cm
lambda = 656.3226e-9 

X = [0.0, 0.8, 1.6, 2.425, 3.285, 4.180]
M = [0 1 2 3 4 5]
Tan = X/l
Sin = Tan./sqrt(1 + Tan.^2)
d = M*lambda./Sin
N = 1e-3./d

%% 读取光谱数据并作图
clc, clear, close all
data_LED = readmatrix('D:\a_RemoteRepo\GH.UCAS-BasicPhysicsExperiment\10-傅里叶光学\data\光谱仪数据 (2024-11-05 傅里叶光学)\白光 LED.txt')
data_Laser = readmatrix('D:\a_RemoteRepo\GH.UCAS-BasicPhysicsExperiment\10-傅里叶光学\data\光谱仪数据 (2024-11-05 傅里叶光学)\红光激光.txt')
data_light = readmatrix('D:\a_RemoteRepo\GH.UCAS-BasicPhysicsExperiment\10-傅里叶光学\data\光谱仪数据 (2024-11-05 傅里叶光学)\手机手电筒.txt')

stc = MyPlot([data_LED(:, 1), data_Laser(:, 1), data_light(:, 1)]', [data_LED(:, 2), data_Laser(:, 2), data_light(:, 2)]');
c = GetMyColors;
stc.plot.plot_2.Color = c{10};
stc.plot.plot_2.LineStyle = '-';
stc.plot.plot_3.LineStyle = '-';
y = ylim
stc.axes.YLim = [y(1, 1), 5e4];
stc.label.x.String = '$\lambda$ (nm)';
stc.label.y.String = 'Indensity';
stc.leg.String = ["White LED"; "Red Laser"; "Phone Flashlight"];

%% 拟合光谱数据并求解最大值
sca = MyScatter(x', y');
x_array = [linspace(600, 650, 300), linspace(650, 665, 400), linspace(665, 710, 400)]
p1 = MyPlot_ax(sca.axes, x_array, RadLaser_fit(x_array)');
MyColors = GetMyColors;
sca.scatter.scatter_1.SizeData = 80;
sca.scatter.scatter_1.MarkerEdgeColor = MyColors{1};

%xline(0, 'Color', [0.5, 0.5, 0.5])
%yline(0, 'Color', [0.5, 0.5, 0.5])

p1.plot.plot_1.LineWidth = 1;
p1.plot.plot_1.Color = 'r';
p1.label.x.String = '$\lambda$ (nm) ';
p1.label.y.String = 'Indensity';
p1.leg.String = ["Raw data"; "Fitted curve"];
xlim([x_array(1), x_array(end)])
MyExport_pdf_docked