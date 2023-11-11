function res = runMatlabModel(data)
    %%%
    % This is starter code for where you should add your MATLAB model.
    % You can place this wherever you want, but keep the function name
    % This function should take in a bunch of data from the EMG sensor
    % and return rock, paper, and scissors, based on what your model
    % predicts. 
    %%%
    % disp(data)
    disp("running model")
    disp("preprocessing data")
    disp("data size: "+size(data))
    % save("ooga.mat","data")
    filtereddata=preprocessData(data(end-1399:end,:))';
    % filtereddata=preprocessData(data(1:1400,:))';
    % filtereddata=preprocessData(data)';
    disp("filtered data size: "+size(filtereddata))
    disp("extracting features")
    featuretable = extractFeatures(filtereddata, bestTwoFeatures(), 1000);
    disp("feature columns: "+featuretable.Properties.VariableNames)
    disp("loading classifier")
    load("classifier.mat","currentClassifier");
    disp("running classifier")
    res = currentClassifier.predict(featuretable);
    labels={"rock","paper","scissors"};
    disp("prediction: "+labels(res))
    disp(res)
    %Pison SALUS - 55A07984 ADC
    %Pison SALUS - 55A0E730 ADC
end