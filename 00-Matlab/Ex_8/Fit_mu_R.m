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