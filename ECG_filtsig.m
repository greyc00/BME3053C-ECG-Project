%Written By Benjamin Arnold 11/18/2022

function [sigout] = ECG_filtsig(sigin,rind)
%UNTITLED3 Summary of this function goes here
%   rind is used to help smooth the data using the detrend function.  This
%   rind can be found by using ECG_FindR
%% Input handling
sigout= sigin;
%% Impliment Bandpass & Savitzky-Golay filtering


sigout = sgolayfilt(sigout,0,5);
sigout = lowpass(sigout, 30,1000);
sigout = highpass(sigout,.05,1000);
sigout = lowpass(sigout, 30,1000);
sigout = highpass(sigout,.01,1000);
%sigout = sgolayfilt(sigout,0,5);
% smoothedData = smoothdata(sigout,"movmean","SmoothingFactor",0.3);
% sigout = sigin-smoothedData;

%Detrend the data
if nargin > 1
    sigout = detrend(sigout,1,rind);
end
end