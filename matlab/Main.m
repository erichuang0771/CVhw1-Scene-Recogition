clear ; close all; clc
disp('System Main begin...');

disp('Load traintest...');
load ../dat/traintest.mat;

disp('getFilterBankAndDictionary...')
computeDictionary;

disp('batchToWordMap...')
batchToVisualWords;

disp('generating features...')
buildRecognitionSystem;

disp('evaluating System...')
evaluateRecognitionSystem;