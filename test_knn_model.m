function percent = test_knn_model(mdl, test_means, expected_labels)
    amount = size(test_means);
    amount = amount(1);
    count = 1;
    correct = 0;
    incorrect = 0;
    while count<=amount
        [label score cost] = predict(mdl, test_means(count));
        if(strcmp(label, expected_labels(count))==1)
           correct = correct + 1;
        else
            incorrect = incorrect + 1;
        end
        count = count + 1;
    end
    percent = correct/(count-1);
end