function y = prepare_image_set(folder)
    crop_images_in_folder(folder);
    pause(1);
    meanspath=sprintf("%s%s",folder,"/means.data");
    generate_mean_file(folder, meanspath);
end
