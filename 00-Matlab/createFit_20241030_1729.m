function [fitresult, gof] = createFit_20241030_1729(x, y)
%CREATEFIT(X,Y)
%  创建一个拟合。
%
%  要进行 '无标题拟合 1' 拟合的数据:
%      X 输入: x
%      Y 输出: y
%  输出:
%      fitresult: 表示拟合的拟合对象。
%      gof: 带有拟合优度信息的结构体。
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 30-Oct-2024 17:28:37 自动生成


%% 拟合: '无标题拟合 1'。
[xData, yData] = prepareCurveData( x, y );

% 设置 fittype 和选项。
ft = fittype( 'y_0+A_1*exp(-(x-x_0)/t_1)+A_2*exp(-(x-x_0)/t_2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0.0001 0.01 2 0    0   0];
opts.Upper = [2     100  50 300 1000 20];
opts.MaxFunEvals = 2000;
opts.Robust = 'LAR';
opts.StartPoint = [0.58 0.35 12.7 73 0.4 11];


% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );

%{
% 绘制数据拟合图。
figure( 'Name', '无标题拟合 1' );
h = plot( fitresult, xData, yData );
legend( h, 'y vs. x', '无标题拟合 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
xlabel( 'x', 'Interpreter', 'none' );
ylabel( 'y', 'Interpreter', 'none' );
grid on
%}


