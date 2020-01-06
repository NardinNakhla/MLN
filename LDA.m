%LDA
function [score]= k_fold(training_dir, testing_dir, k)
    training_dir = 'C:\Users\labuser\Dropbox\Comp598\project 1\Dataset\training';
    testing_dir = 'C:\Users\labuser\Dropbox\Comp598\project 1\Dataset\Test';

    training = dir(training_dir);
    fileIndex = find(~[training.isdir]);
    k = 50;
    training_set = {};
    % for LDA
    N1=0; %number of birds images
    N2=0; %number of construction images
    
    for i = 1:length(fileIndex)
        training_set{i} = training(fileIndex(i)).name;
        if training(fileIndex(i)).name(1)=='b'
            N1=N1+1;
        else
            N2=N2+1;
        end
    end
    
    training_samples = length(training_set);
    fold_samples = training_samples/k;
    
    for i=1:k
        validation_images = training_set((i-1)*(fold_samples)+1 : i*(fold_samples));

        if i==1
            training_images = training_set(i*(fold_samples)+1 : (k*fold_samples));
        elseif i==k
            training_images = training_set(1:(k-1)*(fold_samples));
        else
            training_images = [training_set(1:(i-1)*fold_samples) training_set((i+1)*fold_samples+1:k*fold_samples)]; 
        end
        
        num_feature_images = 5;
        feature_birds = training_images(1:num_feature_images);
        feature_machines = training_images((length(training_images)-num_feature_images+1):length(training_images));

        num_features = 10;
        bird_centroids = construct_centroids(training_dir, feature_birds, num_features);
        machine_centroids = construct_centroids(training_dir, feature_machines, num_features);
        
        bird_mean = mean(bird_centroids)
        machine_mean = mean(machine_centroids);
        
        bird_std = std(bird_centroids)
        machine_std = std(machine_centroids);
        
        %disp(bird_centroids)
        %disp(machine_centroids)
        
        
        
        
        
        for j=1:length(training_images)
            features = feature_extraction(centroids, strcat(training_dir,'\',training_images{i}));
            % run classifiers here x(N1+N2,length(features)+1)
            % x1(length(training_images)_bird,length(features)), x2
            %x(i,K,:)=traning_set{j} %vector of all the features for image i class k
%         if training(fileIndex(i)).name(1)=='b'
%             x1(j
%         else
%             N2=N2+1;
%         end
            muo1=sum(x(:,1,:),1)/N1;
            muo2=sum(x(:,2,:),1)/N2;
            sigma1=(x(:,1,:)-repmat(muo1,N1))*transpose(x(:,1,:)-repmat(muo1,N1))/(N1+N2-2);
            sigma2=(x(:,2,:)-repmat(muo2,N2))*transpose(x(:,2,:)-repmat(muo2,N2))/(N1+N2-2);
            sigmaInv=inv(sigma1+sigma2);
            %xnew is the new image feature vector size Ntest * Nfeatures
            if transpose(xnew(i,:))*sigmaInv*(muo2-muo1)>0.5*transpose(muo2+muo1)*sigmaInv*(muo2-muo1)-log(N2/N1)
                ynew(i)=2;
            else
                Ynew(i)=1;
            end
            normpdf(features, bird_mean, bird_sigma);
            normpdf(features, machine_mean, machine_std);
            
        end
        
    end

