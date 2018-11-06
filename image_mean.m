function y = image_mean(image_mat)
    r = 1;
    g = 2;
    b = 3;
    
    if size(image_mat, 3) ~= 3
       r=1;
       g=1;
       b=1;
    end
    
    %calculate colour means
    rm = mean2(image_mat(:,:,r));
    gm = mean2(image_mat(:,:,g));
    bm = mean2(image_mat(:,:,b));
    
    
y = [rm, gm, bm];
end