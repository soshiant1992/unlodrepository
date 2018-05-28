%% order of index: person, type of experiment, time
%% finally it will store a matrix in that cell
data=load('person8-17whole2');
data3=cell2mat(data.data2(1,1,1));

opticFlow = opticalFlowLK;
% opticFlow = opticalFlowFarneback;
% opticFlow = opticalFlowHS;
% opticFlow = opticalFlowLKDoG('NoiseThreshold',0.004);
warning off;
figure(1);
pause(6) ;
for person=4:4
for i=1:33
type=12;
img=[cell2mat(data.data2(person,type,i,1)),zeros(14,3)...
    ,cell2mat(data.data2(person,type,i,2)),zeros(14,3)...
    ,cell2mat(data.data2(person,type,i,3))];
% c=centerOfMass(img);
% r=10;
% img=padarray(img.',r);
% img=padarray(img.',r);
% 
% img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
    flow = estimateFlow(opticFlow,img);
    imshow(img, 'InitialMagnification', 8000) 
    hold on
%     plot(flow,'DecimationFactor',[1 1],'ScaleFactor',25)
    Vx=flow.Vx;Vy=flow.Vy;
    normandy=(Vx.^2+Vy.^2).^.5;
    normandy=normandy+   (normandy==0);
    Vx=Vx./normandy*.5;Vy=Vy./normandy*.5;
        quiver(Vx,Vy,'r','LineWidth',2,'AutoScale','off')
    hold off
    pause(.25) ;
    drawnow
    vx(i)=sum(flow.Vx(:));
        vy(i)=sum(flow.Vy(:));
end
% subplot(4,5,person)
% plot(vy);
% ylim([-1,1])
% title('slip');

end
% for person=1:10
% for i=1:33
% c=centerOfMass(cell2mat(data.data2(person,12,i)));
% 
% img=imresize(cell2mat(data.data2(person,12,i)),1);
% r=10;
% img=padarray(img.',r);
% img=padarray(img.',r);
% % 
% % img=img(c(1)-r:c(1)+r,c(2)-r:c(2)+r);
%     flow = estimateFlow(opticFlow,img);
%     flow.Magnitude;
% %     imshow(img, 'InitialMagnification', 8000) 
%     hold on
% %     plot(flow,'DecimationFactor',[1 1],'ScaleFactor',25)
%     hold off
% %     pause(.5) ;
% %     drawnow
%     vx(i)=sum(flow.Vx(:));
%         vy(i)=sum(flow.Vy(:));
% end
% subplot(4,5,person+10)
% plot(vy);
% title('grip');
% ylim([-1,1])
% 
% end
% % figure(2);
% % % plot(vx);
% % % hold on
% % plot(vy);
% % hold off;



















