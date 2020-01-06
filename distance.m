% X2001=importdata('data_2clear 001 (1).csv');
% X1001=importdata('data_1001.csv');
% X=Xtf;
% Xtest=X(95211:end,:);
% X=X(1:95210,:);
% Ytest=Y(95211:end);
% Y=Y(1:95210,:);
Ytemp=Y;
%  i=1;
%     test = (indices == i); train = ~test;
%     Xtest=X1001(test,:);
%     X=X1001(train,:);
%     Ytest=Ytemp(test);
%     Y=Ytemp(train);
%X=X2001(:,:);
% Xtest=X(1:1000,:);
% %X=X(1001:end,:);
% Ytest=Y(1:1000);
% %Y=Y(1001:end);

%[Train, Test] = crossvalind('HoldOut',96210, 0.02);

X=X1001(Train,1:500);
Xtest=X1001(Test,1:500);
Y=Ytemp(Train);
Ytest=Ytemp(Test);
features_num=length(X(1,:));
abs_num=length(X(:,1));
D500=zeros(length(Xtest(:,1)),abs_num);
for l=1:length(Xtest(:,1))
%for i=1:length(X(:,1))
%for j=1:length(X(1,:))
dist=(repmat(Xtest(l,:),[abs_num 1])-X).^2;
%d(j)=(Xtest(l,j)-X(i,j))^2;
%end
D500(l,:)=sum(dist,2);
%end
l
end
