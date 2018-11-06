function y = scan_means_in_folder(folder)
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
        
        i_name=strcat(name, ext);
        mn=image_mean(imread(i_name));
        disp(name);
        disp(mn);
    end
    
    
end