clc;clear;close all

folder_path = 'G:\공유 드라이브\BSL_Data2\HNE_AgingDOE_Processed\HNE_FCC\4CPD 1C (25-42)\25degC';
merged_files = dir(fullfile(folder_path, '*Merged.mat'));


for n = 1:length(merged_files)
       fullpath_now = fullfile(folder_path,merged_files(n).name);
       data_now = load(fullpath_now);
       if ~isfield(data_now, 'data_merged')
           error('File "%s" does not contain the expected variable "data".', merged_files(n).name);
       end
       data_merged = data_now.data_merged;
         for l = 1:length(data_merged)
               I_1C = 0.00429; %[A]
               Vmin = 2.5; %[V]
               Vmax = 4.2;  %[V]
               cutoff_min = -0.05; %[C]
               cutoff_max = 0.05;  %[C]
               data_merged(l).Iavg = mean(data_merged(l).I); 
               data_merged(l).Q = trapz(data_merged(l).t,abs(data_merged(l).I))/3600;  %[Ah]  
               data_merged(l).cumQ = cumtrapz(data_merged(l).t,abs(data_merged(l).I))/3600; %[Ah]
               data_merged(l).soc = data_merged(l).cumQ/data_merged(l).Q;
               data_merged(l).OCVflag = 0;
         
                   % find ocv step (OCVflag 추가)
                   if data_merged(l).rptflag == 1 && abs(Vmax - data_merged(l).V(end)) < 10e-3 && abs(cutoff_max - data_merged(l).Iavg/I_1C) < 10e-3 && data_merged(l+2).type == 'D'
                      data_merged(l).OCVflag = 1;                    
                   elseif data_merged(l).rptflag == 1 && abs(Vmin - data_merged(l).V(end)) < 10e-3 && abs(cutoff_min - data_merged(l).Iavg/I_1C) < 10e-3 && data_merged(l-2).type == 'C'
                      data_merged(l).OCVflag = 2;
                   end 
         end
end

%% make Q_resistance 

% Discharge aging , OCV discharge 구조체 가져오기  
data_D = data_merged(([data_merged.type]=='D')&(abs([data_merged.Q])>0.001)&([data_merged.rptflag]==0)|([data_merged.OCVflag])==2);
indices = find([data_D.OCVflag]==2);

% first Q_resistance = ocv(c/20) - 뒷쪽 aging 1c Q
Q_resistance = [];
Q_resistance(1) = data_D(1).Q - data_D(2).Q ;

% 나머지 Q_resistance = ocv(c/20) - 앞쪽 aging 1c Q

% for 1 : length(indices)
% 
% 
% end




