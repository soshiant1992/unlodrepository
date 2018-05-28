%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17');


for person=1:10
data2=cell2mat(data.data2(person,10));
data3=cell2mat(data.data2(person,12));
subplot(4,5,person)
plot((sum(data2,2)/size(data2,2))./sum((data2>10),2))   
title('slip')
ylim([0,55])

 subplot(4,5,person+10)
plot((sum(data3,2)/size(data3,2))./sum((data3>10),2))   
title('grip')
ylim([0,55])
end





