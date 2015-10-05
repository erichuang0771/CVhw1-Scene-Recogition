function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses
 

%Convert input Image to Lab
doubleI = double(I);
if size(doubleI,3) ~= 3
    doubleI = repmat(doubleI,[1 1 3]);
end
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
pixelCount = size(doubleI,1)*size(doubleI,2);

%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);
%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===
for i = 1:length(filterBank)
    filterResponses(:,i) = reshape(imfilter(L,filterBank{i},'conv',0,'same'),[],1)';
    filterResponses(:,i+length(filterBank)) = reshape(imfilter(a,filterBank{i},'conv',0,'same'),[],1)';
    filterResponses(:,i+2*length(filterBank)) = reshape(imfilter(b,filterBank{i},'conv',0,'same'),[],1)';
end


end
