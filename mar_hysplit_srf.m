% load 1.4 VAP file for input
%###############################################################
% Load data (here at 10min time resolution) for four complete research voyages and
% read Time, Altitude, Latitude and Longitude
%###############################################################

% filename  = '/Users/qingn/Downloads/MARCUS_Environmental_Parameters_VAP_V1.4_Voyage1_20171029_20171203.cdf';
filename  = '/Users/qingn/Downloads/MARCUS_Environmental_Parameters_VAP_V1.4_Voyage2_20171213_20180110.cdf';

% '/Users/qingn/Downloads/Environmental VAP/MARCUS/V1.3/MARCUS_Environmental_Parameters_VAP_V1.3_Voyage1_20171029_20171203.cdf';


% ncdisp(filename);
lat  = ncread(filename,'ship_lat');
lon  = ncread(filename,'ship_lon');
lat(lat==-9999) = NaN;
lon(lon==-9999) = NaN;
time = ncread(filename,'seconds');
day  = ncread(filename,'day');
% base_time = ncread(filename,'base_time_string');
% base_time = join(string(base_time),'');
% Base_time = datetime(base_time,'InputFormat','dd-MMM-yyyy HH:mm:ss');
% Base_time.Format = 'yy MM dd HH';
% time_input = Base_time+seconds(time);

% L1 = datestr(time,0)-1; %length of time
% A = [Time,Altitude,Latitude,Longitude];
alt = repmat(10,length(day),1);
% TimeVec1 = [day(1)-1+84600/86400:3600/86400:day(end)+84600/86400];
TimeVec1 = [day(1):3600/86400:day(end)+84600/86400];
L1 = datestr(TimeVec1,0);
% alt = zeros(4176,1);
A1 = [day,alt,lat,lon];


A1(any(isnan(A1)'),:) = [];

% A1 = A1(1:end-1,:);

%###############################################################
% HYSPLIT v4.9 only takes full hours as input; hence, starting
% locations within +/- 30 min have the same start time - 
% ok = [24*360] - 360 trajectories per hour maximum (every 10s)
%###############################################################

ok1 = NaN(length(TimeVec1),6);
format('long')
TimeVec1 = round(TimeVec1,8);
A1(:,1) = round(A1(:,1),8);
% A1(:,1) = single(A1(:,1));
for ii = 2:length(TimeVec1)
    p = (find(A1(:,1) >= TimeVec1(ii-1) & A1(:,1) < TimeVec1(ii)))';
        if isempty(p) == 1
            ok1(ii,:) = NaN;
        else
            for jj = 1:length(p)
                ok1(ii,jj) = p(jj);
            end;
        end;
    clear p
end;

% ok1(1,:) = [];
% See the Example first:
%'/Users/qingn/Downloads/amt-7-107-2014-supplement/Hysplit2mat.m'
% load /Users/qingn/Downloads/amt-7-107-2014-supplement/flight_data.mat

% Time = time_data;
% Altitude = altitude_data;
% Latitude = latitude_data;
% Longitude = longitude_data;

Hysplit_Notes = mar_Hysplit_text_input_1801; % see extra file

kid1 = fopen(['./marnumbers.txt'],'w');
% kid = fopen(['./trajinumbers.txt'],'w');

for kk = 1:length(L1)-1

    if isnan(ok1(kk,1))  
    
    else
   
    spezi1 = ok1(kk,:);    
    spezi1 = spezi1(find(~isnan(spezi1))); 
    
    TFinal1 = A1(spezi1,1);
    AltFinal1 = A1(spezi1,2);
    LatFinal1 = A1(spezi1,3);
    LonFinal1 = A1(spezi1,4);
    
    Headerline_Time1 = datestr(TFinal1(end)+1,31);
    Full_Hour1 = datestr(median([TimeVec1(kk) TimeVec1(kk+1)]),15);
    % change as transaction changes
    if kk >=457 % change as TimeVec1 changes
    % HYSPLIT Date - Adjust year in Headerline_Final; keep spaces
        Headerline_Final1 = ['18 ' Headerline_Time1(6:7) ' ' Headerline_Time1(9:10) ' ' Full_Hour1(1:2)];
    else
        Headerline_Final1 = ['17 ' Headerline_Time1(6:7) ' ' Headerline_Time1(9:10) ' ' Full_Hour1(1:2)];
    % HYSPLIT total trajectory number
    end
    
%     Headerline_Final1 = ['17 ' Headerline_Time1(6:7) ' ' Headerline_Time1(9:10) ' ' Full_Hour1(1:2)];
    
    trajis_amount1 = [num2str(length(spezi1))];
    % HYSPLIT output filename
    Output_Filename1 = ['Output ' num2str(kk) '.txt'];
    
    fprintf(kid1,'%f\t %s\t\n',kk,trajis_amount1);

    fid1 = fopen(['/Users/qingn/Hysplit4/working/input1/' num2str(kk) '.txt'],'w');

        fprintf(fid1,'%s\r\n',Headerline_Final1);
        fprintf(fid1,'%s\r\n',trajis_amount1);

        for uu = 1:length(spezi1)
           fprintf(fid1,'%f\t %f\t %f\r\n',LatFinal1(uu),LonFinal1(uu),AltFinal1(uu));
        end;
        
        for pp = 1:size(Hysplit_Notes,1)
            fprintf(fid1,'%s\r\n',Hysplit_Notes(pp,(Hysplit_Notes(pp,:)~=char(32))));  
        end;
        
        fprintf(fid1,'%s\r\n',Output_Filename1);
        
    fclose(fid1)

%     mid = fopen(['E:\data\' num2str(kk) '(with Time).txt'],'w');
% 
%     for uu = 1:length(spezi)
%     fprintf(mid,'%s\t',TimeFinal(uu,:));
%     fprintf(mid,'%f\t %f\t %f\r\n',LatFinal(uu),LonFinal(uu),AltFinal(uu));
%     end;
% 
%     fclose(mid)

%     clear TimeFinal LatFinal LonFinal AltFinal spezi TFinal Headerline_Time
%     clear Full_Hour Headerline_Final Output_Filename
    
    end;
    
end;

fclose(kid1)
