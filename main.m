%Reading file in
data=readtable('nuclear_plants_small_dataset.csv');
%Sorting normal and abnormal grouping
normal=data(strcmp(data{:,1},"Normal"),:);
abnormal=data(strcmp(data{:,1},"Abnormal"),:);
%Splitting the data
cv=cvpartition(size(data,1),'HoldOut',0.3);
idx=cv.test;
dataTrain=data(~idx,:);
dataTest=data(idx,:);
%Gets the headings of the table
headings=data.Properties.VariableNames; 
%Decision Tree
tree=fitctree(dataTrain,headings{1},'OptimizeHyperparameters','auto');
%Predicting the data using the decision tree model
treePred=predict(tree,dataTest); 
%Classification Loss
L=loss(tree,dataTrain,headings{1});
%Misclassified predictions
misClassT=sum(~strcmp(treePred,dataTest{:,1}));
%Confusion Matrix for the tree
confmatT=confusionmat(dataTest{:,1},treePred);
%Support Vector Machine
y=headings{1};
mdlS=fitcsvm(dataTrain,y,'KernelFunction','rbf',...
'OptimizeHyperparameters','auto',...
'HyperparameterOptimization',struct('AcquisitionFunctionName',...
'expected-improvement-plus','ShowPlots',true));
%Support Vectors
sv = mdlS.SupportVectors; 
%Model prediction of status
[svmPred,score]=predict(mdlS,dataTest); 
%Misclassified predicitions
misClassS=sum(~strcmp(svmPred,dataTest{:,1})); 
%Fitting model for posterior
[post,ScoreParameters]=fitPosterior(mdlS,dataTrain,y); 
%New predictions based on new fitted data
newPred=predict(post,dataTest);
newMisClassS=sum(~strcmp(newPred,dataTest{:,1}));
%Working out error rate
acc=cell(1,298);
postAcc=cell(1,298);
for i=1:height(dataTest)
    if strcmp(dataTest{i,1},svmPred{i})
        acc{i,1}=1;
    else
        acc{i,1}=0;
    end
    if strcmp(dataTest{i,1},newPred{i})
        postAcc{i,1}=1;
    else
        postAcc{i,1}=0;
    end
end
acc=cell2mat(acc);
postAcc=cell2mat(postAcc);
%Placing the predictions into a table for viewing purposes
comp=table(dataTest{:,1},svmPred,newPred,score,acc,postAcc);
comp.Properties.VariableNames={'Status','Predicted','New Predicted','Score','Accuracy','New Accuracy'};
confmatS=confusionmat(dataTest{:,1},newPred);
%Artificial Neural Network
%Tranposing the numerical training data for inputs
trainInputs=transpose(dataTrain{:,2:13});
%Convert the status to logical array, then transpose
trainTarget=transpose(strcmp(dataTrain{:,1},"Normal"));
%Setup patternet for 10 hidden layers
net=patternnet(10);
%Train data with patternnet using training data
net=train(net,trainInputs,trainTarget);
testInputs=transpose(dataTest{:,2:13});
%Estimate the targets using the trained network
testTargets=net(trainInputs);
%Assess performance
performance=perform(net,trainTarget,testTargets);