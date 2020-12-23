

%###############################################################
% Load data (here at 1Hz) for one complete research flight and
% define Time, Altitude, Latitude and Longitude
%###############################################################

load('E:\data\flight_data.mat');

Time = time_data;
Altitude = altitude_data;
Latitude = latitude_data;
Longitude = longitude_data;

%###############################################################
% Definition of a whole-day matrix in half hour steps;
% this needs to be adjusted if flight is conducted over two
% days in time (UTC)
%###############################################################

Flightday = floor(Time(1));

TimeVec =  [Flightday-1+84600/86400:3600/86400:Flightday+84600/86400];
L = datestr(TimeVec,0);

%###############################################################
% Convert data (here at 1Hz) to 10s data and delete any missing
% data (HYSPLIT input without NaN)
%###############################################################

A = [Time,Altitude,Latitude,Longitude];

A_10s = A(1:10:end,:);
A_10s(any(isnan(A_10s)'),:) = [];

%###############################################################
% HYSPLIT v4.9 only takes full hours as input; hence, starting
% locations within +/- 30 min have the same start time - 
% ok = [24*360] - 360 trajectories per hour maximum (every 10s)
%###############################################################

ok = repmat(NaN,length(TimeVec),360);

format('long')

for ii = 2:length(TimeVec)
    p = (find(A_10s(:,1) >= TimeVec(ii-1) & A_10s(:,1) < TimeVec(ii)))';
        if isempty(p) == 1
            ok(ii,:) = NaN;
        else
            for jj = 1:length(p)
                ok(ii,jj) = p(jj);
            end;
        end;
    clear p
end;

ok(1,:) = [];

% Check_ok = ok(~isnan(ok));
% Check_ok_2 = [1:length(A_10s)];
% Final_Check = (sum(Check_ok))-(sum(Check_ok_2));

%###############################################################
% Create text files for HYSPLIT
%###############################################################

Hysplit_Notes = Hysplit_text_input; % see extra file

kid = fopen(['E:\data\trajinumbers.txt'],'w');

for kk = 1:length(L)-1
    
    if isnan(ok(kk,1))  
    
    else
   
    spezi = ok(kk,:);    
    spezi = spezi(find(~isnan(spezi))); 
    
    TFinal = A_10s(spezi,1);
    AltFinal = A_10s(spezi,2);
    LatFinal = A_10s(spezi,3);
    LonFinal = A_10s(spezi,4);

    TimeFinal = datestr(A_10s(spezi,1),13);
    
    Headerline_Time = datestr(TFinal(end),31);
    Full_Hour = datestr(median([TimeVec(kk) TimeVec(kk+1)]),15);
    
    % HYSPLIT Date - Adjust year in Headerline_Final; keep spaces
    Headerline_Final = ['07 ' Headerline_Time(6:7) ' ' Headerline_Time(9:10) ' ' Full_Hour(1:2)];
    % HYSPLIT total trajectory number
    trajis_amount = [num2str(length(spezi))];
    % HYSPLIT output filename
    Output_Filename = ['Output ' num2str(kk) '.txt'];
    
    fprintf(kid,'%f\t %s\t\n',kk,trajis_amount);

    fid = fopen(['E:\data\' num2str(kk) '.txt'],'w');

        fprintf(fid,'%s\r\n',Headerline_Final);
        fprintf(fid,'%s\r\n',trajis_amount);

        for uu = 1:length(spezi)
           fprintf(fid,'%f\t %f\t %f\r\n',LatFinal(uu),LonFinal(uu),AltFinal(uu));
        end;
        
        for pp = 1:size(Hysplit_Notes,1)
        fprintf(fid,'%s\r\n',Hysplit_Notes(pp,(Hysplit_Notes(pp,:)~=char(32))));  
        end;
        
        fprintf(fid,'%s\r\n',Output_Filename);
        
    fclose(fid)

%     mid = fopen(['E:\data\' num2str(kk) '(with Time).txt'],'w');
% 
%     for uu = 1:length(spezi)
%     fprintf(mid,'%s\t',TimeFinal(uu,:));
%     fprintf(mid,'%f\t %f\t %f\r\n',LatFinal(uu),LonFinal(uu),AltFinal(uu));
%     end;
% 
%     fclose(mid)

    clear TimeFinal LatFinal LonFinal AltFinal spezi TFinal Headerline_Time
    clear Full_Hour Headerline_Final Output_Filename
    
    end;
    
end;

fclose(kid)

