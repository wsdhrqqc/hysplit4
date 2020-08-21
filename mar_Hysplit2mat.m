

%###############################################################
% Load marnumbers.txt
%###############################################################

% traji_info = importdata(['trajinumbers_copy.txt']);
traji_info = importdata(['marnumbers.txt']);
%###############################################################
% Load HYSPLIT output text files without headerlines including
% this line "8 PRESSURE THETA AIR_TEMP RAINFALL
% MIXDEPTH RELHUMID TERR_MSL SUN_FLUX" and process all files
% for one research flight
%###############################################################

% Headerlines = 9; % needs to be adjusted if more GDAS files are used
% 
% for oo  = 388:392
%     fprintf(['/Users/qingn/Hysplit4/working/Conversionfiles/Output ' ['/Users/qingn/Hysplit4/working/Conversionfiles/Output ' num2str(traji_info(oo,1)) '.txt'] '.txt \n'])
% end


for oo = 1:4:length(traji_info)
%     disp('Check') 
% if oo==337
%    disp('Check') 
% end
% C1 = importdata(['/Users/qingn/Hysplit4/working/Conversionfiles/Output ' num2str(traji_info(oo,1)) '.txt'],' ',traji_info(oo,2)+Headerlines);

% C = importdata(['/Users/qingn/Hysplit4/working/Conversionfiles/Output ' num2str(traji_info(oo,1)) '.txt'],' ',traji_info(oo,2)+Headerlines);
Data_All = func_import(['/Users/qingn/Hysplit4/working/Conversionfiles_1801/Output ' num2str(traji_info(oo,1)) '.txt']);
Data_Sum = sum(Data_All,2);
loc = find(Data_Sum>0);

C = [];
C.data = Data_All(loc(1):end,:);
C.traj = Data_All(9:14,1:9);
C.textdata = Data_All(2:7,1:7);

% data_str = [];
% data_str.data = C.VarName1;
n = traji_info(oo,2);

if oo==1
    nagano = n;
    trajisstartnumber = 1;
else
    nagano = nagano + n;
    trajisstartnumber = nagano - n + 1;
end

trajisrunnumber = [trajisstartnumber:nagano];
% timedate = datenum(0,C.data(1,4),C.data(1,5),C.data(1,6),0,0); % numeric date 13
% textdata = cell2mat(C.textdata(2));
timedate = datenum(0,C.textdata(1,4),C.textdata(1,5),C.textdata(1,6),0,0); % original
% timedate = datenum(0,str2double(textdata(13:14)),str2double(textdata(19:20)),str2double(textdata(25:26)),0,0); 

for ii = 1:n
   
   ok = find(C.data(:,1)==ii);
   
   timevec = NaN(length(C.data(ok,12)),1);
   timevec(1) = timedate;

        for uu = 2:length(C.data(ok,12))
            timevec(uu) = timevec(uu-1) - 3600/86400;
        end;  
        
   ula = struct('t',{timevec},'lat',{C.data(ok,10)},'lon',{C.data(ok,11)},'alt',{C.data(ok,12)},'p',{C.data(ok,13)},'theta',{C.data(ok,14)},'temp',...
       {C.data(ok,15)},'rain',{C.data(ok,16)},'mix',{C.data(ok,17)},'rh',{C.data(ok,18)},...
       'meters',{C.data(ok,19)},'sun',{C.data(ok,20)});
   
   eval(['trajis.t' num2str(trajisrunnumber(ii)) ' = ula;']);  
   
%    clear ok timevec ula 
   
end;
                           
% clear timedate trajisrunnumber

end;

savefilename=['./ExampleShip_1801.mat'];
save(savefilename, 'trajis', '-mat');