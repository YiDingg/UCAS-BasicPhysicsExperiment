%% Ex_03 弦上驻波

%% 表 2. 波速的测量
clc, clear, close all
mu = 3.662e-3;
m = 508.02e-3;
L = 480e-3;
g = 9.83;

n = [
2
3
4
]
f = [
38.33	76.84	116.40
49.25	98.73	148.24
56.56	113.21	169.87
]

for i = 1:3
    V_ex(:, i) = 2*L*f(:, i)/i
end
v_expe = mean(V_ex, 2)

v_theo = sqrt(0.5*n*m*g/mu)

eta = MyGet_eta(v_expe, v_theo)
eta*100

L = 480e-3;
T = 0.5*n*m*g

%% 表 3. 基频和有效长度的关系
L = [640	480	320	240	160]
f = [29.16	39.28	58.90	85.71	130.46
]
ln_L = log(L)
ln_f = log(f)

[L; f; ln_L; ln_f]

[stc, fit, out] = MyFit_linear(ln_L, ln_f);
stc.label.x.String = '$\ln L$ (m)';
stc.label.y.String = '$\ln f$ (Hz)';
fit
%MyExport_pdf_docked

%% 表 4. 频率与张力的关系
n = [1 2 3 4 5]
T = 0.5*n*m*g
f = [36.07	51.04	61.76	71.93	79.71
]
[T; f; log(T); log(f)]

[stc, fit, out] = MyFit_linear(log(T), log(f));
stc.label.x.String = '$\ln T$ (N)';
stc.label.y.String = '$\ln f$ (Hz)';
fit
%MyExport_pdf_docked

%% 表 5. 频率与线密度
n = [6 1 3 7 4 10 9]
mu = [3.66	4.93	5.60	3.50	0.465	3.833	3.386];
f = [61.76	48.15	51.75	58.51	131.21	59.35	63.48
]


MyScatter(log(mu), log(f))

exp(-0.0555)

[stc, fit, out] = MyFit_linear(log(mu), log(f))
stc.label.x.String = '$\ln \mu\ (\mathrm{g\cdot m^{-1}})$ ';
stc.label.y.String = '$\ln f$ (Hz)';
fit
%MyExport_pdf_docked

n = [6 1 3 7 10 9]
mu = [3.66	4.93	5.60	3.50		3.833	3.386];
f = [61.76	48.15	51.75	58.51		59.35	63.48
]


MyScatter(log(mu), log(f))

exp(-0.0555)

[stc, fit, out] = MyFit_linear(log(mu), log(f))
stc.label.x.String = '$\ln \mu\ (\mathrm{g\cdot m^{-1}})$ ';
stc.label.y.String = '$\ln f$ (Hz)';
fit
%MyExport_pdf_docked

%% 表 6. 驻波法和相位法
L = [24.423	28.808	33.315	37.854	42.221	46.557	50.920	55.031	59.542	63.753
];
f = 40e3;

lambda = sum( 2*( L( (1:5) + 5 ) - L(1:5) )/5  ) / 5
v_expe = lambda/1000*f
v_0 = 331.45;
t = 28;
v_theo = v_0*sqrt( 1 + t/273.15 )
MyGet_eta(v_theo, v_expe);

% 
L = [37.976	46.697	55.512	63.862	72.733	81.501	90.202	99.220	107.541	116.421
];
f = 40e3;

lambda = sum( ( L( (1:5) + 5 ) - L(1:5) )/5  ) / 5
v_expe = lambda/1000*f
v_0 = 331.45;
t = 28;
v_theo = v_0*sqrt( 1 + t/273.15 )
MyGet_eta(v_theo, v_expe);

%% 表 7. 水中波速
L = [53.899	54.698	55.417	56.440	57.310	57.997	58.792	59.671	60.580	61.452];
f = 1.8e6;

lambda = sum( ( L( (1:5) + 5 ) - L(1:5) )/5  ) / 5
v_expe = lambda/1000*f
v_0 = 331.45;
t = 28;
v_theo = v_0*sqrt( 1 + t/273.15 )
MyGet_eta(v_theo, v_expe);

vpa(v_expe)
