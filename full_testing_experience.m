function [acc means labels] = full_testing_experience(mdl, test_folder, expected_label)
    
    means = scan_means_in_folder(test_folder);
    
    labels = generate_labels(test_folder, expected_label);

    acc = test_knn_model(mdl, means, labels);

end