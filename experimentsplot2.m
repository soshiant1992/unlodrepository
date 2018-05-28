object=["sphere","cube","cylinder"];
direction=["upward","downward","sideways"];
action=["bump","slip","push","grip"];
participant_number='6';
filename=['data/'];
% a=importdata('/home/mjmj/Dropbox/data/grip_upward_cylinder_participant_no_4');

%% getting the files
data={};

count=0;
i3=1;
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

%% plotting stuff
% figure(1);
if(1)
for i6=1:12
   % subplot(3,4,i6)
   
    h=figure(i6);
    set(h, 'WindowStyle', 'Docked');
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
    subplot(4,1,1)
    hold on;
    plot(b);
    subplot(4,1,2)
    plot(cc);
    hold on;
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
title(names(i6));

    subplot(4,1,3)
% dd=diff(dd);
    plot(dd);

firstponit=firstthreshold(dd,500000)
i6


    subplot(4,1,4)

for iii=1:size(ee,2)
    
plot(ee(firstponit:firstponit+30,iii));
hold on
end    

end
    drawnow
end
%% loop for time
if(1)
a=cell2mat(data(11));
figure(2);
for i2=1:size(a,1)
    
    % loop for pads
    for i=2:2:6
        
        % loop for dots in a pad
        subplot(1,3,i/2);
%         axis([0 14 0 14])
        b=a(i2,(i-1)*84+1:i*84);
%         for i3=1:84
%             col=rem(i3,6);
%             row=floor(i3/6);
%         if(b(i3)~=0)    
%             scatter(row,col,b(i3)/100);
            matc137 = vec2mat(b,6) ;
%             row;
%             col;
%             hold all;
%         end
imshow(matc137/3400)
%         end
%         axis([0 14 0 14])
%         hold off
        
    end
    i2
    drawnow
end
end

%  for i=1:12  figure(i); clf; end

