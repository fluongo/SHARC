## SHARC

MATLAB code for generating surrogate datasets:

Contains 3 functions for generating surrogate datasets that maaintain first order correlations between neurons while maintaing network-level temporal struucture. 


```Matlab
function [C2] = cluster(C)
%        Given an input correlation matrix (C), returns the topograhically arranged 'clustered' version (C2)
%
%   Input:
%       C = Mirror symmetric correlation matrix where entry i,j corresponds correlation between neurons i and j (nCells x nCells)
%
%   Output:
%       C2 = Topographically clustered correlation matrix where entry i,j corresponds correlation between neurons i and j (nCells x nCells)
%
```

```Matlab
function [M2] = createsurrdata(M, C)
% Function that generates an activity raster (M2) using SHARC, given an input raster of activity (M) and target correlation matrix (C)
%
%   Inputs:
%       M - Activity raster (nCells x timepoints)
%       C - target correlation matrix (nCells x nCells)
%
%   Outputs:
%       M2 - Activity raster representing a surrogate dataset with activity statistics of M and correlations fit to target correlations (C)
```

Accompanying publication:

Luongo et al. 2016 // http://jn.physiology.org/content/115/5/2359
