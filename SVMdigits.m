%Models a given training set with a corresponding labels and 
%classifies a given test set using an SVM classifier according to a 
%one vs. all relation. 

load('z_pc.mat')
load('train_outputs.mat')
T = transpose(z_pc);
TrainingSet= T(1:10000,:); 
TestSet= T(10001:13001,:); 
TrainLabels = Y.data(1:10000,2);  
u=unique(TrainLabels);
numClasses=length(u);
result = zeros(length(TestSet(:,1)),1);

%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1v=(TrainLabels==u(k));
   options = statset('MaxIter',2000000); 
   models(k) = svmtrain(TrainingSet,G1v,'options',options,... 
  'kernel_function','rbf','rbf_sigma',16);
k
end

%classify test cases
for j=1:size(TestSet,1)
    for k=1:numClasses
        if(svmclassify(models(k),TestSet(j,:))) 
            break;
        end
    end
    if k==10
        result(j)= 0;
    else
        result(j) = k;
    end
    j
end