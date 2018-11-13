function y = generate_labels(image_folder, label)
    means = scan_means_in_folder(image_folder);

    label_size = size(means);
    label_size = label_size(1);
    
    % generate the labels into a single array
    count = 1;
    labels{label_size} = {};
    while count <= label_size
        labels{count} = label;
        count = count + 1;
    end
    
    y = labels;
end