clear ; close all; clc
load('../dat/traintest.mat');
load('vision.mat');
fprintf('[Loading..]\n');
C = cell(length(test_imagenames),1);
disp('parfor: evulating >>>>>>>>')
parfor i = 1:length(test_imagenames)
    image = im2double(imread(['../dat/' test_imagenames{i}]));
    wordMap = getVisualWords(image, filterBank, dictionary);
    h = getImageFeaturesSPM( 3, wordMap, size(dictionary,2));
    distances = distanceToSet(h, train_features);
    [~,nnI] = max(distances);
    C{i} = [test_labels(i),train_labels(nnI)];
end
hwait=waitbar(0,'building result mat >>>>>>>>');
result = zeros(8,8);

for i = 1:length(test_imagenames)
    tmp = C{i};
    result(tmp(1),tmp(2)) = result(tmp(1),tmp(2))+1;
    s=['running',num2str(i/length(test_imagenames)*100),'%'];
    waitbar(i/length(test_imagenames),hwait,s);
end
close(hwait);
rate = trace(result)/sum(result(:))*100