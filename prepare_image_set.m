function y = prepare_image_set(folder)
    crop_images_in_folder(folder);
    pause(1);
    means=scan_means_in_folder(folder);
    meanspath=sprintf("%s%s",folder,"/modified/means.data");
    dlmwrite(meanspath, means, 'precision', 8);
end
