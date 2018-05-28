% this program tries to extract features that are both temporal and spatial
clear
close all;
%% parameters
r=2;%initial perimiter around the point of contact
K=2;%for the k-means
Ylim=500;%plot hight
SW=2;SW=SW-1;%spatial window
TW=4;TW=TW-1;%temporal window
%% slip portion
data=load('person8-17whole2');
img=zeros(2*r+1);grip(1,:)=zeros(1,r^2*(TW+1));slip(1,:)=zeros(1,r^2*(TW+1));
for person=1:10
    for finger=1:3
        for i=1:size(img,1)-SW
            for i2=1:size(img,1)-SW
                for i37=1:33
                    img=cell2mat(data.data2(person,10,i37,finger));
                    c=round(centerOfMass(img));
                    img=padarray(img.',r);
                    img=padarray(img.',r);
                    c=c+2;
                    img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
                    
                    buf=img(i:i+SW,i2:i2+SW);
                    gripbuf(i37,:)=buf(:);
                end
                for i55=1:size(gripbuf,1)-TW
                    buf=gripbuf(i55:i55+TW,:);
                    slip=[slip;buf(:).'];
                end
            end
        end
    end
    % ylim([0,.5])
    % xlim([0,28])
end

%% grip portion
for person=1:10
    for finger=1:3
        for i=1:size(img,1)-SW
            for i2=1:size(img,1)-SW
                for i37=1:33
                    img=cell2mat(data.data2(person,12,i37,finger));
                    c=round(centerOfMass(img));
                    img=padarray(img.',r);
                    img=padarray(img.',r);
                    c=c+2;
                    img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
                    
                    buf=img(i:i+SW,i2:i2+SW);
                    gripbuf(i37,:)=buf(:);
                    
                end
                for i55=1:size(gripbuf,1)-TW
                    buf=gripbuf(i55:i55+TW,:);
                    grip=[grip;buf(:).'];
                end
            end
        end
    end
end

%% bag of word
[idx,C]=kmeans([grip;slip],K);
%% ploting stuff
for person=1:10
    clear slipfeature;
    slipfeature(1,K)=0;
    for finger=1:3
        for i=1:size(img,1)-SW
            for i2=1:size(img,1)-SW
                for i37=1:33
                    img=cell2mat(data.data2(person,12,i37,finger));
                    c=round(centerOfMass(img));
                    img=padarray(img.',r);
                    img=padarray(img.',r);
                    c=c+2;
                    img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
                    buf=img(i:i+SW,i2:i2+SW);
                    gripbuf(i37,:)=buf(:);

                end
                for i55=1:size(gripbuf,1)-TW
                    buf=gripbuf(i55:i55+TW,:);
                    dist=vecnorm(C.'-buf(:));
                    [dummy,ind]=min(dist);
                    slipfeature(size(slipfeature,1)+1,K)=0;
                    slipfeature(size(slipfeature,1),ind)=1;
                end

            end
        end
    end
        subplot(4,5,person);
    bar(sum(slipfeature))
    slipbar(person,:)=sum(slipfeature);
    grid on;
    ylim([0,Ylim]);
    title('slip');
end
for person=1:10
    clear slipfeature;
    slipfeature(1,K)=0;
    for finger=1:3
        for i=1:size(img,1)-SW
            for i2=1:size(img,1)-SW
                for i37=1:33
                    img=cell2mat(data.data2(person,10,i37,finger));
                    c=round(centerOfMass(img));
                    img=padarray(img.',r);
                    img=padarray(img.',r);
                    c=c+2;
                    img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
                    buf=img(i:i+SW,i2:i2+SW);
                    gripbuf(i37,:)=buf(:);

                end
                for i55=1:size(gripbuf,1)-TW
                    buf=gripbuf(i55:i55+TW,:);
                    dist=vecnorm(C.'-buf(:));
                    [dummy,ind]=min(dist);
                    slipfeature(size(slipfeature,1)+1,K)=0;
                    slipfeature(size(slipfeature,1),ind)=1;
                end

            end
        end
    end
        subplot(4,5,person+10);
    bar(sum(slipfeature))
        gripbar(person,:)=sum(slipfeature);
    grid on;
    ylim([0,Ylim]);
    title('slip');
end

%     clear slipfeature;
%     slipfeature(1,K)=0;
% for i=1:size(slip,1)
%     dist=vecnorm(C.'-slip(i,:).');
%     [dummy,ind]=min(dist);
%     slipfeature(size(slipfeature,1)+1,K)=0;
%     slipfeature(size(slipfeature,1),ind)=1;
% end
% 
% figure(137);
% subplot(2,1,1);
% bar(sum(slipfeature))
% grid on;
% ylim([0,Ylim]);
% title('slip');
% 
%     clear slipfeature1;
%     slipfeature1(1,K)=0;
% for i=1:size(grip,1)
%     dist=vecnorm(C.'-grip(i,:).');
%     [dummy,ind]=min(dist);
%     slipfeature1(size(slipfeature1,1)+1,K)=0;
%     slipfeature1(size(slipfeature1,1),ind)=1;
% end
% 
% figure(137);
% subplot(2,1,2);
% bar(sum(slipfeature1))
% grid on;
% ylim([0,Ylim]);
% title('grip');
% 
% figure(138);
% % subplot(2,1,2);
% bar(sum(slipfeature1)-sum(slipfeature))
% grid on;
% % ylim([0,Ylim]);
% title('difference');

% figure(777);
% [mapped_data, mapping] = compute_mapping(datasample([grip;slip],1000,'Replace',false), 'tSNE');
% c137 = linspace(1,10,length(mapped_data));
% scatter(mapped_data(:,1),mapped_data(:,2),[],c137)
for i=1:10
Y(i,1)={'slip'};
end
for i=10:20
Y(i,1)={'grip'};
end
SVMModel = fitcsvm([slipbar;gripbar],Y);

CVSVMModel = crossval(SVMModel)
classLoss = kfoldLoss(CVSVMModel)

















