%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17whole');
data3=cell2mat(data.data2(1,1,1));

% vidReader = VideoReader('viptraffic.avi');
% opticFlow = opticalFlowLK('NoiseThreshold',0.009);
% opticFlow = opticalFlowFarneback;
opticFlow = opticalFlowHS;
% opticFlow = opticalFlowLKDoG('NoiseThreshold',0.004);
warning off;
for person=1:10
for i=1:33
c=centerOfMass(cell2mat(data.data2(person,10,i)));

img=imresize(cell2mat(data.data2(person,10,i)),1);
r=2;
img=padarray(img.',r);
img=padarray(img.',r);
% 
img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
    flow = estimateFlow(opticFlow,img);
    flow.Magnitude;
%     imshow(img, 'InitialMagnification', 8000) 
    hold on
%     plot(flow,'DecimationFactor',[1 1],'ScaleFactor',25)
    hold off
%     pause(.5) ;
%     drawnow
    vx(i)=sum(abs(flow.Vx(:)));
        vy(i)=sum(flow.Vy(:));
end
subplot(4,5,person)
plot(vx);
ylim([-1,1])
title('slip');

end
for person=1:10
for i=1:33
c=centerOfMass(cell2mat(data.data2(person,12,i)));

img=imresize(cell2mat(data.data2(person,12,i)),1);
r=2;
img=padarray(img.',r);
img=padarray(img.',r);
% 
img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
    flow = estimateFlow(opticFlow,img);
    flow.Magnitude;
%     imshow(img, 'InitialMagnification', 8000) 
    hold on
%     plot(flow,'DecimationFactor',[1 1],'ScaleFactor',25)
    hold off
%     pause(.5) ;
%     drawnow
    vx(i)=sum(abs(flow.Vx(:)));
        vy(i)=sum(flow.Vy(:));
end
subplot(4,5,person+10)
plot(vx);
title('grip');
ylim([-1,1])

end
% figure(2);
% % plot(vx);
% % hold on
% plot(vy);
% hold off;



















