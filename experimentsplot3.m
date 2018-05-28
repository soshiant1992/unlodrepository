close all;
object=["sphere","cube","cylinder"];
direction=["upward","downward","sideways"];
action=["bump","slip","push","grip"];
for person=50:54
participant_number=int2str(person);
filename=['data/'];

%% getting the files
data={};

count=0;
for i3=1:3
for i1=1:3
    for i2=1:4
        count= count+1;
        nomad=[convertStringsToChars(action(i2)) '_'...
            convertStringsToChars(direction(i3)) '_'...
            convertStringsToChars(object(i1)) ];
        names(count)=convertCharsToStrings(nomad);
        nomad=[filename nomad '_participant_no_' participant_number];
        data(count)={importdata(nomad)};
        
    end
end
end
%% plotting stuff
% figure(1);
    figure('units','normalized','outerposition',[0 0 1 1])

for i6=25:36
   % subplot(3,4,i6)
   
%     h=figure(i6);
%     set(h, 'WindowStyle', 'Docked');
 count=0;
a=cell2mat(data(i6));
dd=zeros(size(a,1)-3,1);
clear ee;
for i=1:504
% plot(a1,diff(a(i,:)))
if(rem(i,84)==0)
end
b=a(3:size(a,1),i);
Fs = 1000;
fc = 150;
Wn = (2/Fs)*fc;
f = fir1(20,Wn,'low',kaiser(21,3));

% b = filtfilt(f,1,b);
cc=b;
 b=diff(b);
 b=b.^2;
 dd=dd+b;
% b = filter(f,1,b);

if(mean(abs(nonzeros(b)))>10 )
    count=count+1;
    ee(:,count)=cc;

   % if(rand(1)>.7 && i6==7)
   % c137=b;
   % end
padnumber=floor(i/86);
arraynum=rem(i,86);
col=rem(arraynum,6);
row=floor(arraynum/14);
end

end

%     subplot(4,1,3)
% dd=diff(dd);
%     plot(dd);
firstponit=firstthreshold(dd,500000);
thresh=500000;
while(firstponit<90 && thresh>0)
    thresh=thresh-50000;
    firstponit=firstthreshold(dd,100000)
end


i6

begin=-2;
endd=30;
if(((firstponit+endd)>size(dd,1))||((firstponit+begin)<1))
    for iii=1:size(ee,2)
        subplot(3,4,i6-24)
title(names(i6));

plot(ee(:,iii));
hold on
    end 
else
    for iii=1:size(ee,2)
        subplot(3,4,i6-24)
title(names(i6));

plot(ee(firstponit+begin:firstponit+endd,iii));
hold on
    end 
end


end
    drawnow
print(int2str(person),'-dsvg')
end

