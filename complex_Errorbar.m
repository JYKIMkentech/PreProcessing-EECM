clc;clear;close all

RPT_num = 6;

%% Variable name change 

% 복합인자 sample 10deg

Sample01_path = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\1CPD 4C1C(5) (25-42)\10degC\data_ocv_HNE_FCC_1CPD4C1C102542_10degC_s01_111_74_Merged.mat'; %load sample01
Sample02_path = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\1CPD 4C1C(5) (25-42)\10degC\data_ocv_HNE_FCC_1CPD4C1C102542_10degC_s02_112_75_Merged.mat'; %load sample02

% 1/4CPD 1C Sample 2개(점선) 10deg

Sample03_path = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\1CPD 1C (25-42)\10degC\data_ocv_HNE_FCC_1CPD1C2542_10degC_s01_91_50_Merged.mat'; %load sample01
Sample04_path = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\1CPD 1C (25-42)\10degC\data_ocv_HNE_FCC_1CPD1C2542_10degC_s02_92_51_Merged.mat'; %load sample02

%1/4CPD 4C sample 2개(점선) 10deg

Sample05_path = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\1CPD 4C (25-42)\10degC\data_ocv_HNE_FCC_1CPD4C2542_10degC_s01_95_55_Merged.mat'; %load sample01
Sample06_path = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\1CPD 4C (25-42)\10degC\data_ocv_HNE_FCC_1CPD4C2542_10degC_s02_96_56_Merged.mat'; %load sample02


load(Sample01_path);
load(Sample02_path);
load(Sample03_path);
load(Sample04_path);
load(Sample05_path);
load(Sample06_path);


[~,a,~] = fileparts(Sample01_path);
[~,b,~] = fileparts(Sample02_path);
[~,c,~] = fileparts(Sample03_path);
[~,d,~] = fileparts(Sample04_path);
[~,e,~] = fileparts(Sample05_path);
[~,f,~] = fileparts(Sample06_path);




eval(['data_s01' ' = ' a ';']);
eval(['data_s02' ' = ' b ';']);
eval(['data_s03' ' = ' c ';']);
eval(['data_s04' ' = ' d ';']);
eval(['data_s05' ' = ' e ';']);
eval(['data_s06' ' = ' f ';']);




%% Normalization

for j = 1:RPT_num % sample 01 normalization
    data_s01(j).LAMp = data_s01(j).LAMp/data_s01(1).Q;
    data_s01(j).LAMn = data_s01(j).LAMn/data_s01(1).Q;
    data_s01(j).LLI = data_s01(j).LLI/data_s01(1).Q;
    data_s01(j).dQ_LLI = data_s01(j).dQ_LLI/data_s01(1).Q;
    data_s01(j).dQ_LAMp = data_s01(j).dQ_LAMp/data_s01(1).Q;
    data_s01(j).dQ_data = data_s01(j).dQ_data/data_s01(1).Q;
    data_s01(j).Q_resistance = data_s01(j).Q_resistance/data_s01(1).Q;
end

for j = 1:RPT_num % sample 02 normalization
    data_s02(j).LAMp = data_s02(j).LAMp/data_s02(1).Q;
    data_s02(j).LAMn = data_s02(j).LAMn/data_s02(1).Q;
    data_s02(j).LLI = data_s02(j).LLI/data_s02(1).Q;
    data_s02(j).dQ_LLI = data_s02(j).dQ_LLI/data_s02(1).Q;
    data_s02(j).dQ_LAMp = data_s02(j).dQ_LAMp/data_s02(1).Q;
    data_s02(j).dQ_data = data_s02(j).dQ_data/data_s02(1).Q;
    data_s02(j).Q_resistance = data_s02(j).Q_resistance/data_s02(1).Q;
end

for j = 1:RPT_num % sample 02 normalization
    data_s03(j).LAMp = data_s03(j).LAMp/data_s03(1).Q;
    data_s03(j).LAMn = data_s03(j).LAMn/data_s03(1).Q;
    data_s03(j).LLI = data_s03(j).LLI/data_s03(1).Q;
    data_s03(j).dQ_LLI = data_s03(j).dQ_LLI/data_s03(1).Q;
    data_s03(j).dQ_LAMp = data_s03(j).dQ_LAMp/data_s03(1).Q;
    data_s03(j).dQ_data = data_s03(j).dQ_data/data_s03(1).Q;
    data_s03(j).Q_resistance = data_s03(j).Q_resistance/data_s03(1).Q;
end

