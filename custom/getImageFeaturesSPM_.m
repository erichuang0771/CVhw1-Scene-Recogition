function [h] = getImageFeaturesSPM_(layerNum, wordMap, dictionarySize)
  h = [];
  [h, ~] = divide(wordMap,h, 1,layerNum,dictionarySize);
  h = h./norm(h,1);
end

function [h, part] = divide(wordMap,h, now, layerNum,dictionarySize)
    sub_h = cell(4,1);
    M = size(wordMap,1);
    N = size(wordMap,2);
    m = ceil(M/2);
    n = ceil(N/2);
    if now == 1 || now == 2
         weight = 2^(-layerNum);
    else
         weight = 2^(now-1-layerNum-1);
    end
    if now ~= layerNum
        for i = 1:2
            for j = 1:2
                    tmp = wordMap((i-1)*m+1:min(i*m,M), (j-1)*n+1:min(j*n,N));
                    [h, sub_h{(i-1)*2 + j}] = divide(tmp,h,now+1,layerNum,dictionarySize);
            end             
        end
        part = (sub_h{1}+sub_h{2}+sub_h{3}+sub_h{4});
        h = [h weight*part];

    else
         part =  hist(reshape(wordMap,1,[]),1:dictionarySize);
         h = [h weight*part];
    end
end
