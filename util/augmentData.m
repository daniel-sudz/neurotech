% AugmentData(_)
%   augments the training data to improve accuracy 
function [output_data_ch_time_trial] = augmentData(input_data_ch_time_trial)
   output_data_ch_time_trial = input_data_ch_time_trial;
    
   % add random training noise
    random_augment_factor = max(input_data_ch_time_trial, [], "all") * 0.0001;
    for i = 1: size(input_data_ch_time_trial, 1)
        for j = 1: size(input_data_ch_time_trial, 2)
            for k = 1: size(input_data_ch_time_trial, 3) 
                output_data_ch_time_trial(i,j,k) = output_data_ch_time_trial(i,j,k) + ((2*rand()-1) * random_augment_factor);
            end
        end
    end
end
