%Grace Cheng
%DWT method and code based off of:
%A.K. Verma. “Video 26: ECG’s QRS Peak Detection and Heart Rate Estimation using Discrete Wavelet Transform (DWT) in MATLAB.”Exploring Technologies. https://www.exptech.co.in/2021/03/video-26-ecgs-qrs-peak-detection-and.html (Accessed Dec. 1, 2022).

function [heartrate, starttime, endtime] = ECG_hbeatextract(sigin, beatnumber)

%sigin can be a raw signal but has to be a horizontal 1xn array
%beatnumber is the heartbeat number you want to extract from the signal

%the function gives heartrate (bpm), and the starttime and endtime (in ms) of the
%heartbeat that you want to extract.

%using the discrete wavelet transform (DWT): like a fourier transform, but
%also contains information on the temporal location of the signal.

%create a wavelet bank and extract wavelet in time series
%"sym4" wavelet is an extension of db wavelet which scales symmetrically,
%and looks a lot like the QRS complex, therefore helping emphasize this
%complex over all else.

%Using level 3 wavelet transform: decomposes into 4 sets of frequencies,
%with the lowest band being approximation coefficient (low frequency
%scaling information) and the higher 3 bands being detail coefficients,
%more indicative of the wavelet (high frequency). We can possibly extract
%certain bands of frequencies which correspond to the QRS complex.
%Experimentally, d3 and d4 emphasize this region. 
samplerate = 1000;
sampleind = 1:length(sigin);
time = sampleind./samplerate;

%%
%Method code from A.K. Verma
%Obtain d3, d4
%use of function modwt is the maximal overlap discrete wavelet transform,
%which does not downsample and preserves time resolution
dwt = modwt(sigin, 4, "sym4");
dwt3 = dwt(3,:);
dwt4 = dwt(4,:);
dwtofinterest = cat(1, dwt3, dwt4);

%Reconstruct and peak finder
idwt = imodwt(dwtofinterest, "sym4");
idwt = idwt.^2;
idwtmean = mean(idwt);
[Rwave, Rtime] = findpeaks(idwt,"MinPeakHeight", idwtmean*10, "MinPeakDistance", 100);

%%
%beat extraction and heartrate (in bpm) calculation
Rbeat = diff(Rtime);
Rbeatoutlier = isoutlier(Rbeat,"percentiles", [10 90]);
Rbeatoutlierind = find(Rbeatoutlier);
Rbeat(Rbeatoutlierind) = [];
msecondsperbeat = mean(Rbeat);
heartrate = 60/(msecondsperbeat/1000);
starttime = Rtime(beatnumber) - (msecondsperbeat/2);
endtime = Rtime(beatnumber) + (msecondsperbeat/2);
