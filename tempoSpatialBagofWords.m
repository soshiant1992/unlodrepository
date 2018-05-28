% this program tries to extract features that are both temporal and spatial
clear
close all;
%% parameters
D=1;%distance between two frame
r=2;%initial perimiter around the point of contact
K=5;%for the k-means
Ylim=50;%plot hight
%% slip portion
data=load('person8-17whole2');
img2=zeros(2*r+1);grip(1,:)=img2(:);slip(1,:)=img2(:);
for person=1:10
    for finger=1:3
        for i37=1:33
            img=cell2mat(data.data2(person,10,i37,finger));
            c=round(centerOfMass(img));
            img=padarray(img.',r);
            img=padarray(img.',r);
            c=c+2;
            img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
            img3=img2-img;img3=img3/(max([img3(:);.000001]));slip(size(slip,1)+1,:)=img3(:);
            img2=img;
            % subplot(4,5,person*3+finger-3);
            % imshow(img3,'InitialMagnification', 8000);
            % title(['slip',int2str(person)])
            % drawnow
            %     pause(.25) ;
        end
    end
    % ylim([0,.5])
    % xlim([0,28])
end

%% grip portion
for person=1:10
    for finger=1:3
        for i37=1:33
            img=cell2mat(data.data2(person,12,i37,finger));
            c=round(centerOfMass(img));
            img=padarray(img.',r);
            img=padarray(img.',r);
            c=c+2;
            img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
            img3=img2-img;img3=img3/(max([img3(:);.000001]));grip(size(grip,1)+1,:)=img3(:);
            img2=img;
        end
    end
end

%% bag of word
[idx,C]=kmeans([grip;slip],K);
%% ploting stuff
for person=1:10
    clear slipfeature;
    for finger=1:3
        for i37=1:33
            img=cell2mat(data.data2(person,10,i37,finger));
            c=round(centerOfMass(img));
            img=padarray(img.',r);
            img=padarray(img.',r);
            c=c+2;
            img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
            img3=img2-img;img3=img3/(max([img3(:);.000001]));img2=img;
            dist=vecnorm(C.'-img3(:));
            [dummy,ind]=min(dist);
            slipfeature(i37*finger,K)=0;
            slipfeature(i37*finger,ind)=1;
        end
    end
    subplot(4,5,person);
    bar(sum(slipfeature))
    grid on;
    ylim([0,Ylim]);
    title('slip');
end

for person=1:10
    clear slipfeature;
    for finger=1:3
        for i37=1:33
            img=cell2mat(data.data2(person,12,i37,finger));
            c=round(centerOfMass(img));
            img=padarray(img.',r);
            img=padarray(img.',r);
            c=c+2;
            img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
            img3=img2-img;img3=img3/(max([img3(:);.000001]));img2=img;
            dist=vecnorm(C.'-img3(:));
            [dummy,ind]=min(dist);
            slipfeature(i37*finger,K)=0;
            slipfeature(i37*finger,ind)=1;
        end
    end
    subplot(4,5,person+10);
    bar(sum(slipfeature))
    grid on;
    ylim([0,Ylim]);
    title('grip');
end

% figure(777);
% [mapped_data, mapping] = compute_mapping([grip;slip], 'tSNE');
% c137 = linspace(1,10,length(mapped_data));
% scatter(mapped_data(:,1),mapped_data(:,2),[],c137)



















