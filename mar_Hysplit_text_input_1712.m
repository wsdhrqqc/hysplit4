function Hysplit_notes = mar_Hysplit_text_input_1712


Hysplit_notes = strvcat('-72',...    % length of trajectories - here 5 days backward
'0',...                               % type of vertical motion - here "data" or 3D wind field
'1000.0',...                         % top of the model domain in meters (trajectories terminate if height is reached)
'6',...                               % number of meteorological files to be loaded - here 2 files... 
'/Users/qingn/Hysplit4/working/PASE1/',...       % ...for 5d trajectories
'gdas1.oct17.w5',...
'/Users/qingn/Hysplit4/working/PASE1/',...       % GDAS meteorological files - append files as needed to provide data for... 
'gdas1.nov17.w3',...                  % ...longer trajectories or more research flights 
'/Users/qingn/Hysplit4/working/PASE1/',...       % GDAS meteorological files - append files as needed to provide data for... 
'gdas1.nov17.w4',...                  % ...longer trajectories or more research flights 
'/Users/qingn/Hysplit4/working/PASE1/',...       % GDAS meteorological files - append files as needed to provide data for... 
'gdas1.nov17.w1',...                  % ...longer trajectories or more research flights 
'/Users/qingn/Hysplit4/working/PASE1/',...       % GDAS meteorological files - append files as needed to provide data for... 
'gdas1.nov17.w2',...                  % ...longer trajectories or more research flights 
'/Users/qingn/Hysplit4/working/PASE1/',...       % GDAS meteorological files - append files as needed to provide data for... 
'gdas1.nov17.w5',...                  % ...longer trajectories or more research flights 
'/Users/qingn/Hysplit4/working/Outputfiles_1712/'...
); % output folder of HYSPLIT computations in text format


end