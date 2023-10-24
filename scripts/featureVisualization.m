
original_dataset = "datasets/train/anotherDay.mat";
features = "features/train/anotherDay.mat";

load(original_dataset);
load(features);


plot_features(feature_table.variance_Ch1, labels, "Variance")
plot_features(feature_table.waveformlength_Ch1, labels, "Wave-Form-Length")
plot_features(feature_table.meanabsvalue_Ch1, labels, "Mean-Abs-Value")
plot_features(feature_table.improved1meanabsvalue_Ch1, labels, "Improved-Mean-Abs-Value-1")
plot_features(feature_table.rootmeansquared_Ch1, labels, "Root-Mean-Squared")
plot_features(feature_table.wilsonamp_Ch1, labels, "Wilson-Apmlitude")
plot_features(feature_table.meanpower_Ch1, labels, "Mean-Power")




function [] = plot_features(feature_arr, labels, feature_name)
    figure(); hold on;
    title(strcat(feature_name, " of Channel 1 Training Data by Label"));
    for cond=1:3
        histogram(feature_arr(labels==cond), 'BinEdges', min(feature_arr):max(feature_arr)/30:max(feature_arr))
    end
    xlabel(feature_name)
    ylabel("Frequency")
    legend(string(["rock","paper","scissors"]));
    exportgraphics(gcf, strcat("plots/features/training-",feature_name,".png"),'Resolution',300)
    close(gcf);
end