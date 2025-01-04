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


