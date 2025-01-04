%% Parameters
Ms=1.6e6;
a=1100;
alpha=1.6e-3;
k=400;
c=0.2;
Ho=[0:60:6000 6000:-60:-6000 -6000:60:6000]';
Mw = zeros(length(Ho),1);
Hw = zeros(length(Ho),1);
Hw(1) = Ho(1);
M0 = 0;
Mw(1) = M0;
Mu0 = 4*pi*1e-7;
%% Solver
im = 1;
in = 2;
while in < length(Ho)
    if Ho(im) < Ho(in)
        if Ho(in)<=Ho(in+1)
            in = in + 1;
        else
            if Ho(in)==Ho(im)
                H1=[Ho(in) Ho(im)]';
                M1=[M0 M0]';
            else
                options=odeset('RelTol',1e-4,'AbsTol',1e-6,'MaxStep',abs(Ho(in)-Ho(im))./10,'InitialStep',(Ho(in)-Ho(im))./10);
                dM_dH_ = @(H, M) dM_dH_Fcn(a, k, c, Ms, alpha, H, M, Ho(im), Ho(in));
                [H1, M1] = ode45(dM_dH_, [Ho(im) Ho(in)], M0, options);                  
            end
            if length(M1)>2
                Mw(im+1:in) = interp1(H1,M1,Ho(im+1:in),'pchip');
            else
                Mw(im+1) = M1(end);
            end
            Hw(im+1:in) = Ho(im+1:in);
            M0 = M1(end);
            im = in;
            in = in+1;
        end
    end
    if Ho(im) > Ho(in)
        if Ho(in)>=Ho(in+1)
            in = in + 1;
        else
            if Ho(in)==Ho(im)
                H1=[Ho(in) Ho(im)]';
                M1=[M0 M0]';
            else
                options=odeset('RelTol',1e-4,'AbsTol',1e-6,'MaxStep',abs(Ho(in)-Ho(im))./10,'InitialStep',(Ho(in)-Ho(im))./10);
                dM_dH_ = @(H, M) dM_dH_Fcn(a, k, c, Ms, alpha, H, M, Ho(im), Ho(in));
                [H1, M1] = ode45(dM_dH_, [Ho(im) Ho(in)], M0, options);                  
            end
            if length(M1)>2
                Mw(im+1:in) = interp1(H1,M1,Ho(im+1:in),'pchip');
            else
                Mw(im+1) = M1(end);
            end
            Hw(im+1:in) = Ho(im+1:in);
            M0 = M1(end);
            im = in;
            in = in+1;
        end
    end
    if Ho(im)==Ho(in)
        in = in+1;
    end
end
if Ho(in)==Ho(im)
    H1=[Ho(in) Ho(im)]';
    M1=[M0 M0]';
else
    options=odeset('RelTol',1e-4,'AbsTol',1e-6,'MaxStep',abs(Ho(in)-Ho(im))./10,'InitialStep',(Ho(in)-Ho(im))./10);
    dM_dH_ = @(H, M) dM_dH_Fcn(a, k, c, Ms, alpha, H, M, Ho(im), Ho(in));
    [H1, M1] = ode45(dM_dH_, [Ho(im) Ho(in)], M0, options);                  
end
if length(M1)>2
    Mw(im+1:in) = interp1(H1,M1,Ho(im+1:in),'pchip');
else
    Mw(im+1) = M1(end);
end
Hw(im+1:in) = Ho(im+1:in);
M0 = M1(end);
Bw = Mu0*(Hw+Mw);
plot(Hw,Bw)

function dM_dH = dM_dH_Fcn(a, k, c, Ms, alpha, H, M, Hstart, Hend)
He = H + alpha*M;
if He == 0
    He = 1;  %消除奇异点
    Man = 0; %消除奇异点
else
    Man = Ms.*(coth(He./a)-a./He);
end
if Hstart > Hend
    delta = -1;
else
    delta = 1;
end
dMan_dH = Ms.*(coth((He+1e-6)./a)-a./(He+1e-6)-coth((He-1e-6)./a)+a./(He-1e-6))./2e-6;
dM = Man-M;

dM_dH = dM./(1+c)./(delta.*k-alpha.*dM) + c./(1+c).*dMan_dH;
end