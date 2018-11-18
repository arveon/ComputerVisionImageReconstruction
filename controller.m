function controller = controller()
controller.prepare = @load_features;
controller.train = @train;
controller.predict_manmade = @predict_manmade;
controller.predict_natural = @predict_natural;

end
function [edges,gabor,labels] = load_features()
features_prep = knn_preTrainning();
edges = features_prep.load_features_from_file("./modified/edge.data");
gabor = features_prep.load_features_from_file("./modified/gabor.data");
labels = [features_prep.generate_labels("natural_trainning","natural");features_prep.generate_labels("manmade_trainning","manmade")];

end
function y = train(features,labels)
y = fitcknn(features,labels,'NumNeighbors',3,'Standardize',1);
end
function y = predict_manmade(model, features)
amount = size(features);
    amount = amount(1);
    count = 1;
    correct = 0;
    incorrect = 0;
    while count<=amount
        [label score cost] = predict(model, features(count));
        if(strcmp(label, "manmade")==1)
           correct = correct + 1;
        else
            incorrect = incorrect + 1;
        end
        count = count + 1;
    end
    y = correct/(count-1);
end
function y = predict_natural(model, features)
amount = size(features);
    amount = amount(1);
    count = 1;
    correct = 0;
    incorrect = 0;
    while count<=amount
        [label score cost] = predict(model, features(count));
        if(strcmp(label, "natural")==1)
           correct = correct + 1;
        else
            incorrect = incorrect + 1;
        end
        count = count + 1;
    end
    y = correct/(count-1);
end