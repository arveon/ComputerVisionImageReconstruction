function y = prepare_image_set(folder,file_name)
    crop_images_in_folder(folder);
    pause(1);
    meanspath=sprintf("%s%s",folder,"/modified/"+file_name);
    generate_mean_file(folder, meanspath);
end
