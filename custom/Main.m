clear ; close all; clc
disp('System Main begin...');

disp('getFilterBankAndDictionary...')
computeDictionary;

disp('batchToWordMap...') 
batchToVisualWords;

disp('generating features...')
buildRecognitionSystem;

disp('evaluating System...')
evaluateRecognitionSystem;