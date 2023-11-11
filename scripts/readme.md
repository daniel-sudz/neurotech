# Data processing scripts

# Parameters
Set the env variable ```DATASET``` prior to running any of the data processing scripts. Ex:
```bash
export DATASET="raw_data.mat"
```

# Script Run Order 

### ```processRawData.m```
Combines data under ```datasets/raw/**``` and saves a test/train split into ```datasets/train``` and ```datasets/test```.

### ```featureExtractor.m```
Extracts features and saves them under ```features/train``` and ```features/test```.

### ```saveModel.m```
Saves a final model based on trianing data and features described in ```util/bestTwoFeatures.m```

### ```featureVisualizer.m```
Creates histogram disbtributions for features and saves plots under ```plots/features```

### ```featureAccuracyVisualization.m```
Tests feature accuracy and saves some plots under ```plots```

# Live Demo
```bash
DATASET="raw_combined.mat" ./scripts/live/testData
```
