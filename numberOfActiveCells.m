%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17');

vidReader = VideoReader('viptraffic.avi');
opticFlow = opticalFlowLK('NoiseThreshold',0.009);

% for person=1:10
% data2=cell2mat(data.data2(person,10));
% data3=cell2mat(data.data2(person,12));
% slip(person)=size(data2,2);
% grip(person)=size(data3,2);
% end

% subplot(2,1,1)
% bar(slip)
% ylim([0,80])
% title('slip')
% subplot(2,1,2)
% bar(grip)
% ylim([0,80])
% title('grip')

for person=1:10
data2=cell2mat(data.data2(person,10));
data3=cell2mat(data.data2(person,12));
subplot(4,5,person)
plot(sum((data2>10).')) 
title('slip')
ylim([0,55])

 subplot(4,5,person+10)
plot(sum((data3>10).'))   
title('grip')
ylim([0,55])
end





