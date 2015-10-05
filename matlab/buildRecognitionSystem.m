disp('Build System begin...');

%load files
disp('Load traintest...');
load ./dictionary.mat;

train_features = [];
disp('train features...')
hwait=waitbar(0,'train features >>>>>>>>');
for i = 1:length(train_imagenames)
    str = strrep(train_imagenames{i},'.jpg','.mat');
    load(['../dat/' str]);
    [h] = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
    train_features = [train_features;h];
    s=['running',num2str(i/length(train_imagenames)*100),'%'];
       waitbar(i/length(train_imagenames),hwait,s);
end

close(hwait);
train_features = train_features';
disp('Saving Vision.mat')
save vision filterBank dictionary train_features train_labels;