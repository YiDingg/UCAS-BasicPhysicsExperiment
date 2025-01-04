function [fitresult, gof] = Fit_HAndB(H, B)

[xData, yData] = prepareCurveData( H, B );

% 设置 fittype 和选项。
ft = fittype( 'a*atan(b*x+c)+d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.DiffMaxChange = 0.1;
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [0.496537318440195 0.308971081219392 0.8508 0.98199328087302];

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );

