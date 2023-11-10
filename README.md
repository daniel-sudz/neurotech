# EEG: Rock, Paper, Scissors Classification
https://github.com/daniel-sudz/neurotech

# Runing live 
```bash
DATASET="raw_combined.mat" ./scripts/live/testData
```

# Extracted Feature Histograms of Training Data by Label

### Mean Absolute Value
<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/features/training-Mean-Abs-Value.png?raw=true" width="500"/>  
</p>

Mean absolute value (https://link.springer.com/article/10.1007/s00779-019-01285-2). The MAV is the mean of the absolute value of the EMG signal amplitude. (fvalues = trials x channgels)

### Improved Mean Absolute Value

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/features/training-Improved-Mean-Abs-Value-1.png?raw=true" width="500"/>  
</p>

Improved Mean Absolute Value 1 (https://link.springer.com/article/10.1007/s00779-019-01285-2). The MAV1 provides a higher weighting to the more central points in the observed window which can improve the robustness of the MAV feature. (fvalues = trials x channgels)

### Wave Form Length

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/features/training-Wave-Form-Length.png?raw=true" width="500"/>  
</p>

Waveform length (https://link.springer.com/article/10.1007/s00779-019-01285-2). Waveform length represents the sum of amplitude changes between adjacent data to represent the degree of change in the amplitude of the signal. (fvalues = trials x channgels)


### Root Mean Squared

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/features/training-Root-Mean-Squared.png?raw=true" width="500"/>  
</p>

Root mean squared (https://link.springer.com/article/10.1007/s00779-019-01285-2). The RMS can be used to measure the power of an EMG signal which would correlate to the amount of muscle activation. RMS is calculated by taking the square root of the average squared value of the input data. (fvalues = trials x channgels)

### Mean Power

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/features/training-Mean-Power.png?raw=true" width="500"/>  
</p>

Mean power (https://link.springer.com/article/10.1007/s00779-019-01285-2). MNP represents the average power of the EMG signal power spectrum. (fvalues = trials x channgels)

### Wilson Amplitude

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/features/training-Wilson-Apmlitude.png?raw=true" width="500"/>  
</p>

Wilson amplitude (https://link.springer.com/article/10.1007/s00779-019-01285-2). The WAMP is a measure of the amount of times the difference in signal amplitude exceedes a given threshold. We use a threshold of 5e3. (fvalues = trials x channgels)

# Cross Validation Accuracy By Feature

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/training-accuracy-cross.png?raw=true" width="500"/>  
</p>

# Final Metrics For Two Features (Wave Form Length + Root Mean Squared)

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/final_metrics.png?raw=true" width="500"/>  
</p>

# Confusion Chart Training Cross Validation

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/training-cross-validation-confusion-chart.png?raw=true" width="500"/>  
</p>

# Confusion Chart Testing Data

<p align="center">
  <img src="https://github.com/daniel-sudz/neurotech/blob/main/plots/test-confusion-chart.png?raw=truee" width="500"/>  
</p>
