
dataset = getenv("DATASET");
best_two_features = bestTwoFeatures();
[train_X, train_Y] = loadFeaturesToXY(strcat("features/train/",dataset), best_two_features);

model = createModel(train_X, train_Y);
save(strcat("models/", dataset), "model");
