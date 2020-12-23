 

%###############################################################
% Load trajinumbers.txt
%###############################################################

traji_info = importdata(['marnumbers.txt']);

%###############################################################
% Load HYSPLIT output text files without headerlines including
% this line "8 PRESSURE THETA AIR_TEMP RAINFALL
% MIXDEPTH RELHUMID TERR_MSL SUN_FLUX" and process all files
% for one research flight
%###############################################################

Headerlines = 9; % needs to be adjusted if more GDAS files are used

for oo = 1:length(traji_info)

A = importdata(['/Users/qingn/Hysplit4/working/Conversionfiles/Output ' num2str(traji_info(oo,1)) '.txt'],' ',traji_info(oo,2)+Headerlines);

n = traji_info(oo,2);

if oo==1
    nagano = n;
    trajisstartnumber = 1;
else
    nagano = nagano + n;
    trajisstartnumber = nagano - n + 1;
end;

trajisrunnumber = [trajisstartnumber:nagano];
timedate = datenum(0,A.data(1,4),A.data(1,5),A.data(1,6),0,0); % numeric date 13

for ii = 1:n
   
   eval(['ok = find(A.data(:,1)==' num2str(ii) ');']);
   
   timevec = repmat(NaN,length(A.data(ok,12)),1);
   timevec(1) = timedate;

        for uu = 2:length(A.data(ok,12))
            timevec(uu) = timevec(uu-1) - 3600/86400;
        end;  
        
   ula = struct('t',{timevec},'lat',{A.data(ok,10)},'lon',{A.data(ok,11)},'alt',{A.data(ok,12)},'p',{A.data(ok,13)},'theta',{A.data(ok,14)},'temp',...
       {A.data(ok,15)},'rain',{A.data(ok,16)},'mix',{A.data(ok,17)},'rh',{A.data(ok,18)},...
       'meters',{A.data(ok,19)},'sun',{A.data(ok,20)});
   
   eval(['trajis.t' num2str(trajisrunnumber(ii)) ' = ula;']);  
   
   clear ok timevec ula 
   
end;
                           
clear timedate trajisrunnumber

end;

savefilename=['./eeExampleFlight.mat'];
save(savefilename, 'trajis', '-mat'); 







