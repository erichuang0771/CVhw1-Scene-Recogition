function[filterBank, dictionary] = getFilterBankAndDictionary(image_names)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

filterBank = makeLMfilters();
F = length(filterBank);
T = length(image_names);
 % magic number here!
alpha = 200; K = 200;
filter_responses_cell = cell(T,1);
filter_responses = zeros(alpha*T,3*F);

disp('Parfor extractFilterResponses >>>>>>>>')
%hwait=waitbar(0,'(disable par) extractFilterResponses >>>>>>>>');
parfor i = 1:T
    disp(sprintf('extracting image:%d/%d',i,T))
    I = imread(['../dat/' image_names{i}]); % passing alpha & ind to extractFilterResponses can significantly accelrate the speed
    tmp = extractFilterResponses(I,filterBank);
    ind = randperm(size(tmp,1));
    filter_responses_cell{i} = tmp(ind(1:alpha),:);
 %   str=['running',num2str(i/T*100),'%'];
  %  waitbar(i/T,hwait,str);
end
%close(hwait);

hwait=waitbar(0,'building filter_responses matrix  >>>>>>>>');
for i = 1:T
    filter_responses(alpha*(i-1)+1:alpha*i,:) = filter_responses_cell{i};
    str=['running',num2str(i/T*100),'%'];
    waitbar(i/T,hwait,str);
end
close(hwait);

display('running kmeans !!!')
[~, dictionary] = kmeans(filter_responses, K, 'EmptyAction','drop');
dictionary = dictionary';

end

