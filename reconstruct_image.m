function y = reconstruct_image(image_path, sidesize, img_per_row, means_filepath, dataset_folder)
    image=imread(image_path);
    
    [rows, cols, channels] = size(image);
    %check if image is black and white and if it is, generate an rgb
    %version with duplicate values in other channels
    if channels == 1
        image=repmat(image,[1,1,3]);
    end    
    
    info = imfinfo(image_path);
    if isfield(info,'Orientation')
       orient = info(1).Orientation;
       switch orient
         case 2
            image = image(:,end:-1:1,:);         %right to left
         case 3
            image = image(end:-1:1,end:-1:1,:);  %180 degree rotation
         case 4
            image = image(end:-1:1,:,:);         %bottom to top
         case 5
            image = permute(image, [2 1 3]);     %counterclockwise and upside down
         case 6
            image = rot90(image,3);              %undo 90 degree by rotating 270
         case 7
            image = rot90(image(end:-1:1,:,:));  %undo counterclockwise and left/right
         case 8
            image = rot90(image);                %undo 270 rotation by rotating 90
         otherwise
            warning(sprintf('unknown orientation %g ignored\n', orient));
       end
    end
    means=dlmread(means_filepath,',');
    
    
    
    %check if image can be split into sidesize blocks evenly
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
    
    finalx=sidesize*img_per_row;
    finaly=rows*cols/finalx;
    img_per_col=finaly/sidesize;
    
    %reconstruction
    image_r=zeros(finaly,finalx,3);
    
    for i=0:sy-1
        for j=0:sx-1
            id=i*sx+j+1;
            if id==10
                disp(id)
            end
            
            curx=j*sidesize;
            cury=i*sidesize;
            
%             currepx=i*
            
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
            rep_img=get_closest_means(means,frag_mean, fragment, dataset_folder);
            %rep_path=sprintf("%s/%01d%s", dataset_folder,replacement,".jpg");
            %rep_img=imread(rep_path);
            %make sure b&w images are converted to rgb
            [~,~,new_channels] = size(rep_img);
            if new_channels == 1
                rep_img=repmat(rep_img,[1,1,3]);
            end
            
            rep_img=uint8(imresize(rep_img, [sidesize NaN]));
            
            clc
            i
            j
            sy-1
            
            size(fragment);
            size(rep_img);
            
            
            %insert the image from dataset that best corresponds to this
            %block
            image_r(cury:cury+sidesize-1,curx:curx+sidesize-1,:)=rep_img;
            
        end
    end
    image_r = uint8(image_r);
    %imshow(image_r)
    
    figure(1)
    subplot(1,2,1), imshow(image_c), title('Original')
    subplot(1,2,2), imshow(image_r), title('Reconstructed')
    
    imwrite(image_r,"result.jpg");
    
end