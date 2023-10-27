%{ 
    Takes all raw data files under datasets/raw, processes them with the
    provided scripts and then creates a training/test split for the
    remainder of the pipeline.
%} 

% output dataset name
output_dataset = "raw_combined.mat";

% files to process
raw_file_list = dir(fullfile('datasets/raw', '/**/*.mat'));

% configure the train/split test
train_split = 0.8;

% final output
combined_preprocessed_data = [];
combined_preprocessed_labels = [];

% do the actual preprocessing
for file = 1 : length(raw_file_list)
    % preprocess data
    file_path = fullfile(raw_file_list(file).folder, raw_file_list(file).name);
    load(file_path);
    [epoched_data, gesture_list] = preprocessData(lsl_data, marker_data);

    % split case on whether we are combining or on the first file
    if(file == 1)
        combined_preprocessed_data = epoched_data;
        combined_preprocessed_labels = gesture_list;
    else
        combined_preprocessed_data = permute(combined_preprocessed_data, [3,2,1]);
        combined_preprocessed_data = [combined_preprocessed_data; permute(epoched_data, [3,2,1])];
        combined_preprocessed_data = permute(combined_preprocessed_data, [3,2,1]);

        combined_preprocessed_labels = [combined_preprocessed_labels; gesture_list];
    end
end



% do the train/split process
train_selector = rand(size(combined_preprocessed_data, 3), 1) <= train_split;
test_selector = ~train_selector;

% save out the files
save_dataset(strcat("datasets/train/", output_dataset), 997.4901, combined_preprocessed_data(:,:,train_selector), 1000, [1;2;3], combined_preprocessed_labels(train_selector), 4);
save_dataset(strcat("datasets/test/", output_dataset), 997.4901, combined_preprocessed_data(:,:,test_selector), 1000, [1;2;3], combined_preprocessed_labels(test_selector), 4);


function [] = save_dataset(save_location, actualFs, dataChTimeTr, Fs, label_names, labels, numCh)
    save(save_location, "actualFs", "dataChTimeTr", "Fs", "label_names", "labels", "numCh");
end

