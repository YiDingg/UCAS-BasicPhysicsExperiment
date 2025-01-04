function [fitresult, gof] = LinearFit(I_S, V_H)
%CREATEFIT(I_S,V_H)
%  创建一个拟合。
%
%  要进行 '无标题拟合 1' 拟合的数据:
%      X 输入: I_S
%      Y 输出: V_H
%  输出:
%      fitresult: 表示拟合的拟合对象。
%      gof: 带有拟合优度信息的结构体。
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 26-Nov-2024 21:15:20 自动生成


%% 拟合: '无标题拟合 1'。
[xData, yData] = prepareCurveData( I_S, V_H );

% 设置 fittype 和选项。
ft = fittype( 'poly1' );

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft );



