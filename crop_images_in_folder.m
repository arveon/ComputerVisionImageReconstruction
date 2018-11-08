function y = crop_images_in_folder(folder)
    files=dir(folder);
    num_skipped = 1;
    for i=2:numel(files)
        %if is a directory, skip it
        if files(i).isdir
            num_skipped= num_skipped+1;
            continue
        end
        
        %ignore all but selected extensions
        [filepath, name, ext] = fileparts(files(i).name);
        if ~strcmp(ext, '.bmp') && ~strcmp(ext, '.jpg') && ~strcmp(ext, '.png') && ~strcmp(ext, '.JPG')
            num_skipped= num_skipped+1;
            continue
        end
        
        image=imread(sprintf("%s%s%s",filepath, name, ext));
        
        %check if image can be split into sidesize blocks evenly
        [rows, cols, ~] = size(image);
        side=min([cols,rows]);%maximise the size of crop rect in one of dimensions
        
        
        %make sure to crop the center part not top left corner
        dif_x=int16(cols-side);
        dif_y=int16(rows-side);
        
        %"move" the crop rectangle right/down by half the
        %difference of size (so even number of pixels are cropped from each
        %side of picture
        image_c=image(1+dif_y/2:side+dif_y/2, 1+dif_x/2:side+dif_x/2, :);
        
        %save image
        path=sprintf("%s%s%01d%s",folder,"/modified/",i-num_skipped, ext);
        imwrite(image_c,path);               
    end
end