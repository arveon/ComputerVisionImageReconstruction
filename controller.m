function controller = controller()
controller.prepare_trainning = @load_features;
controller.prepare_means = @load_means;
controller.train = @train;
controller.predict_manmade = @predict_manmade;
controller.predict_natural = @predict_natural;
controller.generate_files = @generate_files;
controller.predict = @predict_testing;
controller.full_testing = @full_testing;
controller.reconstruct = @reconstruct;
end
function y = load_means()
prepare_image_set("manmade_trainning","means_manmade.data");
prepare_image_set("natural_trainning","means_natural.data");
end
function y = reconstruct(image_path)
features_prep = knn_preTrainning();
[feature_trainning,feature_testing,label_trainning,label_testing] = load_features();
model = train(feature_trainning,label_trainning);
feature_target = features_prep.edge_feature("targets","target",30);
label = predict(model,feature_target);
if strcmp(label,"manmade") == 1
    reconstruct_image("./targets/target.jpg",20,"./manmade_trainning/means_manmade.data","manmade_trainning/modified");
else
    reconstruct_image("./targets/target.jpg",20,"./natural_trainning/means_natural.data","natural_trainning/modified");
end
end
function y = full_testing()
[feature_trainning,feature_testing,label_trainning,label_testing] = load_features();
model = train(feature_trainning,label_trainning);
y = predict_testing(model,feature_testing,label_testing);
end
function generate_files(number_of_bins)
features_prep = knn_preTrainning();
features_prep.edge_feature("natural_trainning","feature_natural.data",number_of_bins);
features_prep.edge_feature("manmade_trainning","feature_manmade.data",number_of_bins);
features_prep.edge_feature("natural_testing","feature_natural_testing.data",number_of_bins);
features_prep.edge_feature("manmade_testing","feature_manmade_testing.data",number_of_bins);
end
function [feature_trainning,feature_testing,label_trainning,label_testing] = load_features()
features_prep = knn_preTrainning();
feature_trainning = [features_prep.load_features_from_file("./modified/feature_natural.data");features_prep.load_features_from_file("./modified/feature_manmade.data")];
feature_testing = [features_prep.load_features_from_file("./modified/feature_natural_testing.data");features_prep.load_features_from_file("./modified/feature_manmade_testing.data")];
label_trainning = [features_prep.generate_labels("natural_trainning","natural"),features_prep.generate_labels("manmade_trainning","manmade")];
label_testing = [features_prep.generate_labels("natural_testing","natural"),features_prep.generate_labels("manmade_testing","manmade")];
end
function y = train(features,labels)
%y = fitcknn(features,labels,'NumNeighbors',5,"Standardize",1);
y= fitcknn(features,labels,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'))
end
function y = predict_testing(model,features,labels)
    label = predict(model, features);
    result = strcmp(label,labels.');
    sum(result)
    numel(result)
    y = sum(result)/numel(result);
end
function y = predict_manmade(model, features)
    label = predict(model, features);
    result = strcmp(label,"manmade");
    sum(result)
    numel(result)
    y = sum(result)/numel(result);
end
function y = predict_natural(model, features)
label = predict(model, features);
    result = strcmp(label,"natural");
    sum(result)
    numel(result)
    y = sum(result)/numel(result);
end