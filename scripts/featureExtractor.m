

% Respective files should be placed in the train/test folder with same name
datasets = {"anotherDay.mat"};

% Features to extract, implemented in extractFeatures(_,_,_) function
includedFeatures = {'variance','waveformlength', 'meanabsvalue', 'rootmeansquared', 'wilsonamp', 'improved1meanabsvalue', 'meanpower'}; 

% Save the extracted features to the features folderx`
for dataset = 1 : length(datasets)
    dataset_name = datasets{dataset};

    % save the train features
    load(strcat("datasets/train/", dataset_name));
    feature_table = extractFeatures(dataChTimeTr,includedFeatures,Fs);
    save(strcat("features/train/", dataset_name), "feature_table","labels");

    % save the test features
    load(strcat("datasets/test/", dataset_name));
    feature_table = extractFeatures(dataChTimeTr,includedFeatures,Fs);
    save(strcat("features/test/", dataset_name), "feature_table","labels");

end



function [feature_table] = extractFeatures(dataChTimeTr,includedFeatures, Fs)
    
    % List of channels to include (can change to only use some)
    includedChannels = 1:size(dataChTimeTr,1);
    
    % Empty feature table
    feature_table = table();

    
    for f = 1:length(includedFeatures)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calcuate feature values for 
        % fvalues should have rows = number of trials
        % usually fvales will have columns = number of channels (but not if
        % it is some comparison between channels)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Check the name of each feature and hop down to that part of the
        % code ("case" is like... in the case that it is this thing.. do
        % this code)
        switch includedFeatures{f}

            % Variance  
            % variance represents the average squared deviation of the
            % signal from the mean. In this case, the signal is all of the
            % timepoints for a single channel and trial.
            %(fvalues = trials x channels)
            case 'variance'
                fvalues = squeeze(var(dataChTimeTr,0,2))';
            
            % Waveform length (https://link.springer.com/article/10.1007/s00779-019-01285-2)
            % waveform length represents the sum of amplitude changes
            % between adjacent data to represent the degree of change in
            % the amplitude of the signal. 
            % (fvalues = trials x channgels)
            case 'waveformlength'
                fvalues = squeeze(sum(abs(diff(dataChTimeTr, 1, 2)), 2))';
            
            % Mean absolute value (https://link.springer.com/article/10.1007/s00779-019-01285-2)
            % the MAV is the mean of the absolute value of the EMG signal
            % amplitude.
            case 'meanabsvalue'
                fvalues = squeeze(sum(abs(dataChTimeTr), 2) ./ size(dataChTimeTr, 3))';
            
            % Root mean squared (https://link.springer.com/article/10.1007/s00779-019-01285-2)
            % The RMS can be used to measure the power of an EMG signal
            % which would correlate to the amount of muscle activation. 
            % RMS is calculated by taking the square root of the average
            % squared value of the input data
            case 'rootmeansquared'
                fvalues = squeeze(sqrt(sum((dataChTimeTr .^ 2), 2) ./ size(dataChTimeTr, 3)))';
            
            % Wilson amplitude (https://link.springer.com/article/10.1007/s00779-019-01285-2)
            % The WAMP is a measure of the amount of times the difference
            % in signal amplitude exceedes a given threshold. We use a
            % threshold of 5e3.
            case 'wilsonamp'
                wilson_threshold = 5e3;
                fvalues = squeeze(sum(abs(diff(dataChTimeTr, 1, 2)) > wilson_threshold, 2))';
            
            % Improved Mean Absolute Value 1 (https://link.springer.com/article/10.1007/s00779-019-01285-2)
            % The MAV1 provides a higher weighting to the more central
            % points in the observed window which can improve the
            % robustness of the MAV feature. 
            case 'improved1meanabsvalue'
                series_length = size(dataChTimeTr, 3);
                slice1 = sum(abs(dataChTimeTr(:, 1:(series_length * 0.25), :)), 2);
                slice2 = sum(abs(dataChTimeTr(:, (series_length * 0.25):(series_length * 0.75), :)), 2);
                slice3 = sum(abs(dataChTimeTr(:, (series_length * 0.75): series_length, :)), 2);
                weighted_slices = (slice1 * 0.25) + slice2 + (slice3 * 0.25);
                fvalues = squeeze(weighted_slices ./ series_length)';
            
            % Mean power (https://link.springer.com/article/10.1007/s00779-019-01285-2)
            % MNP represents the average power of the EMG signal power
            % spectrum. 
            case 'meanpower'
                fvalues = zeros(size(dataChTimeTr, 3), size(dataChTimeTr, 1));
                for i = 1 : size(fvalues, 1)
                    for j = 1: size(fvalues, 2)
                        fvalues(i,j) = bandpower(dataChTimeTr(j,:,i));
                    end
                end


            otherwise
                % If you don't recognize the feature name in the cases
                % above
                disp(strcat('unknown feature: ', includedFeatures{f},', skipping....'))
                break % This breaks out of this round of the for loop, skipping the code below that's in the loop so you don't include this unknown feature
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Put feature values (fvalues) into a table with appropriate names
        % fvalues should have rows = number of trials
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % If there is only one feature, just name it the feature name
        if size(fvalues,2) == 1
            feature_table = [feature_table table(fvalues,...
                'VariableNames',string(strcat(includedFeatures{f})))];
        
        % If the number of features matches the number of included
        % channels, then assume each column is a channel
        elseif size(fvalues,2) == length(includedChannels)
            %Put data into a table with the feature name and channel number
            for  ch = includedChannels
                feature_table = [feature_table table(fvalues(:,ch),...
                    'VariableNames',string(strcat(includedFeatures{f}, '_' ,'Ch',num2str(ch))))]; %#ok<AGROW>
            end
        
        
        else
        % Otherwise, loop through each one and give a number name 
            for  v = 1:size(fvalues,2)
                feature_table = [feature_table table(fvalues(:,v),...
                    'VariableNames',string(strcat(includedFeatures{f}, '_' ,'val',num2str(v))))]; %#ok<AGROW>
            end
        end
    end
end