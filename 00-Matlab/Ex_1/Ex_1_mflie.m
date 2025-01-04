%% 拉伸法
u_L = sqrt(2*0.1^2 + (2/sqrt(3))^2)

d = [0.192	0.192	0.190	0.191	0.191	0.192]
d_bar = mean(d)

% 不确定度
e = 0.004
u_A = sqrt( sum((d - d_bar).^2) / (6*5) )
u_B2 = e/sqrt(3)
u_d = sqrt(u_A^2 + u_B2^2)

l = [
0.80	0.65
0.55	0.40
0.30	0.30
0.10	0.10
-0.10	-0.15
-0.35	-0.35
-0.60	-0.60
]
l_bar = [mean(l, 2); -0.8]
M = transpose(250:250:2000)
M_bar = mean(M)
l_bar.*M
l_bar_bar = mean(l_bar)
l_bar_sum = sum(l_bar)
Delta_bar_l = l_bar(5:8) - l_bar(1:4)

mean_Delta_bar_l = mean(Delta_bar_l)

% 不确定度
h = Delta_bar_l;
h_bar = mean(h);
n = 4;

u_A = sqrt( sum((h - h_bar).^2) / (n*(n-1)) )
u_B2 = e/sqrt(3)
u_d = sqrt(u_A^2 + u_B2^2)

% 逐差法
Delta_M = 1000*e-3
g = 9.807
u_L = 2e-3
L = 791e-3
u_d = 0.003e-3
d = 0.191e-3
u_Delta_l = 0.02e-3
Delta_l = 0.87e-3

Y_0 = 2.3e11
Y = 4*Delta_M*g*L / ( pi*d^2*Delta_l )
Delta_Y = vpa(sqrt( 4*(u_d/d)^2 + (u_L/L)^2 + (u_Delta_l/Delta_l)^2 ))
Delta_Y = Y  *sqrt( 4*(u_d/d)^2 + (u_L/L)^2 + (u_Delta_l/Delta_l)^2 )

error_per = @(Y) (Y - Y_0)/Y_0*100;
error_per(Y)

% 最小二乘法

k = sum( (l_bar - l_bar_bar).*(M - M_bar) ) / sum( (M - M_bar).^2 )
k = abs(k)
Y = 4*g*L/(pi*d^2*k)
error_per(Y)

% 作图法
[fit, ou] = Fit_linear(M, l_bar)
h = 1e-7
k = (fit(500 + h) - fit(500))/h
k = abs(k)
Y = 4*g*L/(pi*d^2*k)
error_per(Y)

stc = MyFitPlot(fit, M', l_bar');
stc.label.x.String = '$M$ (g)';
stc.label.y.String = '$\bar{l}$ (mm)';
ylim([-1 0.8])
%MyExport_pdf_docked

%% 霍尔法 (黄铜数据)
clc, clear, close all

g = 9.807

% 黄铜
size = [
229.2	230.1	230.0	229.4	229.3	229.3
23.50	23.46	23.44	23.44	23.48	23.52
0.980	0.983	0.979	0.965	0.980	0.986    
];
mean_size = mean(size, 2)
data = [
12.4	22.0	29.6	39.8	50.0	59.5	70.3	80.0
1.125	1.229	1.316	1.433	1.540	1.659	1.782	1.897
34	58	78	104	128	149	175	201    
];
mean(data, 2)

u_A = sqrt( sum( ( size-mean_size ).^2, 2 ) / (6*5) )
u_B2 = [0.12; 0.02; 0.004]/sqrt(3)
u = sqrt(u_A.^2 + u_B2.^2)

Delta_Z = data(2, 5:8) - data(2, 1:4)
mean_Delta_Z = mean(Delta_Z)
u_Delta_Z = u2(Delta_Z, 4, 0.002)

Delta_M = data(1, 5:8) - data(1, 1:4)
mean_Delta_M = mean(Delta_M)
u_Delta_M = u2(Delta_M, 4, 0.1)


%% 霍尔法 (铸铁数据)
disp('------------- 下面是铸铁 -------------')

clc, clear, close all

g = 9.807

% 铸铁
size = [
229.4	230.0	229.5	229.5	229.8	230.1
23.32	23.34	23.36	23.34	23.341	23.32
0.973	0.976	0.969	0.974	0.973	0.975
];
mean_size = mean(size, 2)
data = [
20.2	39.6	60.0	81.4	100.6	120.5	140.0	160.0
0.189	0.320	0.461	0.603	0.717	0.868	1.019	1.162
31	61	91	122	150	178	205	233 
];
mean(data, 2)

u_A = sqrt( sum( ( size-mean_size ).^2, 2 ) / (6*5) )
u_B2 = [0.12; 0.02; 0.004]/sqrt(3)
u = sqrt(u_A.^2 + u_B2.^2)

Delta_Z = data(2, 5:8) - data(2, 1:4)
mean_Delta_Z = mean(Delta_Z )
u_Delta_Z = u2(Delta_Z, 4, 0.002)

Delta_M = data(1, 5:8) - data(1, 1:4)
mean_Delta_M = mean(Delta_M)
u_Delta_M = u2(Delta_M, 4, 0.1)

