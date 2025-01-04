function error = func_1_1_GetError(lambda, I_data)
    a = 8.5;
    b = 3.5;
    sinc = @(x) sin(x)./x;
    alpha = @(theta) pi*a/lambda*sin(theta);
    beta = @(theta) pi*b/lambda*sin(theta);
    I_theo = @(theta) 142.8*sinc(beta(theta)).^2 .* cos(alpha(theta)).^2;
    error = sum(( I_theo(deg2rad([(-50:2:0) - 0.001, 0.001 + (0:2:50)])) - I_data ).^2);
end