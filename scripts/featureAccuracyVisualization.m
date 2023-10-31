
dataset = getenv("DATASET");

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

% create feature accuracy chart
figure(); hold on;
fontsize(gcf, 12, "points")
title('5-Fold Cross Validation Training Accuracy by Feature')
xlabel('Feature Used');
ylabel('Accuracy');
bar(all_features_labels, all_feature_accuracies);
gca.Toolbar.Visible = 'off';
exportgraphics(gcf, strcat("plots/training-accuracy-cross.png"),'Resolution',300)
close all;

% create the final model and save accuracy metrics
best_two_features = {'waveformlength_', 'rootmeansquared_'};
[train_X, train_Y] = loadFeaturesToXY(strcat("features/train/",dataset), best_two_features);
[test_X, test_Y] = loadFeaturesToXY(strcat("features/test/",dataset), best_two_features);

% metrics for final cross train
cross_Y_predict = trainCrossValidate(train_X, train_Y, 5);
[cross_train_accuracy, cross_train_f1_rock, cross_train_f1_paper, cross_train_f1_scissors] = calculateMetrics(cross_Y_predict, train_Y);

% metrics for final cross test
final_model = createModel(train_X, train_Y);
test_Y_predict = final_model.predict(test_X);
[test_accuracy, test_f1_rock, test_f1_paper, test_f1_scissors] = calculateMetrics(test_Y_predict, test_Y);

% save table
final_metrics_table = array2table( ...
    [cross_train_accuracy, test_accuracy; ...
    cross_train_f1_rock, test_f1_rock;  ...
    cross_train_f1_paper, test_f1_paper; ...
    cross_train_f1_scissors, test_f1_scissors]', ...
    'VariableNames', {'Accuracy', 'F1 Rock', 'F1 Paper', 'F1 Scissors'}, ...
    'RowNames', {'Cross Validation', 'Test'});

fig = uifigure('Position',[0 0 500 76]);
uit = uitable(fig, "Data", final_metrics_table);
uit.Position = [0 0 500 76];
exportapp(fig, strcat("plots/final_metrics.png"))
close(findall(0, 'type', 'figure'));

% create confusion matrix for test data
cm = confusionchart(label_matrix_to_string_matrix(test_Y), label_matrix_to_string_matrix(test_Y_predict));
cm.Title = 'Two Feature Test Confusion Matrix';
fontsize(gcf, 12, "points")
exportgraphics(gcf, strcat("plots/test-confusion-chart.png"),'Resolution',300)
close all;

% create confusion matrix for cross validation
cm = confusionchart(label_matrix_to_string_matrix(train_Y), label_matrix_to_string_matrix(cross_Y_predict));
cm.Title = 'Two Feature Training Cross Validation Confusion Matrix';
fontsize(gcf, 12, "points")
exportgraphics(gcf, strcat("plots/training-cross-validation-confusion-chart.png"),'Resolution',300)
close all;


function [accuracy] = get_accuracy_for_feature_list(dataset, feature_list)
    [train_X, train_Y] = loadFeaturesToXY(strcat("features/train/",dataset), feature_list);
    Y_predict = trainCrossValidate(train_X, train_Y, 5);
    [accuracy, ~, ~, ~] = calculateMetrics(Y_predict, train_Y);
end

function [string_labels] = label_matrix_to_string_matrix(labels)
     rock = repmat({'Rock'}, length(labels), 1);
     paper = repmat({'Paper'}, length(labels), 1);
     scissors = repmat({'Scissors'}, length(labels), 1);
     
     string_labels = repmat({''}, length(labels), 1);
     string_labels(labels==1) = {'Rock'};
     string_labels(labels==2) = {'Paper'};
     string_labels(labels==3) = {'Scissors'};

    
end
