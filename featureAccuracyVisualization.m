
dataset = "exampleEMGdata180_120_Train_Test.mat";

% calculate cross-validation accuracy for each feature
wave_form_acc = get_accuracy_for_feature_list(dataset, {'waveformlength_'});
mean_abs_value_acc = get_accuracy_for_feature_list(dataset, {'meanabsvalue_'});
improved_mean_abs_value_acc = get_accuracy_for_feature_list(dataset, {'improved1meanabsvalue_'});
root_mean_squared_acc = get_accuracy_for_feature_list(dataset, {'rootmeansquared_'});
wilson_amp_acc = get_accuracy_for_feature_list(dataset, {'wilsonamp_'});
mean_power_acc = get_accuracy_for_feature_list(dataset, {'meanpower_'});

all_feature_accuracies = [
    wave_form_acc, ...
    mean_abs_value_acc, ...
    improved_mean_abs_value_acc, ...
    root_mean_squared_acc, ...
    wilson_amp_acc, ...
    mean_power_acc
];
all_features_labels = {
    'Wave Form Length', ...
    'Mean Absolute Value', ...
    'Improved Mean Absolute Value', ...
    'Root Mean Squared', ...
    'Wilson Amplitude', ...
    'Mean Power'
};

figure(); hold on;
fontsize(gcf, 12, "points")
title('5-Fold Cross Validation Training Accuracy by Feature')
xlabel('Feature Used');
ylabel('Accuracy');
bar(all_features_labels, all_feature_accuracies);
gca.Toolbar.Visible = 'off';
exportgraphics(gcf, strcat("plots/training-accuracy-cross.png"),'Resolution',300)




function [accuracy] = get_accuracy_for_feature_list(dataset, feature_list)
    [train_X, train_Y] = loadFeaturesToXY(strcat("features/train/",dataset), feature_list);
    Y_predict = trainCrossValidate(train_X, train_Y, 5);
    [accuracy, ~, ~, ~] = calculateMetrics(Y_predict, train_Y);
end
