
%% bag of words
clear;
w=10;w=w-1;%window size 
K=20;%number of classes

data=load('person8-22');
slip=cell2mat(data.data2(1,10,1));
for person=2:15
slip=[cell2mat(data.data2(person,10,1)),slip];
end
slip=slip(:);

for i=1:size(slip,1)-w
    subslip(:,i)=slip(i:i+w);
end


grip=cell2mat(data.data2(1,12,1));
for person=2:15
grip=[cell2mat(data.data2(person,12,1)),grip];
end
grip=grip(:);

for i=1:size(grip,1)-w
    subgrip(:,i)=grip(i:i+w);
end
both=[subgrip.';subslip.'];
[idx,C]=kmeans(both,K);
%% data representation
% [mapped_data, mapping] = compute_mapping(datasample(both,100,'Replace',false), 'tSNE');
% c137 = linspace(1,10,length(mapped_data));
% scatter(mapped_data(:,1),mapped_data(:,2),[],c137)
%% feature histogram makery
for person=1:15
slip=cell2mat(data.data2(person,10,1));
clear slipfeature;
slip=(slip(:));
for i=1:size(slip,1)-w
    dist=vecnorm(C.'-slip(i:i+w));
    [dummy,ind]=min(dist);
        slipfeature(i,K)=0;
    slipfeature(i,ind)=1;
end
subplot(6,5,person);
bar(sum(slipfeature))
        slipbar(person,:)=sum(slipfeature);
grid on;
ylim([0,1000]);
title('slip');
end

for person=1:15
grip=cell2mat(data.data2(person,12,1));
grip=(grip(:));
clear gripfeature;
for i=1:size(grip,1)-w
    dist=vecnorm(C.'-grip(i:i+w));
    [dummy,ind]=min(dist);
        gripfeature(i,K)=0;
    gripfeature(i,ind)=1;
end
subplot(6,5,person+15);
bar(sum(gripfeature))
        gripbar(person,:)=sum(gripfeature);
grid on;
ylim([0,1000]);
title('grip');
end
for i=1:15
Y(i,1)={'slip'};
end
for i=15:30
Y(i,1)={'grip'};
end
SVMModel = fitcsvm([slipbar;gripbar],Y);

CVSVMModel = crossval(SVMModel,'KFold',2)
classLoss = kfoldLoss(CVSVMModel)





