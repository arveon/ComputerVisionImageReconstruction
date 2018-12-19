function y = load_labels_from_file(label_file, num_of_labels)
    labels{num_of_labels} = {};
    fid = fopen(label_file);
    tline = fgetl(fid);
    count = 1;
    while ischar(tline)
        labels{count} = tline;
        tline = fgetl(fid);
    end
    fclose(fid);
    
    y = labels;
end