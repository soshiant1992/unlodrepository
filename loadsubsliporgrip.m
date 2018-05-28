function [sub] = loadsubsliporgrip(w,person,object,orientation,type,data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% slip=reshape(slip,[],size(slip,3));
if(type=='slip')
    slip=cell2mat(data.data2(1,10,1));

    for i6= 1:36
        if (rem(i6,4)==2 && floor(i6/3)==object && floor(i6/12)==object) 
            for finger=1:3
                slip=[cell2mat(data.data2(person,i6,finger)),slip];
            end
        end
    end
    
    count=0;
    for i1=1:size(slip,1)-w
        for i2=1:size(slip,2)-w
            count=count+1;
            sub(:,count)=slip(i1:i1+w,i2);
            
        end
    end
elseif(type=='grip')
    grip=cell2mat(data.data2(1,12,1));
    for i6= 1:36
        if (rem(i6,4)==0 && floor(i6/3)==object && floor(i6/12)==object)
            for finger=1:3
                grip=[cell2mat(data.data2(person,i6,finger)),grip];
            end
        end
    end
        count=0;

    for i1=1:size(grip,1)-w
        for i2=1:size(grip,2)-w
            count=count+1;
            sub(:,count)=grip(i1:i1+w,i2);
        end
    end
    
elseif(type=='push')
    grip=cell2mat(data.data2(1,11,1));
    for i6= 1:36
        if (rem(i6,4)==3 && floor(i6/3)==object && floor(i6/12)==object)
            for finger=1:3
                grip=[cell2mat(data.data2(person,i6,finger)),grip];
            end
        end
    end
        count=0;

    for i1=1:size(grip,1)-w
        for i2=1:size(grip,2)-w
            count=count+1;
            sub(:,count)=grip(i1:i1+w,i2);
        end
    end
elseif(type=='bump')
    grip=cell2mat(data.data2(1,9,1));
    for i6= 1:36
        if (rem(i6,4)==1 && floor(i6/3)==object && floor(i6/12)==object)
            for finger=1:3
                grip=[cell2mat(data.data2(person,i6,finger)),grip];
            end
        end
    end
        count=0;

    for i1=1:size(grip,1)-w
        for i2=1:size(grip,2)-w
            count=count+1;
            sub(:,count)=grip(i1:i1+w,i2);
        end
    end
end
end

