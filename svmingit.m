%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17whole2');
X=[];
for person=1:10
stringed=[];
    for i=1:15
        local=[];
        for i2=1:3
    img=cell2mat(data.data2(person,10,i,i2));
    c=centerOfMass(img);
    try
       local= [local,img(c(1)-1:c(1)+1,c(2)-1:c(2)+1)];
    catch
        local=[local,zeros(3)];
    end
        end
        stringed=[stringed,local(:).'];
    end
X(person,:)=stringed;
end
for person=1:10
stringed=[];
    for i=1:15
        local=[];
        for i2=1:3
    img=cell2mat(data.data2(person,12,i,i2));
    c=centerOfMass(img);
    try
       local= [local,img(c(1)-1:c(1)+1,c(2)-1:c(2)+1)];
    catch
        local=[local,zeros(3)];
    end
        end
        stringed=[stringed,local(:).'];
    end
X(person+10,:)=stringed;
end
for i=1:10
Y(i,1)={'slip'};
end
for i=10:20
Y(i,1)={'grip'};
end

SVMModel = fitcsvm(X,Y,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');

CVSVMModel = crossval(SVMModel)
classLoss = kfoldLoss(CVSVMModel)