for j = 1:RPT_num % sample 02 normalization
    data_s04(j).LAMp = data_s04(j).LAMp/data_s04(1).Q;
    data_s04(j).LAMn = data_s04(j).LAMn/data_s04(1).Q;
    data_s04(j).LLI = data_s04(j).LLI/data_s04(1).Q;
    data_s04(j).dQ_LLI = data_s04(j).dQ_LLI/data_s04(1).Q;
    data_s04(j).dQ_LAMp = data_s04(j).dQ_LAMp/data_s04(1).Q;
    data_s04(j).dQ_data = data_s04(j).dQ_data/data_s04(1).Q;
    data_s04(j).Q_resistance = data_s04(j).Q_resistance/data_s04(1).Q;
end

for j = 1:RPT_num % sample 02 normalization
    data_s05(j).LAMp = data_s05(j).LAMp/data_s05(1).Q;
    data_s05(j).LAMn = data_s05(j).LAMn/data_s05(1).Q;
    data_s05(j).LLI = data_s05(j).LLI/data_s05(1).Q;
    data_s05(j).dQ_LLI = data_s05(j).dQ_LLI/data_s05(1).Q;
    data_s05(j).dQ_LAMp = data_s05(j).dQ_LAMp/data_s05(1).Q;
    data_s05(j).dQ_data = data_s05(j).dQ_data/data_s05(1).Q;
    data_s05(j).Q_resistance = data_s05(j).Q_resistance/data_s05(1).Q;
end

for j = 1:RPT_num % sample 02 normalization
    data_s06(j).LAMp = data_s06(j).LAMp/data_s06(1).Q;
    data_s06(j).LAMn = data_s06(j).LAMn/data_s06(1).Q;
    data_s06(j).LLI = data_s06(j).LLI/data_s06(1).Q;
    data_s06(j).dQ_LLI = data_s06(j).dQ_LLI/data_s06(1).Q;
    data_s06(j).dQ_LAMp = data_s06(j).dQ_LAMp/data_s06(1).Q;
    data_s06(j).dQ_data = data_s06(j).dQ_data/data_s06(1).Q;
    data_s06(j).Q_resistance = data_s06(j).Q_resistance/data_s06(1).Q;
end


%% Make average value 

data_line = struct('LAMp',zeros(1,1),'LAMn',zeros(1,1),'LLI',zeros(1,1),'dQ_LLI',zeros(1,1),'dQ_LAMp',zeros(1,1),'dQ_data',zeros(1,1),'Q_resistance',zeros(1,1), 'cycle',zeros(1,1));
data_average_ocv = repmat(data_line,RPT_num,1);
data_average1_ocv = repmat(data_line,RPT_num,1);
data_average2_ocv = repmat(data_line,RPT_num,1);
data_average3_ocv = repmat(data_line,RPT_num,1);
data_average4_ocv = repmat(data_line,RPT_num,1);



% 복합인자 sample 2개 평균값 (실선) 

for i = 1:length(data_average_ocv)
    data_average_ocv(i).LAMp = (data_s01(i).LAMp + data_s02(i).LAMp)/2;
    data_average_ocv(i).LAMn = (data_s01(i).LAMn + data_s02(i).LAMn)/2;
    data_average_ocv(i).LLI = (data_s01(i).LLI + data_s02(i).LLI)/2;
    data_average_ocv(i).dQ_LLI = (data_s01(i).dQ_LLI + data_s02(i).dQ_LLI)/2;
    data_average_ocv(i).dQ_LAMp = (data_s01(i).dQ_LAMp + data_s02(i).dQ_LAMp)/2;
    data_average_ocv(i).dQ_data = (data_s01(i).dQ_data + data_s02(i).dQ_data)/2;
    data_average_ocv(i).Q_resistance = (data_s01(i).Q_resistance + data_s02(i).Q_resistance)/2;
    data_average_ocv(i).cycle = data_s01(i).cycle;
end

% 열화인자 sample 2개씩 평균 4개 sample 생성

for i = 1:length(data_average_ocv) % (s03 - s05)
    data_average1_ocv(i).LAMp = (data_s03(i).LAMp + data_s05(i).LAMp)/2;
    data_average1_ocv(i).LAMn = (data_s03(i).LAMn + data_s05(i).LAMn)/2;
    data_average1_ocv(i).LLI = (data_s03(i).LLI + data_s05(i).LLI)/2;
    data_average1_ocv(i).dQ_LLI = (data_s03(i).dQ_LLI + data_s05(i).dQ_LLI)/2;
    data_average1_ocv(i).dQ_LAMp = (data_s03(i).dQ_LAMp + data_s05(i).dQ_LAMp)/2;
    data_average1_ocv(i).dQ_data = (data_s03(i).dQ_data + data_s05(i).dQ_data)/2;
    data_average1_ocv(i).Q_resistance = (data_s03(i).Q_resistance + data_s05(i).Q_resistance)/2;
    data_average1_ocv(i).cycle = data_s01(i).cycle;
end

