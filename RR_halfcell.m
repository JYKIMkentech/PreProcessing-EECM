clc;clear;close all

% id_cfa = 1; % 1 = anode, 2 = cathode

I_1C = 0.0047;
ocp_index = [];
    
Rate_grid = [-0.5   -1  -2  -4  -6];
rate_vec =  [1      5    9  13  17];
Temp_grid =[25 35 45];
C_rate = [0 0.5 1 2];


x0 = 1.098e-09;
Q_n = 0.00562;
y0 = 0.88398;
Q_p = 0.00701568;
Q_cell = 0.004646;

x1 = x0 + Q_cell/Q_n;

y1 = y0 - Q_cell/Q_p;

% y1 = 0.215685;

for k = 1:2

    if k == 1

       % if id_cfa == 1
        
        
            data_folder = 'G:\공유 드라이브\BSL-Data\Processed_data\Hyundai_dataset\RPT_GITT제외\HNE_AHC_(3)_RPT\[HNE_AHC_RPT_01_043].mat';
        
        
            load(data_folder);
           
            
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
                   data(Rate_index(j)).Rateflag = Rate_grid(j);
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
            
            RR.grid = [0, Rate_grid];
            RR.anode{1,1} = [data_ocp(1).stoic,data_ocp(1).V]; %ocp
            for j = 2:length(Rate_index)+1
            RR.anode{1,j} = [data_rate(rate_vec(j-1)).stoic, data_rate(rate_vec(j-1)).V];
            end
        %end


    elseif k==2
       % elseif id_cfa ==2
             data_folder = 'G:\공유 드라이브\BSL-Data\Processed_data\Hyundai_dataset\RPT_GITT제외\HNE_CHC_(4)_RPT\[HNE_CHC_RPT_01_033].mat';
             load(data_folder);
                
             % OCP flag 설정
             for i = 1 : length(data)
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
            
            Rate_index = [110 114 118 122 126]; %[-0.5 -1 -2 -4 -6]
            for j = 1:length(Rate_index)
                   data(Rate_index(j)).Rateflag = -Rate_grid(j);
            end
            
            data_rate = data(110:126);
            data_ocp(1).Q = abs(trapz(data_ocp(1).t,data_ocp(1).I))/3600; %[Ah] % discharge 기준
            data_ocp(1).cumQ = abs(cumtrapz(data_ocp(1).t,data_ocp(1).I))/3600; %[Ah]
            
            data_ocp(1).soc = data_ocp(1).cumQ/data_ocp(1).Q;
            data_ocp(1).stoic = 1-(1-y1)*data_ocp(1).soc;
            
            %from c-rate
            
            for i = 1:length(data_rate)
                if length(data_rate(i).t) > 1
                    data_rate(i).Q = abs(trapz(data_rate(i).t,data_rate(i).I))/3600; %[Ah] % discharge 기준
                    data_rate(i).cumQ = abs(cumtrapz(data_rate(i).t,data_rate(i).I))/3600; %[Ah]
                    data_rate(i).soc = data_rate(i).cumQ/data_rate(i).Q;
                    data_rate(i).stoic = 1-(1-y1)*data_rate(i).soc;
                  
                  
            
                else
                     data_rate(i).Q = 0;
                     data_rate(i).cumQ = 0;
                     data_rate(i).stoic = y1;
                end
        
            end
        
             %% Make RR struct
            
            RR.grid = [0, -Rate_grid];
            RR.cathode{1,1} = [data_ocp(1).stoic,data_ocp(1).V]; %ocp
            for j = 2:length(Rate_index)+1
                RR.cathode{1,j} = [data_rate(rate_vec(j-1)).stoic, data_rate(rate_vec(j-1)).V];
            end

   end
end

%% RR - SOC 맞추기

RR_folder = 'G:\공유 드라이브\BSL_Data2\Models\EECM\Hyundai_dataSet';

load([RR_folder filesep 'BSL_DataBank.mat'], 'BSL_DataBank');

for i = 1:length(Rate_grid)+1
    x = RR.anode{1,i}(:,1);
    RR.anode{1,i}(:,3) = (x - x0)/(x1-x0); % X에 해당하는 soc (anode)
    y = RR.cathode{1,i}(:,1);
    RR.cathode{1,i}(:,3) = (y - y0)/(y1-y0); % y에 해당하는 soc (cathode)
    
end
for i = 1 : length(BSL_DataBank.Rate_grid)
    BSL_DataBank.Va{1,i}(:,1) = BSL_DataBank.V{1,i}(:,1);
    BSL_DataBank.Va{1,i}(:,2) = interp1(RR.anode{1,i}(:,3),RR.anode{1,i}(:,2),BSL_DataBank.V{1,i}(:,1),'linear','extrap'); % soc_fc기준 Va
    BSL_DataBank.Vc{1,i}(:,1) = BSL_DataBank.V{1,i}(:,1);
    BSL_DataBank.Vc{1,i}(:,2) = interp1(RR.cathode{1,i}(:,3),RR.cathode{1,i}(:,2),BSL_DataBank.V{1,i}(:,1),'linear','extrap'); %soc_fc 기준 Vc

end

%% check point [soc_fc, Va, Vc- Va] 맞는지 확인 
for i = 1 : length(BSL_DataBank.Rate_grid)
    RR.Vref{1,i}(:,1) =  BSL_DataBank.V{1,i}(:,1); % soc_fc
    RR.Vref{1,i}(:,2) =  BSL_DataBank.Va{1,i}(:,2); % Va
    RR.Vref{1,i}(:,3) =  BSL_DataBank.Vc{1,i}(:,2) - BSL_DataBank.Va{1,i}(:,2); %Vc-Va

end

BSL_DataBank.Vref = RR.Vref;
BSL_DataBank.Vref = repmat(BSL_DataBank.Vref,length(Temp_grid),1);






%% C-rate 별 Vref, Vcat- Vref plot
figure(1)
C_rate = [0 0.5 1 2];
for j = 1:length(C_rate)
    plot(BSL_DataBank.Vref{1,j}(:,1), BSL_DataBank.Vref{1,j}(:,2));
    hold on
end

title('Vref')
legendCell = cellstr(num2str(C_rate', 'C-rate = %0.1f'));
legend(legendCell);

figure(2)
for j = 1:length(C_rate)
    plot(BSL_DataBank.Vref{1,j}(:,1), BSL_DataBank.Vref{1,j}(:,3));
    hold on
end

title('Vc-Vref')
legendCell = cellstr(num2str(C_rate', 'C-rate = %0.1f'));
legend(legendCell);
















% data1.I = vertcat(data.I);
% data1.V = vertcat(data.V);
% data1.t = vertcat(data.t);
% 
% figure
% plot(data1.t/3600, data1.V, '-')
% xlabel('time (hours)')
% ylabel('voltage (V)')
% yyaxis right
% plot(data1.t/3600, data1.I/I_1C, '-')
% ylabel('current (C)')

% 
% % AHC에서 역 C-RATE --> X,V 가져오기
% % CHC에서 C-RATE ---> Y,V 가져오기

