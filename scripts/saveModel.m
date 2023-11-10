
dataset = getenv("DATASET");
best_two_features = {'waveformlength_', 'rootmeansquared_'};
[train_X, train_Y] = loadFeaturesToXY(strcat("features/train/",dataset), best_two_features);

model = createModel(train_X, train_Y);
save(strcat("models/", dataset), "model");
