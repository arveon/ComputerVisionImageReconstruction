function y = load_images(dataset_folder)
    files=dir(dataset_folder);
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
        y{str2num(name)}=load_image(sprintf("%s%s%s",filepath, name, ext));
    end
    
end