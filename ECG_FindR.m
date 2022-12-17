function ind = ECG_FindR(sigin,feat)
%% Algorithm Description
    % Developed by Benjamin Arnold

  % Find R
  %   Finds the local maximums of the Rwave and sends this back to help
  %   locate the heartbeat (use lead i as input for sig)
   
% Find T
%   Uses Find R method and deletes the qrs complex so that the T-wave is
%   visible to a local maximum algorithm

% Find S
%   Finds the minimum of the Swave and sends this back to help locate the
%   heartbeat

%% Methods
smoothedData = smoothdata(sigin,"movmean","SmoothingFactor",0.05);
if nargin < 2
    feat='r';
end
ind =[];
tf= length(sigin);
if (feat=='r') || (feat == 't') || (feat == 'T') || (feat == 'q') ...
        || (feat =='R')||(feat == 'p') || (feat == 'P')
    %Find R----------------
ind = islocalmax(sigin,"MinProminence",0.11,"MinSeparation",350);
ind = find(and(ind, sigin>smoothedData));
m= mean(sigin)-.01;
    if (feat == 't') || (feat == 'T') %Find T-----------------------
        for i= 1: length(ind) % remove qrs from signal
            rind= ind(i);
            if (rind>50) && (rind< tf-200)
                 sigin(rind-50:rind+50)= m-.02;
            end
        end
        ind = find(islocalmax(sigin(50:end-50),"MinProminence",0.03,...
            "MinSeparation",350,"ProminenceWindow",90))+49;
        %ind = find(and(ind, sigin>smoothedData));
    elseif (feat == 'p') || (feat == 'P')
        lind=ind;
        for i= 1: length(ind)
            rind= ind(i);
            if (rind>50) && (rind< tf-420)
            sigin(rind-50:rind+420)=m-.02;
        elseif (rind > tf- 400)
            sigin(rind-50:end)= m-.02;
            end
        end
        ind = find(islocalmax(sigin(50:end-50),"MinProminence",0.02,...
            "MinSeparation",300,"ProminenceWindow",100,"MaxNumExtrema",length(lind)+1))+49;
    end

else if (feat =='s'|| feat =='S')  %Find S------------------------
ind = islocalmin(sigin,"MinProminence",0.07,"ProminenceWindow",90,...
    "MinSeparation",300);
ind = find(and(ind, sigin<smoothedData));
end
end