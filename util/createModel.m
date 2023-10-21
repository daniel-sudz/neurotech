% createModel(_,_)
%   creates a model based on train input and returns the model
function [model] = createModel(X, Y)
    % create a KNN model
    model = fitcknn(X, Y, "NumNeighbors",3);
end
