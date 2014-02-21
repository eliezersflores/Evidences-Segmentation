function [Y,Yt,C,Ct,isTrain] = evidencesGenerateWindows(n,totalBens,totalMals,blockType)

    h = waitbar(0,'Generating the evidences...');
    
    images = loadShadAttenuatedImages('images','tif'); 
    gts = loadImages('gts','tif');
    
    [bensTrain,~] = crossvalind('HoldOut',totalBens,.5); 
    [malsTrain,~] = crossvalind('HoldOut',totalMals,.5);
    isTrain = [bensTrain; malsTrain]; 
    
    cellY = cell(1,numel(find(isTrain==1)));
    cellC = cell(1,numel(find(isTrain==1)));
    cellYt = cell(1,numel(find(isTrain==0)));
    cellCt = cell(1,numel(find(isTrain==0)));
    
    for k = 1:totalBens + totalMals

        waitbar(k/(totalBens + totalMals)); 
        img = images{k};
        gt = gts{k}; 

        if isTrain(k)
            
            cellY{k} = img2col(img, n, blockType);
            cellC{k} = img2centers(gt, n, blockType);

        else

            cellYt{k} = img2col(img, n, blockType);
            cellCt{k} = img2centers(gt, n, blockType);

        end;

    end;
    
    Y = horzcat(cellY{:});
    Yt = horzcat(cellYt{:});
    C = horzcat(cellC{:});
    Ct = horzcat(cellCt{:});
    
    close(h); 
    
end

