function [cellName] = loadShadAttenuatedImages(folder,imageFormat)

%   Load all images of a folder (which is inside of the current folder) in a cell, 
%   each image will be a element of the cell.

%   Ex: images = loadData('images','tif');

    currentDirectory = cd;
    dataDirectory = [currentDirectory ['/' folder] ];
    addpath(dataDirectory);
    cd(dataDirectory);
    files = dir(['*.' imageFormat]);
    numFiles = length(files);
    names = cell(1,numFiles);
    cellName = cell(1,numFiles);
    cd(currentDirectory);
    for k = 1:numFiles
        names{k} = files(k).name;
        img = imread(names{k});
        processedImg = shadAttenuation(img,30);
        cellName{k} = double(processedImg);
    end;
    rmpath(dataDirectory);
end

