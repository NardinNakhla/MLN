% store data in vectors of features and classes
% input the feature vector of the test abstract
%compute the distance from each other point in all dimensions and get
%nearest k points
%using the weighting function calculate the weight for each class

% Xtest=rand(1,100);
% X=importdata('features.csv');
% %Xtest=importdata('output_features.csv');
% Xtest=X(96114:end,:);
% X=X(1:96113,:);
% 
% Y=importdata('train_output.csv');
% Ytest=Y(96115:end,:);
% Y=Y(2:96114,:);
% 
% % Ytest=importdata('test_output_random.csv');
% %  Ytest=Ytest(2:end,:);
% 

% for h=1:length(Ytest)
%     nana=Ytest{h,1};
%     mama=strfind(nana,'"cs"');
%     if isempty(mama)
%         mama=strfind(nana,'"math"');
%         if isempty(mama)
%             mama=strfind(nana,'"physics"');
%              if isempty(mama)
%                mama=strfind(nana,'"stat"'); 
%              end
%         end
%     end
%     Ytest{h,1}=nana(mama:end);
% end
% 
% for hh=1:length(Y)
%     nana=Y{hh,1};
%     mama=strfind(nana,'"cs"');
%     if isempty(mama)
%         mama=strfind(nana,'"math"');
%         if isempty(mama)
%             mama=strfind(nana,'"physics"');
%              if isempty(mama)
%                mama=strfind(nana,'"stat"'); 
%              end
%         end
%     end
%     Y{hh,1}=nana(mama:end);
% end
%load('X1.mat');
%load('Xtest.mat');
%load('Y1.mat');
%load('Ytest1.mat');
%load('Distance.mat');
% Xtest=X(96114:end,:);
% X=X(1:96113,:);
%features=[X1001,X2001];
 X=X2001(Train,:);
 Xtest=X2001(Test,:);
 Ytest=Y(Test);
 Y=Y(Train);
 sigma2=4;
%  Xtest=X(1:1000,:);
% X=X(1001:end,:);
%  Ytest=Y(1:1000,:);
%  Y=Y(1001:end,:);
%   X=X2001;
%  Xtest=X(95211:end,:);
% X=X(1:95210,:);
%  Ytest=Y(95211:end,:);
%  Y=Y(1:95210,:);
count2=0;
features_num=length(X(1,:));
abs_num=length(X(:,1));
D=D2001;
% distance=repmat(Xtest,[abs_num 1])-X;
K=[1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39];
for z=1:length(K)
    count2=0;
for l=1:length(Ytest)
% for i=1:abs_num
% for j=1:features_num
% d(j)=(Xtest(l,j)-X(i,j))^2;
% end
% D(i)=sum(d,2);
% end

Dnew=D(l,:);
for k=1:K(z)
[point(k),idx(k)]=min(Dnew);
Dnew(idx(k))=max(Dnew);
%Y(idx(k))
end
w_cs=0;
w_math=0;
w_physics=0;
w_stat=0;
for k=1:K(z)
    if strcmp(Y(idx(k)),'"cs"')
        w_cs=w_cs+ exp(-D(l,idx(k))/sigma2);%1/D(l,idx(k));%
    else
        if strcmp(Y(idx(k)),'"math"')
        w_math=w_math+  exp(-D(l,idx(k))/sigma2);%1/D(l,idx(k));%
        else
            if strcmp(Y(idx(k)),'"physics"')
        w_physics=w_physics+ exp(-D(l,idx(k))/sigma2);%1/D(l,idx(k));%
            else
                if strcmp(Y(idx(k)),'"stat"')
        w_stat=w_stat+  exp(-D(l,idx(k))/sigma2);%1/D(l,idx(k));%
                end
            end
        end
    end
end
if w_cs>=w_math && w_cs>=w_physics && w_cs>=w_stat
    Ynew{l,1}='"cs"';
else if w_math>=w_cs && w_math>=w_physics && w_math>=w_stat
        Ynew{l,1}='"math"';
    else if w_physics>=w_math && w_physics>=w_cs && w_physics>=w_stat
            Ynew{l,1}='"physics"';
        else if w_stat>=w_math && w_stat>=w_physics && w_stat>=w_cs
                Ynew{l,1}='"stat"';
            end
        end
    end
end
if strcmp(Ynew{l,1},Ytest{l,1})
    count2=count2+1;
end
l
end
accuracy(z)=count2/length(Ytest);
end
accuracytable_2=[K;accuracy];
plot(accuracytable_05(1,:),accuracytable_05(2,:),'b')
hold on
plot(accuracytable_1Gaus2s(1,:),accuracytable_1Gaus2s(2,:),'r')
hold on
plot(accuracytable_2(1,:),accuracytable_2(2,:),'g')
% hold on
% plot(accuracytable_d2(1,:),accuracytable_d2(2,:),'o')
% hold on
% plot(accuracytable_d(1,:),accuracytable_d(2,:),'c')
