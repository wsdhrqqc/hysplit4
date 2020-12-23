# hysplit4
Qing Dec 2020: automatically run hysplit4

Hysplit4 for ship-born data back trajectory end points and previous meteorology conditions

Back-trajectory for ship-born data normally would be a 4D array, dimensions include lat, lon, alt and previous times.

For each experiment, the Mac/PC version of Hysplit4 accepts only one starting times. Chaning starting times before each experiment would be time consuming, and manually setting up the start locations requests a long typing time. 

Therefore Qing wrote a bash file (for Mac) and bat file (for PC) to automatically run Hysplit4, and eventually report and gether all output files for further analysis. 
