function y = crop_images_in_folder(folder, sidesize)
    files=dir(folder);    
    for i=2:numel(files)
        %if is a directory, skip it
        if files(i).isdir
            continue
        end
        
        %ignore all but selected extensions
        [filepath, name, ext] = fileparts(files(i).name);
        if ~strcmp(ext, '.bmp') && ~strcmp(ext, '.jpg') && ~strcmp(ext, '.png')
            continue
        end
        
        image=imread(sprintf("%s%s%s",filepath, name, ext));
        
        %check if image can be split into sidesize blocks evenly
        [rows, cols, ~] = size(image);
        remx=mod(cols,sidesize);
        remy=mod(rows,sidesize);

        %get rid of remainders that make new dimensions non-divisible by
        %side size
        rows=rows-remy;
        cols=cols-remx;
        
        %now need to make a square out of it
        sx=cols/sidesize;
        sy=rows/sidesize;
        side=min([sx,sy]);%maximise the size of crop rect in one of dimensions
        
        
        %make sure to crop the center part not top left corner
        new_side=side*sidesize;
        dif_x=cols-new_side;
        dif_y=rows-new_side;
        
        %"move" the crop rectangle right/down by half the
        %difference of size (so even number of pixels are cropped from each
        %side of picture
        image_c=image(1+dif_y/2:new_side+dif_y/2, 1+dif_x/2:new_side+dif_x/2, :);
        
        %save image
        path=sprintf("%s%s%s%s",folder,"/", name, ext);
        imwrite(image_c,path);               
    end
end