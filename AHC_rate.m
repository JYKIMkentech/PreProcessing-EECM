clc;clear;close all

data_folder = 'G:\공유 드라이브\BSL-Data\Processed_data\Hyundai_dataset\RPT_GITT제외\HNE_AHC_(3)_RPT\[HNE_AHC_RPT_01_043].mat';
%OCV_fullpath = 'G:\공유 드라이브\BSL-Data\Processed_data\Hyundai_dataset\OCV_test\CHC\25deg\[HNE_CHC_04_OCV_C20_25deg_016].mat';

load(data_folder);
I_1C = 0.0043;
ocp_index = [];

Rate_vec = [-0.5 -1 -2 -4 -6];

%% OCP, Rate flag 설정

% OCP flag 설정
for i = 1 : length(data)
    data(i).I = data(i).I;
    data(i).avgI = mean([data(i).I]);
    if abs(abs(data(i).I/I_1C)-0.05)<0.01
        ocp_index= [ocp_index,i];
        
    end    
end

for j = 1:length(ocp_index)
       data(ocp_index(j)).OCPflag = 0.05;
end

data_ocp = data(20:23);


% Rate flag 설정

% 수동

Rate_index = [142 146 150 154 158]; %[-0.5 -1 -2 -4 -6]
for j = 1:length(Rate_index)
       data(Rate_index(j)).Rateflag = Rate_vec(j);
end

data_rate = data(142:158);


%% [x,Va], [y,Vc] 구하기
% x --> soc, y --> (1-y1)soc

%from ocp

data_ocp(1).Q = abs(trapz(data_ocp(1).t,data_ocp(1).I))/3600; %[Ah] % discharge 기준
data_ocp(1).cumQ = abs(cumtrapz(data_ocp(1).t,data_ocp(1).I))/3600; %[Ah]

data_ocp(1).stoic = data_ocp(1).cumQ/data_ocp(1).Q;

%from c-rate

for i = 1:length(data_rate)
    if length(data_rate(i).t) > 1
        data_rate(i).Q = abs(trapz(data_rate(i).t,data_rate(i).I))/3600; %[Ah] % discharge 기준
        data_rate(i).cumQ = abs(cumtrapz(data_rate(i).t,data_rate(i).I))/3600; %[Ah]
        data_rate(i).stoic = data_rate(i).cumQ/data_rate(i).Q;


    else
         data_rate(i).Q = 0;
         data_rate(i).cumQ = 0;
         data_rate(i).stoic = 1;
    end
    

end

%% Make RR struct

RR.anode{1,1} = [data_ocp(1).V, data_ocp(1).stoic]; %ocp
for j = 1:length(Rate_index)
RR.anode{1,2} = 
end











% data1.I = vertcat(data.I);
% data1.V = vertcat(data.V);
% data1.t = vertcat(data.t);
% 
% figure
% plot(data1.t/3600, data1.V, '-')
% xlabel('time (hours)')
% ylabel('voltage (V)')
% yyaxis right
% plot(data1.t/3600, data1.I, '-')
% ylabel('current (C)')

% 
% % AHC에서 역 C-RATE --> X,V 가져오기
% % CHC에서 C-RATE ---> Y,V 가져오기

