clear; clc; close all;

I_1C = 0.00429;

%RPT 순서 : OCV - DCIR - Crate - GITT


load('G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\4CPD 1C (25-42)\25degC\HNE_FCC_4CPD 1C (25-42)_25degC_s01_6_6_RPT1.mat'); %RPT_file

data1.t = vertcat(data(1:end).t);
data1.V = vertcat(data(1:end).V);
data1.I = vertcat(data(1:end).I);

% figure
% hold on
% plot(data1.t/3600,data1.V);
% xlabel('time (hours)')
% ylabel('voltage (V)')
%         
% yyaxis right
% plot(data1.t/3600,data1.I/I_1C)
% yyaxis right
% ylabel('current (C)')

data_ocv = data(1:6); % OCV = 1부터 6번째 struct 
data_dcir = data(7:164);
data_rate = data(165:178); % DCIR 후 rest 2시간 --> ocv 돌입 가정, 

% OCV (C/20)

step_ocv_chg = 4;
step_ocv_dis = 6;


for i = 1:length(data_ocv)

    data_ocv(i).Q = abs(trapz(data_ocv(i).t, data_ocv(i).I))/3600;
    data_ocv(i).cumQ = abs(cumtrapz(data_ocv(i).t,data_ocv(i).I))/3600;
end

data_ocv(step_ocv_chg).SOC = data_ocv(step_ocv_chg).cumQ/data_ocv(step_ocv_chg).Q;
data_ocv(step_ocv_dis).SOC = 1 - data_ocv(step_ocv_dis).cumQ/data_ocv(step_ocv_dis).Q;

% C-rate


% rate marking --> 자동화 추후 예정

Q_ocv = data_ocv(4).Q; % ocv 실험에서 얻은 Q 기준

crate_chg_vec = [0.5 1 2 4];
step_crate_chg = [2 6 10 14];

data_rate(2).mark = 0.5;
data_rate(6).mark = 1;
data_rate(10).mark = 2;
data_rate(14).mark = 4;

% soc 추정 

for i = 1:length(data_rate)

    data_rate(i).Q = abs(trapz(data_rate(i).t, data_rate(i).I))/3600;
    data_rate(i).cumQ = abs(cumtrapz(data_rate(i).t,data_rate(i).I))/3600;
end

for n = 1:length(step_crate_chg)

    k = step_crate_chg(n);
    [x_uniq,ind_uniq] = unique(data_ocv(step_ocv_chg).V); % 중복된 Voltage 제거
    y_uniq = data_ocv(step_ocv_chg).SOC(ind_uniq); % 중복이 제거된 voltage에 match 되는 soc 추출 (ocv - soc 관계)
    
    soc0 = interp1(x_uniq,y_uniq,data_rate(k-1).V(end),'linear','extrap'); % charge rate 직전 rest 마지막 voltage 기준
    if soc0 < 0
        soc0 = 0;
    end
    data_rate(k).soc = soc0 + data_rate(k).cumQ/Q_ocv;
end

%% RR struct 만들기

% R = (V-OCV)/I, soc는 rate 기준으로 맞추기




















