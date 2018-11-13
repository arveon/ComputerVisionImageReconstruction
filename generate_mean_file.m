function generate_mean_file(image_folder, meanspath)
    means=scan_means_in_folder(image_folder);
    dlmwrite(meanspath, means, 'precision', 8);
end