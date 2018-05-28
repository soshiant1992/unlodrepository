%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17');

for person=1:10
data2=cell2mat(data.data2(person,10));
data3=cell2mat(data.data2(person,12));
subplot(4,5,person)
plot(std(diff(data2).')) 
title('slip')
ylim([0,700])

 subplot(4,5,person+10)
plot(std(diff(data3).'))   
title('grip')
ylim([0,700])
end



