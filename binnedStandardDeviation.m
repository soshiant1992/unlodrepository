%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17');

for person=1:10

    for i=1:28
img=cell2mat(data.data2(person,10));
matbuf=    diff(img(i:i+5,:));
deavv(i)=std(matbuf(:));
    end
subplot(4,5,person);
plot(deavv)
ylim([0,1300])
xlim([0,28])
title('slip')
end

for person=1:10

    for i=1:28
img=cell2mat(data.data2(person,12));
matbuf=    diff(img(i:i+5,:));
deavv(i)=std(matbuf(:));
    end
subplot(4,5,person+10);
plot(deavv)
ylim([0,1300])
xlim([0,28])

title('grip')
end


















