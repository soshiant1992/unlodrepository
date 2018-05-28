%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17');

vidReader = VideoReader('viptraffic.avi');
opticFlow = opticalFlowLK('NoiseThreshold',0.009);

for person=1:5
data2=cell2mat(data.data2(person,10));
data3=cell2mat(data.data2(person,12));
subplot(2,5,person)
plot(max(data2.'))  
ylim([0,3400])

 subplot(2,5,person+5)
plot(max(data3.'))   

ylim([0,3400])
end



