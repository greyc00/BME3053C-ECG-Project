# BME3053C-ECG-Project
#BME3053C The Last of Us
#Benjamin Arnold, Grace Cheng, Brendan O'Donnell, Jordan Sanon, Wesley Turner

#Labeling waves of ECG and flagging instances of missing heartbeats. Preliminary work on visualizing data and determining how this can be applied.

#ECG_missingbeat: Highlights R wave location(s) before a beat is missing. Input is an array signal. Returns index of R peaks before the beat is missing, so the time can be obtained if the user knows the start time and sampling rate.
#ECG_hbeatextract: Returns estimated average heart rate, and start time and end time of heart beat of choice. Input is also an array signal and which heartbeat the user would like to select. To avoid errors from cutting off beats prematurely, it is best to not choose heartbeat 1 or the last heartbeat.
#ECG_GAF: Gramian Angular Field matrix from array of time series data. This can be visualized with imagesc(GAF)
