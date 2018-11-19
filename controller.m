function controller = controller()
controller.prepare = @load_features;
controller.train = @train;
controller.predict_manmade = @predict_manmade;
controller.predict_natural = @predict_natural;
controller.generate_files = @generate_files;

end
function generate_files()
features_prep = knn_preTrainning();
features_prep.edge_feature("natural_trainning","feature_natural.data");
features_prep.edge_feature("manmade_trainning","feature_manmade.data");
features_prep.edge_feature("natural_testing","feature_natural_testing.data");
features_prep.edge_feature("manmade_testing","feature_manmade_testing.data");
end
function [feature_trainning,feature_natural_testing,feature_manmade_testing,label_trainning,label_testing_natural,label_testing_manmade] = load_features()
features_prep = knn_preTrainning();
feature_trainning = [features_prep.load_features_from_file("./modified/feature_natural.data");features_prep.load_features_from_file("./modified/feature_manmade.data")];
feature_natural_testing = features_prep.load_features_from_file("./modified/feature_natural_testing.data");
feature_manmade_testing = features_prep.load_features_from_file("./modified/feature_manmade_testing.data");
label_trainning = [features_prep.generate_labels("natural_trainning","natural"),features_prep.generate_labels("manmade_trainning","manmade")];
label_testing_natural = features_prep.generate_labels("natural_testing","natural");
label_testing_manmade = features_prep.generate_labels("manmade_testing","manmade");
end
function y = train(features,labels)
%y = fitcknn(features,labels,'NumNeighbors',5,"Standardize",1);
y= fitcknn(features,labels,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'))
end
function y = predict_manmade(model, features)
    [label score cost] = predict(model, features);
    result = strcmp(label,"manmade");
    sum(result)
    numel(result)
    y = sum(result)/numel(result);
end
function y = predict_natural(model, features)
[label score cost] = predict(model, features);
    result = strcmp(label,"natural");
    sum(result)
    numel(result)
    y = sum(result)/numel(result);
end