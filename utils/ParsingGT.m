function [allSequences , gtMat] = ParsingGT(seqmap, gtDataDir, onlyPedestrian)
warning off
sequenceListFile = fullfile(seqmap);
allSequences = parseSequences2(sequenceListFile);
gtMat = cell(1,length(allSequences));
for ind = 1:length(allSequences)
    %% Parsing inputs
    sequenceName = char(allSequences(ind));
    gtFilename = fullfile(gtDataDir,sequenceName,'gt','gt.txt');
    gtdata = dlmread(gtFilename);
    gtdata(gtdata(:,7)==0,:) = [];     % ignore 0-marked GT
    gtdata(gtdata(:,1)<1,:) = [];      % ignore negative frames
    if onlyPedestrian
        gtdata(gtdata(:,8)~=1,:) = []; % ignore non-pedestrian
    end
    [~, ~, ic] = unique(gtdata(:,2)); % normalize IDs
    gtdata(:,2) = ic;
    gtMat{ind} = gtdata;
end