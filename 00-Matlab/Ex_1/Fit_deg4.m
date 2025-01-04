function [fitresult, gof] = Fit_deg4(xL, F)
%CREATEFIT(XL,F)
%  创建一个拟合。
%
%  要进行 '无标题拟合 1' 拟合的数据:
%      X 输入: xL
%      Y 输出: F
%  输出:
%      fitresult: 表示拟合的拟合对象。
%      gof: 带有拟合优度信息的结构体。
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 13-Nov-2024 00:38:25 自动生成


%% 拟合: '无标题拟合 1'。
[xData, yData] = prepareCurveData( xL, F );

% 设置 fittype 和选项。
ft = fittype( 'poly4' );
opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Robust = 'Bisquare';

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );




