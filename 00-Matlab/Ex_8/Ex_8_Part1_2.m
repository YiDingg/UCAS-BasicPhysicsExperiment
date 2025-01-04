clc, clear, close all

load('Global.mat')

R_1 = 2
R_2 = 50e3
C = 10e-6

Delta_u_R1_array = [
5.76	7.00	7.68	10.2	12.9	15.9	17.80	24.8	31.6	42.4 ...
54.4	61.6	68.0	74.4	85.6	93.6	110	137	158	1070
]*10^(-3);

Delta_u_C_array = [
1.92	2.48	2.64	3.60	4.72	5.92	6.96	9.84	13.0	17.2 ...
21.2	23.2	25.2	26.4	28.8	30.4	32.4	34.4	36.0	42.4
]*10^(-3);

N_1/(l_11*R_1)*0.5
R_2*C/(N_2*S_1)*0.5
1/mu_0

H_m = N_1/(l_11*R_1)*0.5 * Delta_u_R1_array;
B_m = R_2*C/(N_2*S_1)*0.5 * Delta_u_C_array;
mu_m = 1/mu_0 * B_m./H_m;


%MyPlot(H_m, B_m)
%MyPlot(H_m(1:end-1), mu_m(1:end-1))

% 拟合 H_m-B_m 
fit_H_m = Fit_HAndB(H_m, B_m);

figure('Color', [1 1 1])
ax = axes;
sca = MyScatter_ax(ax, H_m, B_m);
sca.scatter.scatter_1.SizeData = 100;
sca.scatter.scatter_1.MarkerEdgeColor = 'r';

x_array = linspace(0, H_m(end)+20, 100);
p1 = MyPlot_ax(ax, x_array, fit_H_m(x_array)');
xline(0, 'Color', [0.5, 0.5, 0.5])
yline(0, 'Color', [0.5, 0.5, 0.5])

p1.plot.plot_1.LineWidth = 1;
p2.plot.plot_1.LineWidth = 1;
p1.label.x.String = '$H_m\ \mathrm{(A\cdot m^{-1})}$ ';
p1.label.y.String = '$B_m$ (T)';
p1.leg.String = ["Raw data"; "Fitted curve"];

%MyExport_pdf

% 拟合 H_m-mu_m 图像
fit_mu_m = Fit_mu_m(H_m, mu_m);

figure('Color', [1 1 1])
ax = axes;
sca = MyScatter_ax(ax, H_m, mu_m);
sca.scatter.scatter_1.SizeData = 100;
sca.scatter.scatter_1.MarkerEdgeColor = 'r';

x_array = linspace(0, H_m(end)+20, 100);
p1 = MyPlot_ax(ax, x_array, fit_mu_m(x_array)');
xline(0, 'Color', [0.5, 0.5, 0.5])
yline(0, 'Color', [0.5, 0.5, 0.5])

p1.plot.plot_1.LineWidth = 1;
p2.plot.plot_1.LineWidth = 1;
p1.label.x.String = '$H_m\ \mathrm{(A\cdot m^{-1})}$ ';
p1.label.y.String = '$\mu_m$ (1)';
p1.leg.String = ["Raw data"; "Fitted curve"];

MyExport_pdf

mu_i = fit_mu_m(0);
disp(['mu_i = ', num2str(mu_i, '%.4f')])

%MyPrint_xlsx([H_m', B_m', mu_m'], 3)
%MyPrint_xlsx(mu_m', 2)

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

function [fitresult, gof] = Fit_mu_m(H_m, mu_m)

[xData, yData] = prepareCurveData( H_m, mu_m );

% 设置 fittype 和选项。
ft = fittype( 'a*exp(b*x)+c*exp(d*x)+e', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-100000 -2 -100000 -1 0];
opts.MaxFunEvals = 1000;
opts.StartPoint = [-10000 0.144954798223727 20000 0.5 0.350952380892271];
opts.Upper = [100000 0 100000 0 20000];

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );

end