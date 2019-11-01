% Ear image data are under
cd('/project/BICF/BICF_Core/s167719/RamiHallac/BIOHPC-Ear')

net = googlenet;
inputSize = net.Layers(1).InputSize(1:2)

imds = imageDatastore('all_data_updated10102018', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
imds.ReadFcn = @(loc)imresize(imread(loc),round(inputSize*0.6));


rng(123) % fix the random seed for the test purpose
[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.6,0.2,'randomized');

% % %Replace Final Layers
%if the network is a SeriesNetwork object(such as AlexNet, VGG-16, or VGG-19), then convert the list of layers in net.Layers to a layer graph
if isa(net,'SeriesNetwork') 
  lgraph = layerGraph(net.Layers); 
else
  lgraph = layerGraph(net);
end

lgraph = removeLayers(lgraph,{'pool5-drop_7x7_s1','loss3-classifier','prob','output'});

numClasses = numel(categories(imdsTrain.Labels));
newLayers = [
    dropoutLayer(0.6,'Name','newDropout')
    fullyConnectedLayer(numClasses,'Name','fc','WeightLearnRateFactor',5,'BiasLearnRateFactor',5)
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classoutput')];
lgraph = addLayers(lgraph,newLayers);

lgraph = connectLayers(lgraph,'pool5-7x7_s1','newDropout');

imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandYReflection',false, ...
    'RandXTranslation',[-10 10], ... %[-50 50], ...
    'RandYTranslation',[-5 5],...
    'RandXScale', [1.0 1.1], ...
    'RandYScale', [1.0 1.1], ...
    'RandRotation', [-15 15]);

augimdsTrain = augmentedImageDatastore(inputSize,imdsTrain, 'DataAugmentation',imageAugmenter);

% To automatically resize the validation images without performing further data augmentation
augimdsValidation = augmentedImageDatastore(inputSize,imdsValidation, 'DataAugmentation', imageAugmenter);

options = trainingOptions('sgdm', ...
    'MiniBatchSize',50,...%100, ...
    'MaxEpochs', 300, ...%150,...%300, ...
    'InitialLearnRate',1e-4, ...%1e-4, ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'ValidationPatience',Inf, ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train the network that consists of the transferred and new layers
netTransfer = trainNetwork(augimdsTrain,lgraph,options);

% Classify the validation images using the fine-tuned network.
augimdsTest = augmentedImageDatastore(inputSize,imdsTest);
[YPred,scores] = classify(netTransfer,augimdsTest);

% Calculate the classification accuracy on the validation set.
YTest = imdsTest.Labels;
accuracy = mean(YPred == YTest)
confusionmat(YTest, YPred)
