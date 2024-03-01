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
data_rate = data(165:178);

% OCV 

step_ocv_chg = 4;
step_ocv_dis = 6;


for i = 1:length(data_ocv)

    data_ocv(i).Q = abs(trapz(data_ocv(i).t, data_ocv(i).I))/3600;
    data_ocv(i).cumQ = abs(cumtrapz(data_ocv(i).t,data_ocv(i).I))/3600;
end

data_ocv(step_ocv_chg).SOC = data_ocv(i).cumQ/data_ocv(i).Q;
data_ocv(step_ocv_dis).SOC = 1 - data_ocv(i).cumQ/data_ocv(i).Q;










