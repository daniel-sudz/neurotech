% calculateMetrics(_,_)
%   calculates metrics such as accuracy, precision, and recall
function [accuracy, f1_rock, f1_paper, f1_scissors] = calculateMetrics(predicted_Y, true_Y)
    accuracy = sum(predicted_Y == true_Y) / length(true_Y);
    
    % create some helper functions 
    calc_true_pos = @(label) (sum((true_Y == label) & (predicted_Y == label)) / sum(true_Y == label));
    calc_false_pos = @(label) (sum((true_Y ~= label) & (predicted_Y == label)) / sum(true_Y ~= label));
    calc_precision = @(label) (sum((true_Y == label) & (predicted_Y == label)) / sum(predicted_Y == label));
    calc_f1 = @(label) ((2 * calc_precision(label) * calc_true_pos(label)) / (calc_precision(label) +  calc_true_pos(label)));
    
    % calculate the f1 scores for each label
    f1_rock = calc_f1(1);
    f1_paper = calc_f1(2);
    f1_scissors = calc_f1(3);
end
