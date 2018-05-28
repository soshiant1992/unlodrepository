object=["sphere","cube","cylinder"];
direction=["upward","downward","sideways"];
action=["bump","slip","push","grip"];
for person=8:17
participant_number=int2str(person)
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
figure(1);
clf
for i6=1:12
    subplot(3,4,i6)
    a=cell2mat(data(i6));
    title(names(i6));
    for i=1:504
        % plot(a1,diff(a(i,:)))
        if(rem(i,84)==0)
            count;
            count=0;
        end
        b=a(3:size(a,1),i);
        Fs = 1000;
        fc = 50;
        Wn = (2/Fs)*fc;
        f = fir1(20,Wn,'low',kaiser(21,3));
        
        b = filtfilt(f,1,b);
        % b=diff(b);
        % b = filter(f,1,b);
        
        if(mean(nonzeros(b))>10)
            plot(b)
            count=count+1;
            if(rand(1)>.7 && i6==7)
                c137=b;
            end
            padnumber=floor(i/86);
            arraynum=rem(i,86);
            col=rem(arraynum,6);
            row=floor(arraynum/14);
        end
        hold on;
        
    end
    hold off;
end
drawnow

%% loop for time
warning off;
if(1)
    a=cell2mat(data(8));
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

end

