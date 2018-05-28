
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
both=[subgrip.';subslip.'];
% both=both.*(both>.01);
both( ~any(both,2), : ) = [];  %rows
% data( :, ~any(data,1) ) = [];  %columns
[idx,C]=kmeans(both,K);
%% data representation
% [mapped_data, mapping] = compute_mapping(datasample(both,100,'Replace',false), 'tSNE');
% c137 = linspace(1,10,length(mapped_data));
% scatter(mapped_data(:,1),mapped_data(:,2),[],c137)
%% feature histogram makery
for person=1:numper
    for object=0:2
        person
        subslip=loadsubsliporgrip(w,person,object,'slip',data);
        slipfeature=zeros(size(subgrip,2),K);
        
        for i=1:size(subslip,2)
            dist=vecnorm(C.'-subslip(:,i));
            [dummy,ind]=min(dist);
            slipfeature(i,ind)=1;
        end
%         subplot(6,5,person+5*object);
        bar(sum(slipfeature))
        slipbar(person+numper*object,:)=sum(slipfeature);
        grid on;
        ylim([0,1000]);
        title('slip');
    end
end
for person=1:numper
    for object=0:2
        person
        gripfeature=zeros(size(subgrip,2),K);
        subgrip=loadsubsliporgrip(w,person,object,'grip',data);
        for i=1:size(subgrip,2)
            dist=vecnorm(C.'-subgrip(i));
            [dummy,ind]=min(dist);
            
            gripfeature(i,ind)=1;
        end
%         subplot(6,5,person+5*object+15);
        bar(sum(gripfeature))
        gripbar(person+numper*object,:)=sum(gripfeature);
        grid on;
        ylim([0,1000]);
        title('grip');
    end
end
for i=1:(numper)*3
    Y(i,1)={'slip'};
end
for i=(numper)*3:(numper)*6
    Y(i,1)={'grip'};
end

drawnow

SVMModel = fitcsvm([slipbar;gripbar],Y);

CVSVMModel = crossval(SVMModel,'KFold',2)
classLoss = kfoldLoss(CVSVMModel)




