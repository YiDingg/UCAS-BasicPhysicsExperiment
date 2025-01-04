R_1 = 2
R_2 = 20e3
C = 2e-6

N_1/(l_11*R_1)
R_2*C/(N_2*S_1)

h = N_3/l_11
m = R_1*R_2*C*l_11/(mu_0*N_1*N_2*S_1)

I = [
0.005	0.01	0.015	0.02	0.025	0.03	0.035	0.04 ...
0.05	0.06	0.07	0.08	0.09	0.10	0.15	0.2	0.3
];

Delta_u_R_1 = [
2.60	7.60	7.40	11.6	11.6	18.8	18.4	24.8 ...
20.4	22.8	24.0	24.0	23.6	37.2	36.8	124	124
];

Delta_u_C = [
5.60	14.8	12.0	15.0	12.2	15.0	12.2	13.6 ...
7.40	5.80	4.20	3.40	2.60	3.00	1.40	2.40	1.40
];

H = h*I;
mu_R = m* Delta_u_C./Delta_u_R_1;

%MyPlot(H, mu_R)

% 拟合 mu_R
fit_mu_R = Fit_mu_R(H, mu_R);

figure('Color', [1 1 1])
ax = axes;
sca = MyScatter_ax(ax, H, mu_R);
sca.scatter.scatter_1.SizeData = 100;
sca.scatter.scatter_1.MarkerEdgeColor = 'r';

x_array = linspace(0, H(end)+20, 100);
p1 = MyPlot_ax(ax, x_array, fit_mu_R(x_array)');
xline(0, 'Color', [0.5, 0.5, 0.5])
yline(0, 'Color', [0.5, 0.5, 0.5])

p1.plot.plot_1.LineWidth = 1;
p2.plot.plot_1.LineWidth = 1;
p1.label.x.String = '$H_m\ \mathrm{(A\cdot m^{-1})}$ ';
p1.label.y.String = '$\mu_R$ (1)';
p1.leg.String = ["Raw data"; "Fitted curve"];

%MyExport_pdf

%MyPrint_xlsx([H', mu_R'], 3)

function [fitresult, gof] = Fit_mu_R(H, mu_R)
    [xData, yData] = prepareCurveData( H, mu_R );
    
    % 设置 fittype 和选项。
    ft = fittype( 'exp1' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Algorithm = 'Levenberg-Marquardt';
    opts.Display = 'Off';
    opts.MaxFunEvals = 1000;
    opts.Robust = 'LAR';
    opts.StartPoint = [5087.02548143967 -0.019280100621078];
    
    % 对数据进行模型拟合。
    [fitresult, gof] = fit( xData, yData, ft, opts );
end