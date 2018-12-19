function y = image_mean(image_mat)
    image_mat=rgb2lab(image_mat);
    l = 1;
    a = 2;
    b = 3;
    
    %this is used in case image isn't rgb (is b&w for example)
    %in this case, just take a mean of values of 1 channel, whatever it is
    if size(image_mat, 3) ~= 3
       l=1;
       a=1;
       b=1;
    end
    
    %calculate colour means
    lm = mean2(image_mat(:,:,l));
    am = mean2(image_mat(:,:,a));
    bm = mean2(image_mat(:,:,b));
    
    
y = [lm, am, bm];
end