%% 霍尔法 (结果计算)
% 黄铜或铸铁
d = mean_size(1)*10^(-3)
b = mean_size(2)*10^(-3)
a = mean_size(3)*10^(-3)
Delta_M = mean_Delta_M*10^(-3);
Delta_Z = mean_Delta_Z*10^(-3);
mean_Y = d^3*Delta_M*g / (4*a^3*b*Delta_Z)

u_d = u(1)*10^(-3)
u_b = u(2)*10^(-3)
u_a = u(3)*10^(-3)
u_Delta_Z = u_Delta_Z*10^(-3)
u_Delta_M = u_Delta_M*10^(-3)
u_Y = mean_Y * sqrt( ...
    (3*u_d/d)^2 + (u_Delta_M/Delta_M)^2 + (3*u_a/a)^2 + (u_b/b)^2 + (u_Delta_Z/Delta_Z)^2 ...
)

disp(['Y = ', num2str(mean_Y, '%.3e'), ' +- ', num2str(u_Y, '%.3e')])

Y_0 = 10.55e10
eta = (mean_Y - Y_0)/Y_0*100


Y_0 = 18.15e10
eta = (mean_Y - Y_0)/Y_0*100

% 最小二乘
U = data(3, :);
Z = data(2, :);
k = sum( (U - mean(U)).*(Z - mean(Z)) ) / sum( (Z - mean(Z)).^2 )

% 作图法
[fit, ou] = Fit_linear(Z, U)
h = 1e-8
k = (fit(1.5 + h) - fit(1.5))/h


stc = MyFitPlot(fit, Z, U);
stc.label.x.String = '$Z$ (mm)';
stc.label.y.String = '$U$ (mV)';
%MyExport_pdf

%% 动态法
u_L = u1_2length(1, 0.12)   %% 单位 mm
u_d = u1_2length(0.01, 0.004)   %% 单位 mm
u_M = u1_2length(0.01, 0.01)   %% 单位 g


L = 180.0
X = [20	25	30	35	45	50	55	60]
xL = X/L
f = [592.696	589.847	588.386	587.325	586.789	587.759	588.798	590.082]
[fit, ou] = Fit_deg4(xL, f)
stc = MyFitPlot(fit, xL, f);
stc.ax.YLim = [stc.ax.YLim(1) - 0.3, stc.ax.YLim(2)];
stc.label.x.String = '$x\: /\, L$';
stc.label.y.String = '$f$ (Hz)';
%MyExport_pdf_docked
h = 10^(-6)
df = @(x) (fit(x + h) - fit(x))/h
x = fzero(df, 0.25)
vpa(x)
f_1 = fit(x)


m = 42.1e-3
L = 180e-3
d = 5.956e-3
u_M = u_M*10^(-3);
u_L = u_L*10^(-3);
u_d = u_d*10^(-3);
mean_Y = 1.6067*  L^3*m*f_1^2 / d^4
u_Y = mean_Y * sqrt( ...
     (3*u_L/L)^2 + (u_M/m)^2 + (4*u_d/d)^2   ...
)

function stc = MyFitPlot(fit, X, Y)
    stc.fig = figure('Color', [1 1 1]);
    stc.ax = axes('Parent',stc.fig, 'FontSize', 14); 
    stc.sca = MyScatter_ax(stc.ax, X, Y);
    stc.sca.scatter.scatter_1.SizeData = 100;
    stc.sca.scatter.scatter_1.MarkerEdgeColor = 'r';
    
    x_ra = (max(X) - min(X));
    x_array = linspace(min(X) - 0.05*x_ra, max(X) + 0.05*x_ra, 300);
    stc.pl = MyPlot_ax(stc.ax, x_array, fit(x_array)');
    stc.pl.plot.plot_1.LineWidth = 1;

    % 坐标轴
        stc.ax.FontName = "Times New Roman"; % 全局 FontName
        stc.ax.XGrid = 'on';
        stc.ax.YGrid = 'on';
        %stc_MyYYPlot.axes.GridLineStyle = '--';
        stc.ax.XLimitMethod = 'tight';
        stc.ax.YLimitMethod = 'tight';
        stc.ax.Box = 'on';  
        stc.label.x = xlabel(stc.ax, '$x$', 'Interpreter', 'latex', 'FontSize', 15);
        stc.label.y = ylabel(stc.ax, '$y$', 'Interpreter', 'latex', 'FontSize', 15);

    % 标题
        %stc.ax.Title.String = 'Figure: MyPlot';
        stc.ax.Title.FontSize = 17;
        stc.ax.Title.FontWeight = 'bold';

    % 图例
        stc.leg = legend(stc.ax, 'Location', 'best');
        stc.leg.FontSize = 15;
        stc.leg.Interpreter = "latex";
        stc.leg.String = ["Raw data"; "Fitted curve"];
end

function re = u2(X, n, e)
    u_A = sqrt( sum( ( X-mean(X, 2) ).^2, 2 ) / (n*(n-1)) );
    u_B2 = e/sqrt(3);
    re = sqrt(u_A.^2 + u_B2.^2);
end

function re = u1_2length(d, e)
    u_B1 = d/10;
    u_B2 = e/sqrt(3);
    re = sqrt(2*u_B1.^2 + u_B2.^2);
end