for i = 1:length(data_average_ocv) % (s03 - s06)
    data_average2_ocv(i).LAMp = (data_s03(i).LAMp + data_s06(i).LAMp)/2;
    data_average2_ocv(i).LAMn = (data_s03(i).LAMn + data_s06(i).LAMn)/2;
    data_average2_ocv(i).LLI = (data_s03(i).LLI + data_s06(i).LLI)/2;
    data_average2_ocv(i).dQ_LLI = (data_s03(i).dQ_LLI + data_s06(i).dQ_LLI)/2;
    data_average2_ocv(i).dQ_LAMp = (data_s03(i).dQ_LAMp + data_s06(i).dQ_LAMp)/2;
    data_average2_ocv(i).dQ_data = (data_s03(i).dQ_data + data_s06(i).dQ_data)/2;
    data_average2_ocv(i).Q_resistance = (data_s03(i).Q_resistance + data_s06(i).Q_resistance)/2;
    data_average2_ocv(i).cycle = data_s01(i).cycle;
end

for i = 1:length(data_average_ocv) % (s04 - s05)
    data_average3_ocv(i).LAMp = (data_s04(i).LAMp + data_s05(i).LAMp)/2;
    data_average3_ocv(i).LAMn = (data_s04(i).LAMn + data_s05(i).LAMn)/2;
    data_average3_ocv(i).LLI = (data_s04(i).LLI + data_s05(i).LLI)/2;
    data_average3_ocv(i).dQ_LLI = (data_s04(i).dQ_LLI + data_s05(i).dQ_LLI)/2;
    data_average3_ocv(i).dQ_LAMp = (data_s04(i).dQ_LAMp + data_s05(i).dQ_LAMp)/2;
    data_average3_ocv(i).dQ_data = (data_s04(i).dQ_data + data_s05(i).dQ_data)/2;
    data_average3_ocv(i).Q_resistance = (data_s04(i).Q_resistance + data_s05(i).Q_resistance)/2;
    data_average3_ocv(i).cycle = data_s01(i).cycle;
end

for i = 1:length(data_average_ocv) % (s04 - s06)
    data_average4_ocv(i).LAMp = (data_s04(i).LAMp + data_s06(i).LAMp)/2;
    data_average4_ocv(i).LAMn = (data_s04(i).LAMn + data_s06(i).LAMn)/2;
    data_average4_ocv(i).LLI = (data_s04(i).LLI + data_s06(i).LLI)/2;
    data_average4_ocv(i).dQ_LLI = (data_s04(i).dQ_LLI + data_s06(i).dQ_LLI)/2;
    data_average4_ocv(i).dQ_LAMp = (data_s04(i).dQ_LAMp + data_s06(i).dQ_LAMp)/2;
    data_average4_ocv(i).dQ_data = (data_s04(i).dQ_data + data_s06(i).dQ_data)/2;
    data_average4_ocv(i).Q_resistance = (data_s04(i).Q_resistance + data_s06(i).Q_resistance)/2;
    data_average4_ocv(i).cycle = data_s01(i).cycle;
end








% for i = 1:length(data_average_ocv)
%     data_average_ocv(i).LAMp = (data_s01(i).LAMp + data_s02(i).LAMp + data_s03(i).LAMp + data_s04(i).LAMp + data_s05(i).LAMp + data_s06(i).LAMp)/6;
%     data_average_ocv(i).LAMn = (data_s01(i).LAMn + data_s02(i).LAMn + data_s03(i).LAMn + data_s04(i).LAMn + data_s05(i).LAMn + data_s06(i).LAMn)/6;
%     data_average_ocv(i).LLI = (data_s01(i).LLI + data_s02(i).LLI + data_s03(i).LLI + data_s04(i).LLI + data_s05(i).LLI + data_s06(i).LLI)/6;
%     data_average_ocv(i).dQ_LLI = (data_s01(i).dQ_LLI + data_s02(i).dQ_LLI + data_s03(i).dQ_LLI + data_s04(i).dQ_LLI + data_s05(i).dQ_LLI + data_s06(i).dQ_LLI)/6;
%     data_average_ocv(i).dQ_LAMp = (data_s01(i).dQ_LAMp + data_s02(i).dQ_LAMp + data_s03(i).dQ_LAMp + data_s04(i).dQ_LAMp + data_s05(i).dQ_LAMp + data_s06(i).dQ_LAMp)/6;
%     data_average_ocv(i).dQ_data = (data_s01(i).dQ_data + data_s02(i).dQ_data + data_s03(i).dQ_data + data_s04(i).dQ_data + data_s05(i).dQ_data + data_s06(i).dQ_data)/6;
%     data_average_ocv(i).Q_resistance = (data_s01(i).Q_resistance + data_s02(i).Q_resistance + data_s03(i).Q_resistance + data_s04(i).Q_resistance + data_s05(i).Q_resistance + data_s06(i).Q_resistance)/6;
%     data_average_ocv(i).cycle = data_s01(i).cycle;
% end
% 

