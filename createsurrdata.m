function [M2] = createsurrdata(M, C)
%function [M2] = createsurrdata(M, C)
% Function that generates an activity raster (M2) using SHARC, given an input raster of activity (M) and target correlation matrix (C)
%
%   Inputs:
%       M - Activity raster (nCells x timepoints)
%       C - target correlation matrix (nCells x nCells)
%
%   Outputs:
%       M2 - Activity raster representing a surrogate dataset with activity statistics of M and correlations fit to target correlations (C)
%

N = size(M);

ncells = N(1);
npts = N(2)

M2 = zeros(ncells,npts);

% first find all the epochs and determine their lengths
for i=1:ncells,
    epochtimes{i} = 1+find(M(i,2:npts) & ~M(i,1:npts-1));
    nepochs(i) = length(epochtimes{i});
    if M(i,npts),
        epochtimes{i} = epochtimes{i}(1:nepochs(i)-1);
        nepochs(i) = nepochs(i)-1;
    end
    
    for j=1:nepochs(i),
        epochlengths{i}(j) = min(find(~M(i,epochtimes{i}(j):npts)))-1;
    end
end

act = mean(M');

% now determine the baseline probability of switching from inactive
% to active states for each cell

for i=1:ncells,
    prob(i) = 1/mean(epochlengths{i});
    prob2(i) = nepochs(i)/(npts-act(i));
end

% now cycle through each timepoint and determine which cells switch
% on

R = rand(ncells,npts);
R2 = rand(ncells,npts);

for i=1:npts,
    if ~sum(M2(:,i)),
        if rand < 0.005,
            M2(ceil(ncells*rand),i) = 1;
        end
    end
    [Y,I] = sort(R(:,i));
    for j=1:ncells,
        currcell = I(j);
        if ~M2(currcell,i),
            % determine whether the cell switches on
            currprob = 0.5*(prob2(currcell)+prob(currcell) * sum(M2(:,i) .* C(:,currcell)));
            if R2(currcell,i) < currprob,
                % switch the cell on
                currlength = epochlengths{currcell}(ceil(rand* ...
                                                         nepochs(currcell)));
                endtime = min(npts, i+currlength-1);
                M2(currcell, i:endtime) = 1;
            end
        end
    end
end
