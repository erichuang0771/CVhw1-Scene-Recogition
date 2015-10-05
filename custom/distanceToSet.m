function [histInter] = distanceToSet(wordHist, histograms)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    if size(wordHist,1) == 1
        wordHist = wordHist';
    end
    histInter = zeros(size(histograms,2),1);
    parfor i = 1:size(histograms,2)
        histInter(i) = wordHist'*histograms(:,i)/((wordHist'*wordHist)^(1/2)*(histograms(:,i)'*histograms(:,i))^(1/2));
    end
   %x = repmat(wordHist,1,size(histograms,2));
   % histInter = sum(bsxfun(@min,x,histograms),1);
    
end

