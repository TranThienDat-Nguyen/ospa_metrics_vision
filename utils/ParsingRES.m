function [resMat , rawResMat] = ParsingRES(gtMat, resDir, allSequences)
warning off
resMat = cell(length(allSequences),1);
rawResMat = cell(length(allSequences),1);
for ind = 1:length(allSequences)
    %% Parsing result
    % MOTX data format
    sequenceName = char(allSequences(ind));
    resFilename = fullfile(resDir, [sequenceName,  '.txt']);
    rawResData = dlmread(resFilename) ; 
    rawResData(rawResData(:,1)<1,:) = [];      % ignore negative frames
    rawResData(rawResData(:,1) > max(gtMat{ind}(:,1)),:) = []; % clip result to gtMaxFrame
    rawResMat{ind} = rawResData ; 
%     resFilename = preprocessResult(resFilename, sequenceName, gtDataDir);
    % Skip evaluation if output is missing
    if ~exist(resFilename,'file')
        error('Invalid submission. Result for sequence %s not available!\n',sequenceName);
    end
    % Read result file
    if exist(resFilename,'file')
        s = dir(resFilename);
        if s.bytes ~= 0
            resdata = dlmread(resFilename);
        else
            resdata = zeros(0,9);
        end
    else
        error('Invalid submission. Result file for sequence %s is missing or invalid\n', resFilename);
    end
    resdata(resdata(:,1)<1,:) = [];      % ignore negative frames
    resdata(resdata(:,1) > max(gtMat{ind}(:,1)),:) = []; % clip result to gtMaxFrame
    resMat{ind} = resdata;
    % Sanity check
    frameIdPairs = resMat{ind}(:,1:2);
    [u,I,~] = unique(frameIdPairs, 'rows', 'first');
    hasDuplicates = size(u,1) < size(frameIdPairs,1);
    if hasDuplicates
        ixDupRows = setdiff(1:size(frameIdPairs,1), I);
        dupFrameIdExample = frameIdPairs(ixDupRows(1),:);
        rows = find(ismember(frameIdPairs, dupFrameIdExample, 'rows'));
        
        errorMessage = sprintf('Invalid submission: Found duplicate ID/Frame pairs in sequence %s.\nInstance:\n', sequenceName);
        errorMessage = [errorMessage, sprintf('%10.2f', resMat{ind}(rows(1),:)), sprintf('\n')];
        errorMessage = [errorMessage, sprintf('%10.2f', resMat{ind}(rows(2),:)), sprintf('\n')];
        assert(~hasDuplicates, errorMessage);
    end
end
