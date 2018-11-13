function y = train_knn_model(features, labels)

    y = fitcknn(features,labels,'NumNeighbors',3,'Standardize',1);

end




