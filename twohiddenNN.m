nNeuron1=800;%neurons per layer
nNeuron2=300;
nClass=10;
X1=X.data(:,2:end);
X1=reshape(X1,[50000 48 48]);
X1=X1(:,5:44,5:44);
X1=reshape(X1,[50000 1600]);
Xtr=X1(1:45000,:);
Xte=X1(45001:end,:);

Y1=Y.data(:,2);
Ytemp=zeros(length(Y1),10);
for k=1:length(Y1)
    Ytemp(k,Y1(k)+1)=1;
end
Ytr=Ytemp(1:45000,:);
Yte=Y1(45001:end);

LR=0.0005; %learning rate alpha

Winput=random('normal',0.001,0.01,length(Xtr(1,:))+1,nNeuron1+1);
%Wh=randi([0.01 0.1],nNeuron,nNeuron);%nhidden,nNeuron,nNeuron);
Whidden=random('normal',0.001,0.01,nNeuron1+1,nNeuron2+1);
Woutput=random('normal',0.001,0.01,nNeuron2+1,nClass);
output1=ones(1,nNeuron1+1);
outputh=ones(1,nNeuron2+1);
output2=ones(1,nClass);
StopFlag=0;
papa=1;
%%
while ~StopFlag
for k=1:length(Xtr(:,1))
% for each example
    Xinput=[1,Xtr(k,:)]';
%input to hidden layer

a1=Winput'*Xinput;
output1=tanh(a1);
a2=Whidden'*output1;
outputh=tanh(a2);
%hidden to output layer
a3=Woutput'*outputh;
output2=tanh(a3);
delta3=output2'-Ytr(k,:);

delta2=(ones(nNeuron2+1,1)-(outputh.^2)).*(Woutput*delta3');
delta1=(ones(nNeuron1+1,1)-(output1.^2)).*(Whidden*delta2);
Winput=Winput-LR*(Xinput*delta1');
Whidden=Whidden-LR*(output1*delta2');
Woutput=Woutput-LR*(outputh*delta3);
Err(k)=0.5*sum((Ytr(k,:)'-output2).^2);
end
Error(papa)=sum(Err);
if Error(papa)<0.01
        StopFlag = 1;
 end
    papa=papa+1
    figure(1);
   plot(Error)
   if mod(papa,50)==0
       name=['wnew',num2str(papa),'.mat'];
       save (name,'Winput','Whidden','Woutput')
   end
if papa==200
    StopFlag=1;
end
end
%% calculatin test Acc
count =0;
Yte1=Ytemp(45001:end,:);
%output1=ones(1,nNeuron+1);
for k=1:length(Yte)
    Xinput=[1,Xte(k,:)];
a1=Winput'*Xinput';
output1=tanh(a1);
a2=Whidden'*output1;
outputh=tanh(a2);
a3=Woutput'*outputh;
output2=tanh(a3);

[maximum,Ypredict(k)]=max(output2);
    if (Ypredict(k)-1)==Yte(k)
        count=count+1;
    end
    Err_test(k)=0.5*sum((Yte1(k,:)'-output2).^2);
end
Error_test=sum(Err_test);
accuracy_test=count/length(Yte(:,1));
%% calculatin train Acc
count2 =0;
Ytr1=Y1(1:45000,:);
%output1=ones(1,nNeuron+1);
for k=1:45000
    Xinput=[1,Xtr(k,:)];
a1=Winput'*Xinput';
output1=tanh(a1);
a2=Whidden'*output1;
outputh=tanh(a2);
a3=Woutput'*outputh;
output2=tanh(a3);

[maximum,Ypredict(k)]=max(output2);
    if (Ypredict(k)-1)==Ytr1(k)
        count2=count2+1;
    end
    %Err_test(k)=0.5*sum((Yte1(k,:)'-output2).^2);
end
%Error_test=sum(Err_test);
accuracy_train=count2/45000;