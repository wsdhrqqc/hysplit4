function Hysplit_notes = Hysplit_text_input


Hysplit_notes = strvcat('-120',...    % length of trajectories - here 5 days backward
'0',...                               % type of vertical motion - here "data" or 3D wind field
'15000.0',...                         % top of the model domain in meters (trajectories terminate if height is reached)
'2',...                               % number of meteorological files to be loaded - here 2 files... 
'D:/hysplit4/working/PASE/',...       % ...for 5d trajectories
'gdas1.aug07.w1',...
'D:/hysplit4/working/PASE/',...       % GDAS meteorological files - append files as needed to provide data for... 
'gdas1.aug07.w2',...                  % ...longer trajectories or more research flights 
'D:/hysplit4/working/Conversion files/'); % output folder of HYSPLIT computations in text format



