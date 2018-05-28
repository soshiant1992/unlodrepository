%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17whole2');

for person=1:10
    
for finger=1:3
    c=centerOfMass(cell2mat(data.data2(person,10,1,finger)));
for i37=1:33
            img=cell2mat(data.data2(person,10,i37,finger));
pawn(i37,:)=centerOfMass(img)-c;
% pawn(i37,2)=pawn(i37,2)*i;
pawn2(i37)=atan2(pawn(i37,2),pawn(i37,1));
end 
subplot(4*3,5,person*3+finger-3);
plot(pawn2);
title(['slip',int2str(person)])
end
% ylim([0,.5])
% xlim([0,28])
end

for person=1:10

for finger=1:3
    c=centerOfMass(cell2mat(data.data2(person,12,1,finger)));
for i37=1:33
            img=cell2mat(data.data2(person,12,i37,finger));
            try
pawn(i37,:)=centerOfMass(img)-c;
% pawn(i37,2)=pawn(i37,2)*i;
pawn2(i37)=atan2(pawn(i37,2),pawn(i37,1));
            end
end 
subplot(4*3,5,person*3+finger+10*3-3);
plot(pawn2);
title(['grip',int2str(person)])
end
% ylim([0,.5])
% xlim([0,28])

end


