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
