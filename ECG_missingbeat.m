%Grace Cheng
%DWT method and code based off of:
%A.K. Verma. “Video 26: ECG’s QRS Peak Detection and Heart Rate Estimation using Discrete Wavelet Transform (DWT) in MATLAB.”Exploring Technologies. https://www.exptech.co.in/2021/03/video-26-ecgs-qrs-peak-detection-and.html (Accessed Dec. 1, 2022).
%Same method as ECG_hbeatextract, but now we find outliers 
function [heartstoptime] = ECG_missingbeat(patlead);

%This is a function version of Missingbeat.m
%The input is an array of a signal (single lead, time period of choice.
%Ideally, the sample time would be larger so that the caluculation of heart
%beat will not be too skewed by outliers. The output is the location of R
%wave in time right before the beat(s) are missing.


%DWT code method from A.K. Verma
dwt = modwt(patlead, 4, "sym4");
dwt3 = dwt(3,:);
dwt4 = dwt(4,:);
dwtofinterest = cat(1, dwt3, dwt4);

idwt = imodwt(dwtofinterest, "sym4");
idwt = idwt.^2;
idwtmean = mean(idwt);
[Rwave, Rtime] = findpeaks(idwt,"MinPeakHeight", idwtmean*10, "MinPeakDistance", 100);

%%
%Detect missing beats
%calculate time difference between elements. Sample rate is 1000/sec
Rtimerate = diff(Rtime);
%Logical array for outliers. Find nonzero element indices
%The caveat with isoutlier is that there has to be enough normal beats
%(long enough time period) so that outliers will be detected properly
Rmissing = isoutlier(Rtime,"percentiles", [10 90]);
Rmissing = find(Rmissing);
heartstoptime = Rtime(Rmissing);


heartstoptime = heartstoptime/1000;

%can use this to plot in code: 
% subplot(2,1,1)
% plot(time, patlead)
% ylabel('Voltage (uV)')
% title('Original Input Signal')
% subplot(2,1,2)
% plot(time, idwt)
% hold on
% plot(Rtime, Rwave, 'ro')
% xlabel('time (ms)')
% title("Squared DWT peak detection")
% hold off