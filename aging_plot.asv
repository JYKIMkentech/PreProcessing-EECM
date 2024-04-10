clc;clear;close all

folder_path{1} = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\4CPD 1C (25-42)\n10degC';
%folder_path{2} = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\4CPD 4C (25-42)\n10degC';
%folder_path{3} = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\1CPD 1C (25-42)\n10degC';



legend_texts = {}; % 모든 폴더에 대한 legend 항목을 저장할 셀 배열 초기화
for k = 1:length(folder_path)
    % 해당 폴더의 파일 정보를 가져와서 data 변수에 저장
   merged_files = dir(fullfile(folder_path{k}, '*Merged.mat'));



for n = 1:length(merged_files)
  % 데이터 불러오기
       fullpath_now = fullfile(folder_path{k},merged_files(n).name);
       data_now = load(fullpath_now);
       % 데이터 필드 잇는지 에러 확인
       if ~isfield(data_now, 'data_merged')
           error('File "%s" does not contain the expected variable "data".', merged_files(n).name);
       end
       data_merged = data_now.data_merged;

       %스텝별로 계산
    for l = 1:length(data_merged)
       I_1C = 0.00429; %[A]
       Vmin = 2.5; %[V]
       Vmax = 4.2;  %[V]
       cutoff_min = -0.05; %[C]
       cutoff_max = 0.05;  %[C]
       data_merged(l).Iavg = mean(data_merged(l).I); 

        

        % 각 스텝 별로 Q 계산하기
        data_merged(l).Q = trapz(data_merged(l).t,abs(data_merged(l).I))/3600;  %[Ah]
        % 각 스텝 별로 SOC 계산하기
        data_merged(l).cumQ = cumtrapz(data_merged(l).t,abs(data_merged(l).I))/3600; %[Ah]
        data_merged(l).soc = data_merged(l).cumQ/data_merged(l).Q;
        
       
       data_merged(l).OCVflag = 0;
       % OCV 스텝 찾기 (OCVflag 추가)
       if data_merged(l).rptflag == 1 && abs(Vmax - data_merged(l).V(end)) < 10e-3 && abs(cutoff_max - data_merged(l).Iavg/I_1C) < 10e-3 && data_merged(l+2).type == 'D'
          data_merged(l).OCVflag = 1;
                  
       elseif data_merged(l).rptflag == 1 && abs(Vmin - data_merged(l).V(end)) < 10e-3 && abs(cutoff_min - data_merged(l).Iavg/I_1C) < 10e-3 && data_merged(l-2).type == 'C'
          data_merged(l).OCVflag = 2;



       end 
      



    end

    fileParts = strsplit(merged_files(n).name, '_');
    newNamePart = strjoin(fileParts(end-5:end-3)); 
    legend_texts{end+1} =  newNamePart;


% 각 폴더별로 스캐터 플롯 생성

    

figure(1)
data_D = data_merged(([data_merged.type]=='D')&(abs([data_merged.Q])>0.001)&([data_merged.rptflag]==0)|([data_merged.OCVflag])==2);
scatter([data_D.cycle],abs([data_D.Q])*1000)
%ylim([2 5]);
xlabel('Cycle (n)');
ylabel('Cap (mAh)');
legend(newNamePart); hold on

figure(2)
Q_D_max = data_merged(([data_merged.type]=='D')&([data_merged.OCVflag])==2);
Q_D_max = Q_D_max(1).Q;
%ylim([0.4 1.2]);
xlabel('Cycle (n)');
ylabel('Cap / Cap0');

Q_norm  = abs([data_D.Q]) / abs(Q_D_max);
scatter([data_D.cycle],Q_norm)
legend(newNamePart);hold on;

figure(3)
data_D_t = [];
for i = 1:length(data_D)
data_D_t = [data_D_t, data_D(i).t(end)]; 
end
scatter(data_D_t/3600,Q_norm)
%ylim([0.4 1.2]);
xlabel('time (h)');
ylabel('Cap / Cap0');

legend(newNamePart);hold on;
end
end
figure(1)
legend(legend_texts);

figure(2)
legend(legend_texts);

figure(3)
legend(legend_texts);



  % legendFontSize = 16; % 적절한 폰트 크기로 변경하세요
  %   legend_handle = legend('레전드1', '레전드2', '레전드3'); % 레전드 핸들을 가져옵니다.
  %   set(legend_handle, 'FontSize', legendFontSize); % 레전드의 폰트 크기를 설정합니다.