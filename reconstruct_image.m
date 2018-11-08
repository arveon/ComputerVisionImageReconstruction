function y = reconstruct_image(image, sidesize)
    [rows, cols, channels] = size(image);
    %check if image is black and white and if it is, generate an rgb
    %version with duplicate values in other channels
    if channels == 1
        image=repmat(image,[1,1,3]);
    end
    
    
    %check if image can be split into sidesizexsidesize blocks evenly
    %crop it if it can't
    
    remx=mod(cols,sidesize);
    remy=mod(rows,sidesize);
    
    %make sure the dimensions are divisable by sidesize
    rows=rows-remy;
    cols=cols-remx;
    %crop to newly calculated dimensions
    image_c=image(1:rows,1:cols,:);
    
    %split image into sidesizexsidesize blocks
    sx=cols/sidesize;
    sy=rows/sidesize;
    
    %reconstruction
    image_r=zeros(rows,cols,3);
    
    for i=0:sy-1
        for j=0:sx-1
            id=i*sx+j+1;
            if id==10
                disp(id)
            end
            
            curx=j*sidesize;
            cury=i*sidesize;
            
            %at start they need to be 1, since it's 1 indexed
            if curx==0
                curx=1;
            end
            if cury==0
                cury=1;
            end
            
            %the block of image to be replaced by an image from dataset
            fragment=image_c(cury:cury+sidesize,curx:curx+sidesize,:);
            
            %find the best image to describe the block
            frag_mean=image_mean(fragment);
            frag_mean
            
            %insert the image from dataset that best corresponds to this
            %block
            image_r(cury:cury+sidesize,curx:curx+sidesize,:)=fragment;
            
        end
    end
    image_r = uint8(image_r);
    %imshow(image_r)
    
    figure(1)
    subplot(1,2,1), imshow(image_c), title('Original')
    subplot(1,2,2), imshow(image_r), title('Reconstructed')
    
    
    
    %for each block find an image with closest mean distance
    
    
    
end