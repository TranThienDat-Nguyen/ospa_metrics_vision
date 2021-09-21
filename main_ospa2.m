clear all
clc
addpath(genpath(pwd))
%% Data paths, please change it for your specific data
seqmap = 'data/MOT17/MOT17-eval-seqmap.txt' ; % file that stores the names of sequences need to be evaluated.
gtDataDir = 'data/MOT17/_gt' ; % path to the ground truth files, similar structure to the MOTChallenge data structure, please see the 'data' folder for details
resDir = 'data/MOT17/_res' ;     % path to the result files (contain outputs from different trackers, each tracker output is in 1 separate folder)
trackers = {'Tracktor', 'AFN17'} ; % names of trackers need to be evaluated

%% Prepare the ground truth
onlyPedestrian = false ; 
[allSequences , gtMat] = ParsingGT(seqmap, gtDataDir, onlyPedestrian) ;
LS = length(allSequences) ;
Sequence = [allSequences, {'Overall'}] ; Sequence = Sequence' ; 
X = cell(1,LS) ; 
for ind = 1:LS
    % Convert gt to 2-corner format
    K = max(gtMat{ind}(:,1)) ; 
    IDs_X = unique(gtMat{ind}(:,2)) ; 
    X{ind} = nan(4,K,length(IDs_X)) ; 
    for id = 1 : length(IDs_X)
        for k =1 : K 
            temp_gtdata = gtMat{ind}(gtMat{ind}(:,1)==k , :) ;
            temp_gtdata = temp_gtdata(temp_gtdata(:,2)==IDs_X(id) , :) ; 
            if size(temp_gtdata,1) == 1
                X{ind}([1,2],k,id) = temp_gtdata(1 , 3:4) ; 
                X{ind}([3,4],k,id) = temp_gtdata(1 , 3:4) + temp_gtdata(1 , 5:6) ; 
            elseif size(temp_gtdata,1) == 0
                % do nothing
            else
                error('An ID appears more than one in a time step.') ; 
            end
        end
    end
end

%% Prepare results then evaluate
for trkidx = 1 : length(trackers)
    curr_resDir = fullfile(resDir, trackers{trkidx}) ; 
    [resMat , rawResMat] = ParsingRES(gtMat, curr_resDir, allSequences) ;
    OSPA2_IoU = zeros(LS+1,1) ; 
    OSPA2_GIoU = zeros(LS+1,1) ;
    for ind = 1:LS
        % Convert resutls to 2 corner format
        K = max(gtMat{ind}(:,1)) ; 
        IDs_Y = unique(rawResMat{ind}(:,2)) ; 
        Y = nan(4 , K , length(IDs_Y) ) ; 
        for id = 1 : length(IDs_Y)
            for k =1 : K 
                temp_resdata = rawResMat{ind}(rawResMat{ind}(:,1)==k , :) ;
                temp_resdata = temp_resdata(temp_resdata(:,2)==IDs_Y(id) , :) ; 
                if size(temp_resdata,1) == 1
                    Y([1,2],k,id) = temp_resdata(1 , 3:4) ; 
                    Y([3,4],k,id) = temp_resdata(1 , 3:4) + temp_resdata(1 , 5:6) ; 
                elseif  size(temp_resdata,1) == 0
                    % do nothing
                else
                    error('An ID appears more than one in a time step.') ; 
                end
            end
        end
        % IoU
        flagGIoU = false ; 
        OSPA2_IoU(ind) = ospa2_metric(X{ind}, Y, K, flagGIoU) ; 
        % GIoU
        flagGIoU = true ; 
        OSPA2_GIoU(ind) = ospa2_metric(X{ind}, Y, K, flagGIoU) ; 
    end
    OSPA2_IoU(LS+1) = mean(OSPA2_IoU(1:LS)) ; 
    OSPA2_IoU = (1 - OSPA2_IoU)*100 ; 
    OSPA2_GIoU(LS+1) = mean(OSPA2_GIoU(1:LS)) ; 
    OSPA2_GIoU = (1 - OSPA2_GIoU)*100 ; 
    T = table(Sequence,OSPA2_IoU,OSPA2_GIoU) ; 
    disp(trackers{trkidx})
    disp(T) 
end




