%%%
% This is starter code for where you should add your MATLAB model.
% You can place this wherever you want, but keep the function name
% This function should take in a bunch of data from the EMG sensor
% and return rock, paper, and scissors, based on what your model
% predicts. 
%%%
function res = runMatlabModel(data)
    % preprocess the data
    disp("running model")
    disp("preprocessing data")
    disp("data size: "+size(data))
    filtereddata=preprocessData(data(end-1399:end,:))';
    disp("filtered data size: "+size(filtereddata))
    
    % extract the features
    disp("extracting features")
    disp(bestTwoFeatures())
    featuretable = extractFeatures(filtereddata, bestTwoFeatures(), 1000);
    
    % load the classifier
    disp("loading classifier")
    load(strcat("models/", getenv("DATASET")), "model");
    
    % run the prediction and output results
    disp("running classifier")
    res = model.predict(featuretable);
    labels={"rock","paper","scissors"};
    disp("prediction: "+labels(res))
    disp(res)
end