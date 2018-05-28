a=importdata("/home/mjmj/catkin_ws/devel/lib/sdh_grasp/anglesc137");
a1=importdata("/home/mjmj/catkin_ws/devel/lib/sdh_grasp/rosTime1");
b1=importdata("/home/mjmj/catkin_ws/devel/lib/sdh_grasp/rosTime2");
b=importdata("/home/mjmj/catkin_ws/devel/lib/sdh_grasp/sensorc137");
mono=diff(a(1,:));
subplot(2,1,1)
% a=[a,[0;0;0;0;0;0]];

for i=1:6
% plot(a1,diff(a(i,:)))
plot(a1,a(i,:))

hold on;
end
  c=importdata("/home/mjmj/catkin_ws/devel/lib/sdh_grasp/c137")
    title(c(1))  
hold off;


legend(['angle 3';'angle 4';'angle 5';'angle 6';'angle 1';'angle 2']);

% figure(2);
subplot(2,1,2)
for i=1:6
plot(b1,(b(i,:)))
hold on;
end
hold off;
%   c=importdata("/home/mjmj/catkin_ws/devel/lib/sdh_grasp/c137")
    title(c(1))  
    legend(['pad 2.1';'pad 2.2';'pad 3.1';'pad 3.2';'pad 1.1';'pad 1.2']);

    
    
    