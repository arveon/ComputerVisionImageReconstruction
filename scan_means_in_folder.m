function y = scan_means_in_folder(folder)
    files=dir(folder);
    means = zeros(numel(files), 3);
    
    counter=1;
    for i=2:numel(files)
        %if is a directory, skip it
        if files(i).isdir
            continue
        end
        
        %ignore all but selected extensions
        [filepath, name, ext] = fileparts(files(i).name);
        if ~strcmp(ext, '.bmp') && ~strcmp(ext, '.jpg') && ~strcmp(ext, '.png') && ~strcmp(ext, '.JPG')
            continue
        end
        
        i_name=strcat(folder,"/", name, ext);
        
        mn=image_mean(imread(i_name));
        means(counter,[1,2,3])=mn;
        counter=counter+1;
    end
    y=means(1:counter-1,:);  
end