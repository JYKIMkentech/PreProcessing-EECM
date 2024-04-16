clc;clear;close all

%% WORK FLOW

% AHC에서 역 C-RATE --> X,V 가져오기
% CHC에서 C-RATE ---> Y,V 가져오기


OCP_data = 'G:\공유 드라이브\BSL-Data\Data\Hyundai_dataset\RPT_data(Formation,OCV,DCIR,C-rate,GITT,RPT)\OCV_data\OCV2\HNE_(5)_AHC_OCV2.mat'; % OCP AHC 가져오기
%OCV_fullpath = 'G:\공유 드라이브\BSL-Data\Processed_data\Hyundai_dataset\OCV_test\CHC\25deg\[HNE_CHC_04_OCV_C20_25deg_016].mat';

OCP_data = load(OCP_data);
