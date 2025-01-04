function [fitresult, gof] = Ex_8_HysteresisLoopFitting(H, B)
%CREATEFIT(H,B_1)
%  创建一个拟合。
%
%  要进行 '无标题拟合 1' 拟合的数据:
%      X 输入: H
%      Y 输出: B_1
%  输出:
%      fitresult: 表示拟合的拟合对象。
%      gof: 带有拟合优度信息的结构体。
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 23-Oct-2024 00:37:54 自动生成


%% 拟合: '无标题拟合 1'。
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

% 绘制数据拟合图。
%figure( 'Name', '无标题拟合 1' );
%h = plot( fitresult, xData, yData );
%legend( h, 'B_1 vs. H', '无标题拟合 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
%xlabel( 'H', 'Interpreter', 'none' );
%ylabel( 'B_1', 'Interpreter', 'none' );
%grid on


