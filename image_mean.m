function y = image_mean(image_path)
    image = imread(image_path);
    
    r = 1;
    g = 2;
    b = 3;
    
    if size(image, 3) ~= 3
       r=1;
       g=1;
       b=1;
    end
    
    %calculate colour means
    rm = mean2(image(:,:,r));
    gm = mean2(image(:,:,g));
    bm = mean2(image(:,:,b));
    
    
y = [rm, gm, bm];
end