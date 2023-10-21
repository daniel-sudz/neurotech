

% offlineClassification("exampleEMGdata180_120_Train_Test.mat", {'var', 'mean'})
%   runs the offline classifier e2e
%
% dataset: string
%   the name of the extracted features inside of the "features"
%   folder ex: exampleEMGdata180_120_Train_Test.mat
%
% feature_list: [string]
%   features that contain a substring from the feature_list will be used
function [] = offlineClassification(dataset, feature_list)
    % load test/train sets
    [train_X, train_Y] = loadFeaturesToXY(strcat("features/train/",dataset), feature_list);
    [test_X, test_Y] = loadFeaturesToXY(strcat("features/test/",dataset), feature_list);
    
    model = createModel(train_X, train_Y);
end


% createModel(_,_)
%   creates a model based on train input and returns the model
function [model] = createModel(X, Y)
    % create a KNN model
    model = fitcknn(X, Y, "NumNeighbors",3);
end

% crossValidate(_,_)
%   perform k-fold cross-validation
function [Y_predict] = trainCrossValidate(train_X, train_Y)
    % partition data with built in function into 5-folds
    cvp_kfold = cvpartition(train_Y, 'KFold', 5);
    
    % Make empty vector to store predictions from k-fold cross-validation
    Y_predict = NaN(length(train_Y),1);
    
    % Loop through all the folds
    for fold = 1:KFolds
        % create model with partial training data
        kfold_partial_data_X_train = train_X(cvp_kfold.training(fold), :);
        kfold_partial_data_y_train = train_Y(cvp_kfold.training(fold), :);
        kfold_classifier = createClassifier(kfold_partial_data_X_train,kfold_partial_data_y_train);

        % test on the remaining training data
        kfold_predictions = kfold_classifier.predict(train_X(cvp_kfold.test(fold), :));

        % Store predictions in the original order
        Y_predict(cvp_kfold.test(fold), :) = kfold_predictions;
    end
end


% loadFeaturesToXY(_,_)
%   load the given feature dataset file into X/Y format
%   
% dataset: string
%   the name of the extracted features inside of the "features"
%   folder ex: exampleEMGdata180_120_Train_Test.mat
%
% feature_list: [string]
%   features that contain a substring from the feature_list will be used
function [X, Y] = loadFeaturesToXY(dataset, feature_list)
    % load the features 
    load(dataset, "feature_table", "labels");
    
    % select features
    all_features = feature_table.Properties.VariableNames;
    selected_features = feature_table(:, contains(all_features, feature_list));
    
    % return X/Y
    X = selected_features;
    Y = labels;
end