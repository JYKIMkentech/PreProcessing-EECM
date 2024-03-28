clc;clear;close all

data_folder = 'G:\공유 드라이브\BSL-Data\Processed_data\Hyundai_dataset\RPT_GITT제외\HNE_AHC_(3)_RPT\[HNE_AHC_RPT_01_043].mat';
%OCV_fullpath = 'G:\공유 드라이브\BSL-Data\Processed_data\Hyundai_dataset\OCV_test\CHC\25deg\[HNE_CHC_04_OCV_C20_25deg_016].mat';

load(data_folder);

I_1C = 0.0043;

data1.I = vertcat(data.I);
data1.V = vertcat(data.V);
data1.t = vertcat(data.t);

figure
plot(data1.t/3600, data1.V, '-')
xlabel('time (hours)')
ylabel('voltage (V)')
yyaxis right
plot(data1.t/3600, data1.I/I_1C, '-')
ylabel('current (C)')


% AHC에서 역 C-RATE --> X,V 가져오기
% CHC에서 C-RATE ---> Y,V 가져오기

