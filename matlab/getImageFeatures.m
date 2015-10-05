function    [h] = getImageFeatures(wordMap, dictionarySize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
        h = hist(wordMap(:), 1:dictionarySize);
        h = h./norm(h,1);
end

