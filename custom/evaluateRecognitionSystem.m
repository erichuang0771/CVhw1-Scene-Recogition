clear ; close all; clc;
addpath([pwd '/nn/']);

load('../dat/traintest.mat');
load('./vision.mat');
fprintf('[Loading..]\n');
C = cell(length(test_imagenames),1);
disp('parfor: evulating >>>>>>>>')

sz = length(test_imagenames);
X = zeros(length(test_imagenames),1000);
parfor i = 1:length(test_imagenames)
    disp(sprintf('extracting image:%d/%d',i,sz))
    image = im2double(imread(['../dat/' test_imagenames{i}]));
    wordMap = getVisualWords(image, filterBank, dictionary);
     X(i,:) = getImageFeaturesSPM( 2, wordMap, size(dictionary,2));
end
%%
%NN predict
pred = NNpredict(Theta1, Theta2, X);

hwait=waitbar(0,'building result mat >>>>>>>>');
result = zeros(8,8);
for i = 1:length(test_imagenames)
    result(test_labels(i),pred(i)) = result(test_labels(i),pred(i))+1;
      s=['running',num2str(i/length(test_imagenames)*100),'%'];
       waitbar(i/length(test_imagenames),hwait,s);
end
close(hwait);
rate = trace(result)/sum(result(:))*100
save ./FinalResult result rate;