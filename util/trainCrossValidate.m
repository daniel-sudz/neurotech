% crossValidate(_,_)
%   perform k-fold cross-validation
function [Y_predict] = trainCrossValidate(train_X, train_Y, num_folds)
    % partition data with built in function into k-folds
    cvp_kfold = cvpartition(train_Y, 'KFold', num_folds);
    
    % Make empty vector to store predictions from k-fold cross-validation
    Y_predict = NaN(length(train_Y),1);
    
    % Loop through all the folds
    for fold = 1:num_folds
        % create model with partial training data
        kfold_partial_data_X_train = train_X(cvp_kfold.training(fold), :);
        kfold_partial_data_y_train = train_Y(cvp_kfold.training(fold), :);
        kfold_classifier = createModel(kfold_partial_data_X_train,kfold_partial_data_y_train);

        % test on the remaining training data
        kfold_predictions = kfold_classifier.predict(train_X(cvp_kfold.test(fold), :));

        % Store predictions in the original order
        Y_predict(cvp_kfold.test(fold), :) = kfold_predictions;
    end
end
