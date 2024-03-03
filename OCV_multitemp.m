
clc;
clear;
close all;

% 온도 데이터 정의
Temperature = [25 30 35 40 45];

% 데이터 폴더 경로 설정
data_folder = 'G:\공유 드라이브\BSL-Data\Data\Hyundai_dataset\RPT_data(Formation,OCV,DCIR,C-rate,GITT,RPT)\OCV_data\OCV2\HNE_(6)_FCC_OCV2';

[save_folder, save_name] = fileparts(data_folder);

full_path = [data_folder '.mat'];

load(full_path);


% 기존 데이터
soc_25 = OCV_golden.OCVchg(:, 1);
ocv_25 = OCV_golden.OCVchg(:, 2);
capacity = OCV_golden.OCVchg(:, 3);

% 새로운 온도 정의
new_temperatures = [30 35 40 45];

% 각 온도에 대한 노이즈 추가된 데이터 생성
Tem_data = struct();
for i = 1:length(new_temperatures)
    % 온도에 따라 노이즈의 크기를 증가시킴 (0.5%에서 시작하여 0.5%씩 증가)
    noise_percentage = 0.05 + 0.05 * (i - 1);
    
    % 새로운 노이즈 생성 (임의로 설정한 예시 값)
    new_noise = sin(linspace(0, 2*pi, numel(soc_25))) * noise_percentage * range(soc_25);
    
    % soc에 노이즈 추가
    new_soc = max(0, min(1, soc_25 + new_noise'));
    
    % ocv에 노이즈 추가 (soc에 따라 증가하는 경향을 더함)
    soc_ocv_relation = 0.1; % soc에 따른 ocv 변화 비율
    new_ocv = ocv_25 + soc_ocv_relation * new_soc + new_noise';
    
    % capacity는 변하지 않음
    new_capacity = capacity;
    
    % 새로운 구조체에 저장
    field_name = sprintf('OCV_%d_degrees', new_temperatures(i));
    Tem_data.(field_name) = struct('soc', new_soc, 'ocv', new_ocv, 'capacity', new_capacity);
end

% 보간된 데이터를 저장할 구조체 초기화
interpolated_data = struct();

% 각 온도에서의 SOC-OCV 보간 수행
for i = 1:length(new_temperatures)
    current_temperature = new_temperatures(i);
    
    % 현재 온도에서의 SOC 및 OCV 데이터 가져오기
    current_soc = Tem_data.(['OCV_' num2str(current_temperature) '_degrees']).soc;
    current_ocv = Tem_data.(['OCV_' num2str(current_temperature) '_degrees']).ocv;
    
    % 25도에서의 SOC-OCV 데이터를 기반으로 보간
    interpolated_ocv = interp1(current_soc, current_ocv, soc_25, 'linear', 'extrap');
    
    % 결과를 구조체에 저장
    field_name = sprintf('OCV_%d_degrees', current_temperature);
    interpolated_data.(field_name) = struct('soc', soc_25, 'ocv', interpolated_ocv);
end

ocv_tem_group = zeros(length(soc_25), length(Temperature));

% Add ocv_25 as the first column
ocv_tem_group(:, 1) = ocv_25;

for i = 1:length(new_temperatures)
    current_temperature = new_temperatures(i);
    
    % Extract OCV data for the current temperature
    ocv_data = Tem_data.(['OCV_' num2str(current_temperature) '_degrees']).ocv;
    
    % Store OCV data in the matrix
    ocv_tem_group(:, i + 1) = ocv_data;
end

OCV = struct();
OCV.Temp = Temperature;
OCV.SOC = sort(soc_25, 'descend');
OCV.OCV = sort(ocv_tem_group, 'descend');

















%load('G:\공유 드라이브\BSL-Data\Data\Hyundai_dataset\RPT_data(Formation,OCV,DCIR,C-rate,GITT,RPT)\OCV_data\OCV2\HNE_(6)_FCC_OCV2.mat');
