
%Ytemp=Y;
%indices = crossvalind('Kfold',length(X1001(:,1)),10);
for i=3:5
    test = (indices == i); train = ~test;
    Xtest=X1001(test,:);
    X=X1001(train,:);
    Ytest=Ytemp(test);
    Y=Ytemp(train);
    features_num=length(X(1,:));
    abs_num=length(X(:,1));
    D=zeros(length(Xtest(:,1)),abs_num);
    for j=1:length(Xtest(:,1))
        dist=(repmat(Xtest(j,:),[abs_num 1])-X).^2;
        D(j,:)=sum(dist,2);
        j
    end
    K=[1,5,10,15,20,25,30,35,40];
    for z=1:length(K)
        count2=0;
        for l=1:length(Ytest)
            Dnew=D(l,:);
            for k=1:K(z)
                [point(k),idx(k)]=min(Dnew);
                Dnew(idx(k))=max(Dnew);

            end
            w_cs=0;
            w_math=0;
            w_physics=0;
            w_stat=0;
            for k=1:K(z)
                if strcmp(Y(idx(k)),'"cs"')
                    w_cs=w_cs+1/D(l,idx(k));
                else
                    if strcmp(Y(idx(k)),'"math"')
                        w_math=w_math+1/D(l,idx(k));
                    else
                        if strcmp(Y(idx(k)),'"physics"')
                            w_physics=w_physics+1/D(l,idx(k));
                        else
                            if strcmp(Y(idx(k)),'"stat"')
                                w_stat=w_stat+1/D(l,idx(k));
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
        accuracy(z,i)=count2/length(Ytest);
    end
end


