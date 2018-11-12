function [features, labels] = load_fl_from_means(natural_images_folder, manmade_images_folder)

    % get the means from both folders and combine them into one
    natural_means=scan_means_in_folder(natural_images_folder);
    manmade_means=scan_means_in_folder(manmade_images_folder);
    features = [natural_means; manmade_means];
    
    % how many labels will we need
    natural_label_size = size(natural_means);
    natural_label_size = natural_label_size(1);
    manmade_label_size = size(manmade_means);
    manmade_label_size = manmade_label_size(1);
    total_label_size = natural_label_size + manmade_label_size;
    
    % generate the labels into a single array
    count = 1;
    labels{total_label_size} = {};
    while count <= total_label_size
        if(count<=natural_label_size)
            labels{count} = 'natural';
        else
            labels{count} = 'manmade';
        end
        count = count + 1;
    end
    

end