% clear ; close all; clc

disp('System begin...');
addpath([pwd '/nn/']);
disp('Load traintest...');
load ../dat/traintest.mat;
load ./dictionary.mat;

train_features = zeros(length(train_imagenames), 1000);

disp('train features...')
hwait = waitbar(0,'train features >>>>>>>>');
for i = 1:length(train_imagenames)
    str = strrep(train_imagenames{i},'.jpg','.mat');
    %str = strrep(str,'/','\');
    load(['../dat/' str]);
    [h] = getImageFeaturesSPM(2, wordMap, size(dictionary,2));
    train_features(i,:) = h;
    s=['running',num2str(i/length(train_imagenames)*100),'%'];
       waitbar(i/length(train_imagenames),hwait,s);
end
close(hwait);
train_features = train_features';
%%
%NN
input_layer_size  = size(h,2);  % 20x20 Input Images of Digits
hidden_layer_size = 100;   % 25 hidden units
num_labels = 8;          % 10 labels, from 1 to 10 
%%
%train NN
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

options = optimset('GradObj','on','MaxIter', 2000);
lambda = 0.1;
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, train_features', train_labels', lambda);
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
%%
disp('Saving Vision.mat')
save vision filterBank dictionary train_features train_labels Theta1 Theta2;