%% figure 

% Calculate standard deviation for dQ_data (c/3) and Q_resistance 

% 복합인자 실선

std_dQ_data = std(cat(3, [data_s01.dQ_data], [data_s02.dQ_data]), 1, 3);
std_dQ_data_with_resistance = std(cat(3, [data_s01.dQ_data] + [data_s01.Q_resistance], [data_s02.dQ_data] + [data_s02.Q_resistance]), 1, 3);

% 열화인자 Sample 조합 std 구하기

std_dQ_data1 = std(cat(3, [data_average1_ocv.dQ_data], [data_average2_ocv.dQ_data], [data_average3_ocv.dQ_data], [data_average4_ocv.dQ_data]), 1, 3);
std_dQ_data_with_resistance1 = std(cat(3, [data_average1_ocv.dQ_data] + [data_average1_ocv.Q_resistance], [data_average2_ocv.dQ_data] + [data_average2_ocv.Q_resistance],[data_average3_ocv.dQ_data] + [data_average3_ocv.Q_resistance],[data_average4_ocv.dQ_data] + [data_average4_ocv.Q_resistance]), 1, 3);

% Calculate mean values

mean_dQ_data = mean([data_average1_ocv.dQ_data; data_average2_ocv.dQ_data; data_average3_ocv.dQ_data; data_average4_ocv.dQ_data]);

dQ_data_1 = [data_average1_ocv.dQ_data];
Q_resistance_1 = [data_average1_ocv.Q_resistance];

dQ_data_2 = [data_average2_ocv.dQ_data];
Q_resistance_2 = [data_average2_ocv.Q_resistance];

dQ_data_3 = [data_average3_ocv.dQ_data];
Q_resistance_3 = [data_average3_ocv.Q_resistance];

dQ_data_4 = [data_average4_ocv.dQ_data];
Q_resistance_4 = [data_average4_ocv.Q_resistance];

% 각 벡터의 합계 계산
sum_1 = dQ_data_1 + Q_resistance_1;
sum_2 = dQ_data_2 + Q_resistance_2;
sum_3 = dQ_data_3 + Q_resistance_3;
sum_4 = dQ_data_4 + Q_resistance_4;

% 평균 계산
mean_dQ_data_with_resistance1 = mean([sum_1; sum_2; sum_3; sum_4]);




% Plot the stacked bar
figure();
bar([data_average_ocv.cycle], [data_average_ocv.dQ_LLI; data_average_ocv.dQ_LAMp; data_average_ocv.Q_resistance]', 'stacked');
hold on;
plot([data_average_ocv.cycle], [data_average_ocv.dQ_data], '-sc', 'LineWidth', 2); % Cyan
plot([data_average_ocv.cycle], [data_average_ocv.dQ_data] + [data_average_ocv.Q_resistance], '-sm', 'LineWidth', 2); % Magenta

% Add error bars for dQ_data (c/3) and Q_resistancedata_average_ocv.dQ_data
errorbar([data_average_ocv.cycle], [data_average_ocv.dQ_data], std_dQ_data, 'Color', [0 1 1], 'LineStyle', 'none', 'LineWidth', 1); % Cyan
errorbar([data_average_ocv.cycle], [data_average_ocv.dQ_data] + [data_average_ocv.Q_resistance], std_dQ_data_with_resistance, 'Color', [1 0 1], 'LineStyle', 'none', 'LineWidth', 1); % Magenta


% Plot mean values as points connected by a dashed line
plot([data_average_ocv.cycle], mean_dQ_data, '--oc', 'LineWidth', 1); % Cyan dashed line with circle markers
plot([data_average_ocv.cycle], mean_dQ_data_with_resistance1, '--om', 'LineWidth', 1); % Magenta dashed line with circle markers

% Add error bars for mean values
errorbar([data_average_ocv.cycle], mean_dQ_data, std_dQ_data1, 'Color', [0 1 1], 'LineStyle', 'none', 'LineWidth', 1); % Cyan error bars
errorbar([data_average_ocv.cycle], mean_dQ_data_with_resistance1, std_dQ_data_with_resistance1, 'Color', [1 0 1], 'LineStyle', 'none', 'LineWidth', 1); % Magenta error bars

% Plot mean values as points connected by a dashed line

% Add error bars for mean values

% Legend and title
legend({'Loss by LLI', 'Loss by LAMp', 'Loss by resistance', 'Loss data (c/20)', 'Loss data (c/3)'}, 'Location', 'northwest');
title('1CPD 4C(5)1C(5) (25-42) 10degC ');
ylim([0 0.6])



