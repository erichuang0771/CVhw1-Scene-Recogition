function [histInter] = distanceToSet(wordHist, histograms)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    if size(wordHist,1) == 1
        wordHist = wordHist';
    end
    x = repmat(wordHist,1,size(histograms,2));
    histInter = sum(bsxfun(@min,x,histograms),1);
end

