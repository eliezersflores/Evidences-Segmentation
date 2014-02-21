function [Y,C,isTrain] = evidencesGenerate(n,totalBens,totalMals,sizeCorner)
    h = waitbar(0,'Generating the evidences...');
    evidenceElems = n^2;
    images = loadShadAttenuatedImages('images','tif',sizeCorner); gts = loadImages('gts','tif');
    [bensTrain,~] = crossvalind('HoldOut',totalBens,.5); [malsTrain,~] = crossvalind('HoldOut',totalMals,.5);
    isTrain = [bensTrain; malsTrain]; trainPositions = find(isTrain == 1);
    Y = []; C = []; % Y = dataset, C = labels
    totalTrain = numel(trainPositions);
    for idx = 1:totalTrain
        i = trainPositions(idx);
        waitbar(i/totalTrain);
        currentGt = gts{i}; currentIm = images{i}; r = currentIm(:,:,1); g = currentIm(:,:,2); b = currentIm(:,:,3);
        colGt = im2col(currentGt,[n n],'distinct');
        colR = im2col(r,[n n],'distinct'); colG = im2col(g,[n n],'distinct'); colB = im2col(b,[n n],'distinct');
        for j = 1:size(colGt,2)
            Y = [Y [colR(:,j); colG(:,j); colB(:,j)]];
            if sum(colGt(:,j)) == 0 % normal skin
                C = [C 0];
            elseif sum(colGt(:,j)) == evidenceElems % melanoma
                C = [C 1];
            else % normal skin and melanoma
                C = [C 2]; 
            end
        end;
    end;
    close(h); 
end

