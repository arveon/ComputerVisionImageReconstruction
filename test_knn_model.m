function percent = test_knn_model(mdl, test_folder, expected_label)
    % get the means
    test_means = scan_means_in_folder(test_folder);
    amount = size(test_means);
    amount = amount(1);
    
     count = 1;
     correct = 0;
     incorrect = 0;
    while count<=amount
        [label score cost] = predict(mdl, test_means(count));
        if(strcmp(label, expected_label)==1)
           correct = correct + 1;
        else
            incorrect = incorrect + 1;
        end
        count = count + 1;
    end
    percent = correct/(count-1);
end