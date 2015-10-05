function [wordMap] = getVisualWords(I, filterBank, dictionary)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    wordMap = zeros(size(I,1),size(I,2));
[filterResponses] = extractFilterResponses(I, filterBank);
   D = pdist2(dictionary',filterResponses);
   [~, Ind] = min(D);
   wordMap = reshape(Ind,size(wordMap,1),size(wordMap,2));
end

