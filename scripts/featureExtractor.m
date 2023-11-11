

% Respective files should be placed in the train/test folder with same name
datasets = dir(fullfile('datasets/train', '/**/*.mat'));

% Features to extract, implemented in extractFeatures(_,_,_) function
includedFeatures = {'variance','waveformlength', 'meanabsvalue', 'rootmeansquared', 'wilsonamp', 'improved1meanabsvalue', 'meanpower'}; 

% Save the extracted features to the features folderx`
for dataset = 1 : length(datasets)
    dataset_name = datasets(dataset).name;

    % save the train features
    load(strcat("datasets/train/", dataset_name));
    feature_table = extractFeatures(ChTimeTr,includedFeatures,Fs);
    save(strcat("features/train/", dataset_name), "feature_table","labels");

    % save the test features
    load(strcat("datasets/test/", dataset_name));
    feature_table = extractFeatures(dataChTimeTr,includedFeatures,Fs);
    save(strcat("features/test/", dataset_name), "feature_table","labels");

end
