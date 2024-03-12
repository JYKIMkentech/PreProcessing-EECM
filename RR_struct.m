clear; clc; close all;

I_1C = 0.00429;

%RPT 순서 : OCV - DCIR - Crate - GITT


load('G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\4CPD 1C (25-42)\25degC\HNE_FCC_4CPD 1C (25-42)_25degC_s01_6_6_RPT1.mat'); %RPT_file

load('G:\공유 드라이브\Battery Software Lab\Models\EECM\example_1\example1_RRmodel.mat') % dummy data

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
    data_rate(k).soc = soc0 + data_rate(k).cumQ/Q_ocv; % 분모 = ocv RPT 에서 얻은 Q 값
end

%% RR struct 만들기

% Rss = [V(soc)-OCV(soc)]/I, soc는 rate 기준으로 맞추기

for n = 1:length(crate_chg_vec)

    k = step_crate_chg(n);
    data_rate(k).OCV_rate = interp1(data_ocv(4).SOC, data_ocv(4).V, data_rate(k).soc,'linear','extrap');
    data_rate(k).Rss = [data_rate(k).V - data_rate(k).OCV_rate]/mean(data_rate(k).I);

end

% DataBank 만들기
BSL_DataBank = struct();
Rate_grid = [0, crate_chg_vec]; 
Temp_grid = [25; 35; 45]; % 추후 자동화 예정

Rss = cell(1,length(Rate_grid)); % 온도 자동화 이후 --> cell(length(Temp_grid),length(Rate_grid)); 

%step_crate_chg

Rss{1,1} = [data_rate(step_crate_chg(1)).soc, data_rate(step_crate_chg(1)).Rss] ;

for n = 1:length(crate_chg_vec) 
    
    k = step_crate_chg(n);
    Rss{1,n+1} = [data_rate(k).soc, data_rate(k).Rss] ;
end

%% Dummy Data --> BSl DataBank로 맞추기


m = [1,6,11,19];

for i = 1:length(Temp_grid)
    for j = 1:length(m)
    BSL_DataBank.Vref{i,j} = DataBank.Vref{i,m(j)};
    BSL_DataBank.V{i,j} = DataBank.V{i,m(j)};
    BSL_DataBank.Rss_discharge(i,j) = DataBank.Rss_discharge(i,m(j));
    end
end
% 
% Rss{2,1} = Rss{1,1};
% Rss{3,1} = Rss{1,1};
% Rss{2,2} = Rss{1,2};
% Rss{3,2} = Rss{1,2};
% Rss{2,3} = Rss{1,3};
% Rss{3,3} = Rss{1,3};
% Rss{2,4} = Rss{1,4};
% Rss{3,4} = Rss{1,4};

Rss = Rss([1:4]);

Rate_grid = [0 0.5 1 2];

% 202403 ver BSL 추가된 DataBank
BSL_DataBank.Rate_grid = Rate_grid;
BSL_DataBank.Temp_grid = Temp_grid;
BSL_DataBank.Rss = Rss;
BSL_DataBank.I_1C = repmat(I_1C,1,length(Temp_grid));

% 기존 DataBank
%BSL_DataBank.Rss_discharge = DataBank.Rss_discharge;
%BSL_DataBank.V = DataBank.V;
BSL_DataBank.Qmax = repmat(Q_ocv,1,length(Temp_grid));
BSL_DataBank.Vtop = DataBank.Vtop;
BSL_DataBank.Rss = repmat(BSL_DataBank.Rss,length(Temp_grid),1);

%% 파일 저장

save_folder = 'G:\공유 드라이브\BSL_Data2\Models\EECM\Hyundai_dataSet';

save([save_folder filesep 'BSL_DataBank.mat'], 'BSL_DataBank');














  












