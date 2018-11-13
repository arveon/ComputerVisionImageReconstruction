function y = full_training_experience(natural_folder, manmade_folder)

    % Creates features and labels
    [features labels] = load_fl_from_means(natural_folder, manmade_folder);
    
    % Creates and trains a model via same features and labels
    mdl = train_knn_model(features, labels);
    
    % Returns the model
    y = mdl;
end