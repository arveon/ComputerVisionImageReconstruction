function y = image_mean(image_mat)
    r = 1;
    g = 2;
    b = 3;
    
    %this is used in case image isn't rgb (is b&w for example)
    %in this case, just take a mean of values of 1 channel, whatever it is
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