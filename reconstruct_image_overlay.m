function y = reconstruct_image2(image_path, sidesize, img_per_row, dataset_folder)
    clearvars -except image_path sidesize img_per_row dataset_folder;
    target=load_image(image_path);
    means_path=sprintf("%s%s",dataset_folder,"/means.data");
    
    mean_set=dlmread(means_path,',');
    image_set=load_images(dataset_folder);
    
    [height, width,~]=size(target);    

    %see if original can be represented by that img_per_row
    srx=mod(width,img_per_row);
    new_small_width=width-srx;%get width that can fit img_per_row rects
    %get size of rect in small version to calculate num rows
    small_rect=new_small_width/img_per_row;
    %get image height that would fit a whole number of these squares
    new_small_height=height-mod(height,small_rect);
    
    img_per_col=new_small_height/small_rect;
    
    final_width=sidesize*img_per_row;
    final_height=sidesize*img_per_col;
    target=target(1:new_small_height,1:new_small_width,:);
    
    result=zeros(final_height, final_width,3);
%     figure(1)
    for i=0:img_per_col-1
        for j=0:img_per_row-1
            clc
            id=i*img_per_row+j+1
            maxid=img_per_col*img_per_row
            
            if i > 2 && i <= img_per_col - 3
                continue
            end
            
            cur_y=max(i*small_rect,1);
            cur_x=max(j*small_rect,1);
            
            fragment=target(cur_y:cur_y+small_rect-1, cur_x:cur_x+small_rect-1,:);
            frag_mean=image_mean(fragment);
            
            rep_id=get_closest_mean(mean_set,frag_mean);
            rep_img=image_set{rep_id};
            
            frag=uint8(imresize(rep_img, [sidesize sidesize]));
            
            cur_big_x=max(j*sidesize,1);
            cur_big_y=max(i*sidesize,1);
%             rep_id
%             size(frag)
            
            result(cur_big_y:cur_big_y+sidesize-1,cur_big_x:cur_big_x+sidesize-1,:)=frag;
            result=uint8(result);
        end
    end
    
    %overlay the reconstruction with scaled original
    o_target=imgaussfilt(target, 2);%smooth
    o_target=imresize(o_target, [final_height final_width]);%scale
    alpha=0.2;%smaller value makes "target" less visible
    result2=alpha*o_target + (1-alpha)*result;%overlay
    
     figure(1)
     subplot(1,3,1), imshow(target), title('Original')
     subplot(1,3,2), imshow(result), title('reconstructed')
     subplot(1,3,3), imshow(result2), title('overlayed')
     
     newpath=sprintf("%s%s",image_path,"_reconstructed.jpg");
     
     imwrite(result2, newpath);
end