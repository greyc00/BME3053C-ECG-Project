%Gramian Angular field maker function
%Grace Cheng
%This is a function version of GramianAngular.m
%Using methodology described in:
%Mitiche I, Morison G, Nesbitt A, Hughes-Narborough M, Stewart BG, Boreham P. Imaging Time Series for the Classification of EMI Discharge Sources. Sensors (Basel). 2018 Sep 14;18(9):3098. doi: 10.3390/s18093098. PMID: 30223496; PMCID: PMC6163566.

function [GAF] = ECG_GAF(patbeat, beatnum)

starttime = [];
endtime = [];
[hr starttime endtime] = ECG_hbeatextract(patbeat, beatnum);
time = round(starttime):round(endtime);
duration = round(endtime) - round(starttime);
%get size to index the formation of matrix later
size = numel(time);


%extracting a single heartbeat and rescale values to interval [-1 1].
patbeat = patbeat(round(starttime):round(endtime));
patbeatrescale = rescale(patbeat, -1, 1);

%Getting time window to start at one so that radial vector is i/N for each
%component
normtime = time - (round(starttime)-1);
r = normtime/size;

phi = acos(patbeatrescale);


%formation of matrix

for i = 1:size
    anglesum = phi(i) + phi;
    GAFrowi = cos(anglesum);

    %concatenating rows
    GAF(i, :) = GAFrowi;
end
%Can then use imagesc(GAF) to visualize.