function [centers] = img2centers(img,n,blockType)

% Value of the center of blocks of an image.

    if mod(n,2) ~= 0
        
        cols = im2col(img, [n n], blockType);
        centers = cols(median(1:n*n),:);
        
    else

        disp('Error: n must be odd');
        return;
        
    end;
    
end
