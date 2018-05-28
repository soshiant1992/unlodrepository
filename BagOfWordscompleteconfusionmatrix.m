
%% bag of words
clear;
w=5;w=w-1;%window size
K=20;%number of classes for features

firstp=50;%beginperson/firstperson
lastp=64;%endperson/final person/last person
numper=lastp-firstp+1;%number of persons
data=load(['person',int2str(firstp),'-',int2str(lastp),'completehalfsecond']);
slip=cell2mat(data.data2(1,10,1));
% slip=reshape(slip,[],size(slip,3));
%% slip
for person=1:numper
    for i6= 1:36
        if rem(i6,4)==2
            for finger=1:3
                slip=[cell2mat(data.data2(person,i6,finger)),slip];
            end
        end
    end
end
count=0;
for i1=1:size(slip,1)-w
    for i2=1:size(slip,2)-w
        count=count+1;
        subslip(:,count)=slip(i1:i1+w,i2);
        
    end
end

%% grip
grip=cell2mat(data.data2(1,12,1));
for person=1:numper
    for i6= 1:36
        if rem(i6,4)==0
            for finger=1:3
                grip=[cell2mat(data.data2(person,i6,finger)),grip];
            end
        end
    end
end
for i1=1:size(grip,1)-w
    for i2=1:size(grip,2)-w
        count=count+1;
        subgrip(:,count)=grip(i1:i1+w,i2);
    end
end


%% push
push=cell2mat(data.data2(1,11,1));
for person=1:numper
    for i6= 1:36
        if rem(i6,4)==3
            for finger=1:3
                push=[cell2mat(data.data2(person,i6,finger)),push];
            end
        end
    end
end
for i1=1:size(grip,1)-w
    for i2=1:size(grip,2)-w
        count=count+1;
        subpush(:,count)=push(i1:i1+w,i2);
    end
end




%% slip
bump=cell2mat(data.data2(1,9,1));
for person=1:numper
    for i6= 1:36
        if rem(i6,4)==1
            for finger=1:3
                bump=[cell2mat(data.data2(person,i6,finger)),bump];
            end
        end
    end
end
for i1=1:size(grip,1)-w
    for i2=1:size(grip,2)-w
        count=count+1;
        subbump(:,count)=bump(i1:i1+w,i2);
    end
end

%% combine and kmeans

both=[subgrip.';subslip.';subpush.';subbump.'];
% both=both.*(both>.01);
both( ~any(both,2), : ) = [];  %rows
% data( :, ~any(data,1) ) = [];  %columns
[idx,C]=kmeans(both,K);
%% data representation
% [mapped_data, mapping] = compute_mapping(datasample(both,100,'Replace',false), 'tSNE');
% c137 = linspace(1,10,length(mapped_data));
% scatter(mapped_data(:,1),mapped_data(:,2),[],c137)
%% feature histogram makery
count=0;
for person=1:numper
    person
    for object=0:2
        for orientation=0:2
    count=count+1;
            subslip=loadsubsliporgrip(w,person,object,orientation,'slip',data);
            slipfeature=zeros(size(subgrip,2),K);
            for i=1:size(subslip,2)
                dist=vecnorm(C.'-subslip(:,i));
                [dummy,ind]=min(dist);
                slipfeature(i,ind)=1;
            end
            %         subplot(6,5,person+5*object);
            %         bar(sum(slipfeature))
            slipbar(count,:)=sum(slipfeature);
            %         grid on;
            %         ylim([0,1000]);
            %         title('slip');
        end
    end
end
count=0;
for person=1:numper
    person
    for object=0:2
        for orientation=0:2
              count=count+1;
  subgrip=loadsubsliporgrip(w,person,object,orientation,'grip',data);
            gripfeature=zeros(size(subgrip,2),K);
            for i=1:size(subgrip,2)
                dist=vecnorm(C.'-subgrip(i));
                [dummy,ind]=min(dist);
                
                gripfeature(i,ind)=1;
            end
            %         subplot(6,5,person+5*object+15);
            %             bar(sum(gripfeature))
            gripbar(count,:)=sum(gripfeature);
            %             grid on;
            %             ylim([0,1000]);
            %             title('grip');
        end
    end
end
count=0;
for person=1:numper
    person
    for object=0:2        
        for orientation=0:2
    count=count+1;
subgrip=loadsubsliporgrip(w,person,object,orientation,'push',data);
            gripfeature=zeros(size(subgrip,2),K);
            for i=1:size(subgrip,2)
                dist=vecnorm(C.'-subgrip(i));
                [dummy,ind]=min(dist);
                
                gripfeature(i,ind)=1;
            end
            %         subplot(6,5,person+5*object+15);
            %         bar(sum(gripfeature))
            pushbar(count,:)=sum(gripfeature);
            %         grid on;
            %         ylim([0,1000]);
            %         title('grip');
        end
    end
end
count=0;
for person=1:numper
    person
    for object=0:2
        for orientation=0:2
    count=count+1;
            subgrip=loadsubsliporgrip(w,person,object,orientation,'bump',data);            
            gripfeature=zeros(size(subgrip,2),K);
            for i=1:size(subgrip,2)
                dist=vecnorm(C.'-subgrip(i));
                [dummy,ind]=min(dist);
                
                gripfeature(i,ind)=1;
            end
            %         subplot(6,5,person+5*object+15);
            %         bar(sum(gripfeature))
            bumpbar(count,:)=sum(gripfeature);
            %         grid on;
            %         ylim([0,1000]);
            %         title('grip');
        end
    end
end


for i=1:(numper)*9
    Y(i,1)={'slip'};
end
for i=(numper)*9:(numper)*18
    Y(i,1)={'grip'};
end
for i=(numper)*18:(numper)*27
    Y(i,1)={'push'};
end
for i=(numper)*27:(numper)*36
    Y(i,1)={'bump'};
end

drawnow

Indices = crossvalind('Kfold', size(Y,1), 4);%Indices = crossvalind('Kfold', N, K)
Indices=Indices==1;
data_hole =[slipbar;gripbar;pushbar;bumpbar];
Xtrain=zeros(1,K);Ytrain=zeros(1,K);Xtest=zeros(1,K);Ytest=zeros(1,K);
for con=1:size(Y,1)
if(Indices(con)==0)
    Xtrain=[Xtrain;data_hole(con,:)];
Ytrain=[Ytrain;Y(con,:)];
else
    Xtest=[Xtest;data_hole(con,:)];
Ytest=[Ytest;Y(con,:)];
end
end

Xtrain(1,:)=[];Ytrain(1,:)=[];Xtest(1,:)=[];Ytest(1,:)=[];

SVMModel = fitcecoc(Xtrain,Ytrain)

CVSVMModel = crossval(SVMModel,'KFold',2)
classLoss = kfoldLoss(CVSVMModel)

%
% g1 = [3 2 2 3 1 1]';	% Known groups
% g2 = [4 2 3 NaN 1 1]';	% Predicted groups
% C = confusionmat(g1,g2)


label = predict(SVMModel,Xtest);
C = confusionmat(Ytest,label)
