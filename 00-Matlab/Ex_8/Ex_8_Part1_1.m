clc, clear, close all
mu_0 = 4*pi*10^(-7)
l_11 = 0.13
l_12 = 0.075
N_1 = 150
N_2 = 150
N_3 = 150
S_1 = 1.24e-4
S_2 = 1.20e-4

N = 2000
l_2 = 0.24
l_g = 2e-3

% u_R1 即为 x
% u_C 即为 y
% 注意换算电压单位！！（乘 10^(-3)）


R_1 = 2
R_2 = 50e3
C = 10e-6

N_1/(l_11*R_1)
R_2*C/(N_2*S_1)

% 横坐标
u_R1_array = 10^(-3)*[  
-456 -228 -91.2 -45.6 -22.8 -6.60 ...
0.00 13.2 22.2 44.4 88.8 222 444
];

% 纵坐标（上半支）
u_C1_array = 10^(-3)*[  
-22.0 -21.6 -19.2 -15.6 -9.20 0.00 ...
4.00 8.80 10.8 14.8 17.6 20.0 20.8
];

% 纵坐标（下半支）
u_C2_array = 10^(-3)*[  
-22.0 -21.6 -19.2 -17.2 -14.0 -10.0 ...
-7.60 0.00 5.60 12.8 17.6 20.0 20.8
];

H = N_1/(l_11*R_1) * u_R1_array;
B_1 = R_2*C/(N_2*S_1) * u_C1_array;
B_2 = R_2*C/(N_2*S_1) * u_C2_array;

% 用函数 y = y(x) = a*arctan(b*x + c) + d 来拟合磁滞回线的半支

fit1 = Fit_HAndB(H, B_1);
fit2 = Fit_HAndB(H, B_2);

figure('Color', [1 1 1])
ax = axes;
sca = MyScatter_ax(ax, [H, H(end:-1:1)], [B_1, B_2(end:-1:1)]);
sca.scatter.scatter_1.SizeData = 100;
sca.scatter.scatter_1.MarkerEdgeColor = 'r';

x_array = linspace(H(1), H(end), 100);
p1 = MyPlot_ax(ax, x_array, fit1(x_array)');
p2 = MyPlot_ax(ax, x_array, fit2(x_array)');
xline(0, 'Color', [0.5, 0.5, 0.5])
yline(0, 'Color', [0.5, 0.5, 0.5])

p1.plot.plot_1.LineWidth = 1;
p2.plot.plot_1.LineWidth = 1;
p1.label.x.String = '$H\ \mathrm{(A\cdot m^{-1})}$ ';
p1.label.y.String = '$B$ (T)';
p1.leg.String = ["Raw data"; "Fitted curve"];

%MyExport_pdf

%ax2 = ax;
%xlim([-70, 70])
%MyExport_pdf

B_r = (fit1(0) - fit2(0))/2;
H_c = (fzero(@(x) fit2(x), 0) - fzero(fit1, 0))/2;

disp(['B_r = ', num2str(B_r)])
disp(['H_c = ', num2str(H_c)])

%MyPrint_xlsx([H', B_1', B_2'], 3)
%MyPrint_xlsx([u_R1_array', u_C1_array', u_C2_array'], 3)

%% 函数区
function [fitresult, gof] = Fit_HAndB(H, B)

[xData, yData] = prepareCurveData( H, B );

% 设置 fittype 和选项。
ft = fittype( 'a*atan(b*x+c)+d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.DiffMaxChange = 0.01;
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [0.496537318440195 0.308971081219392 0.8508 0.98199328087302];

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );
end