function [cols] = img2col(img,n,blockType)

% Generalization of im2col (to 3 channels images).

    colsR = im2col(img(:,:,1), [n n], blockType);
    colsG = im2col(img(:,:,2), [n n], blockType);
    colsB = im2col(img(:,:,3), [n n], blockType);

    cols = vertcat(colsR,colsG,colsB);

end

