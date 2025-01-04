%% Ex-06 RLC 谐振

%% 串联
U_RMS = 0.463;
U_C_RMS = 5.50;
U_L_RMS = 5.52;
U_C = sqrt(2)*U_C_RMS
U_L = sqrt(2)*U_L_RMS

Q_expe = mean([U_L_RMS, U_C_RMS])/U_RMS
f_expe = 2.2475;

R = 100;
C = 0.05e-6;
L = 0.1;
omega_ideal = 1/(sqrt(L*C))
f_ideal = 1/(2*pi*sqrt(L*C))
Q_ideal = omega_ideal*L/R

data = [
1.88	2.00	-87.23	12.6
2.00	2.00	-85.82	81.1
2.08	2.00	-83.58	215
2.15	2.00	-78.90	523
2.19	2.00	-70.30	950
2.22	2.00	-62.11	1190
2.24	2.00	-23.06	1560
2.25	2.00	8.79	1590
2.26	2.00	29.79	1540
2.275	2.00	53.98	1330
2.30	2.00	68.89	992
2.36	2.00	79.75	457
2.43	2.00	83.43	211
2.62	2.00	86.57	32.5
3.18	2.00	88.12	11.4
];

data(:, 5) = data(:, 4)/100
vpa(data(:, 5))
data = data'
%MyPrint_xlsx(data)
stc = MyYYPlot([data(1, :); data(1, :)], [data(3, :); data(5, :)]);
xline(f_expe);
stc.label.x.String = '$f$ (KHz)';
stc.label.y_left.String = "$\varphi\ (^\circ)$ ";
stc.label.y_right.String = "$I_{\max}$ (mA)";
stc.leg.Visible = 'off';

stc = MyPlot(data(1, :), data(3, :));
stc.label.x.String = '$f$ (KHz)';
stc.label.y.String = "$\varphi\ (^\circ)$ ";
%MyExport_pdf

stc = MyPlot(data(1, :), data(5, :));
stc.label.x.String = '$f$ (KHz)';
stc.label.y.String = "$I_{\max}$ (mA)";
%MyExport_pdf
yline(max(data(5, :))/sqrt(2))
BW = 2.2902-2.2118;
f_expe/BW
f_expe/Q_expe
BW  = 0.182;
2.247/BW

%% 并联
data = [
2.050	2.00	105		1.52	912
2.150	2.00	97		1.75	480
2.200	2.00	83		1.79	286
2.231	2.00	52		1.82	134
2.240	2.00	12		1.79	96.2
2.247	2.00	1		1.82	108
2.250	2.00	-14		1.80	114
2.253	2.00	-21		1.79	119
2.256	2.00	-31		1.78	121
2.265	2.00	-57		1.75	137
2.275	2.00	-93		1.74	175
2.320	2.00	-95		1.67	411
2.400	2.00	-99		1.32	762
2.600	2.00	-101	1.11	1290
];
varphi = 2*pi*data(:, 1).*data(:, 3)*10^(-3);
varphi = rad2deg(varphi);
I_max = data(:, 5)/5e3*1000;
stc = MyPlot(data(:, 1)', varphi');
stc.label.x.String = '$f$ (KHz)';
stc.label.y.String = "$\varphi\ (^\circ)$ ";
%MyExport_pdf

stc = MyPlot(data(:, 1)', I_max');
stc.label.x.String = '$f$ (KHz)';
stc.label.y.String = "$I_{\max}$ (mA)";
%MyExport_pdf

stc = MyPlot(data(:, 1)', data(:, 4)');
stc.label.x.String = '$f$ (KHz)';
stc.label.y.String = "$U_{\mathrm{amp}}$ (V)";
%MyExport_pdf

data = [data(:, 1:3), varphi, data(:, 4:5), I_max]
%MyPrint_xlsx(data, 3)


