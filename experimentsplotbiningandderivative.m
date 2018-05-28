object=["sphere","cube","cylinder"];
direction=["upward","downward","sideways"];
action=["bump","slip","push","grip"];
personmin=8;
personmax=13;
oddnumber=1;
        figure('units','normalized','outerposition',[0 0 1 1])
            cube=256;%bin size

for person=personmin:personmax
    participant_number=int2str(person);
    filename=['data/'];
    
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
     %     h=figure(i6);
        %     set(h, 'WindowStyle', 'Docked');
    for i6=[10,12]
        
        % subplot(3,4,i6)
        
       
        count=0;
        a=cell2mat(data(i6));
        dd=zeros(size(a,1)-3,1);
        clear ee;
        for i=1:504
            % plot(a1,diff(a(i,:)))
            
            b=a(3:size(a,1),i);
            bufferino=b*0;
            for x=0:cube:4000
                bufferino=bufferino+((b>=x).*(b<(x+cube)))*x;
            end
            b=bufferino;
            % b = filtfilt(f,1,b);
            cc=b;
            b=diff(b);
            b=b.^2;
            dd=dd+b;
            % b = filter(f,1,b);
            
            if(mean(abs(nonzeros(b)))>10 )
                count=count+1;
                ee(:,count)=cc;
                
                padnumber=floor(i/86);
                arraynum=rem(i,86);
                col=rem(arraynum,6);
                row=floor(arraynum/14);
            end
            
        end
        
        
        firstponit=firstthreshold(dd,500000);
        thresh=500000;
        while(firstponit>90)
            thresh=thresh-50000;
            firstponit=firstthreshold(dd,100000)
        end
        
        
        begin=-2;
        endd=30;
        % ee=diff(ee);
        %  ee = (ee - min(diff(ee))) / ( max(diff(ee)) - min(diff(ee)) );
        % ee=(ee-.5)*2;
        
        % maxee=max(max(diff(ee(firstponit+begin:firstponit+endd,:),1,2)));
        % minee=min(min(diff(ee(firstponit+begin:firstponit+endd,:),1,2)));
        clear buffer2;
        for iii=1:size(ee,2)
            buffer2(:,iii)=diff(ee(firstponit+begin:firstponit+endd,iii));
            
        end
        maxee=max(max((buffer2)));
        minee=min(min((buffer2)));
        buffer2 = (buffer2 ) / (max( maxee ,- minee)) ;
        %         buffer2=(buffer2-.5)*2;
        
        for iii=1:size(ee,2)
            
            subplot(2,6,(person-personmin+1)+rem(oddnumber,2)*6)
            title(names(i6));
            ylim([-1 1])
            
            plot(buffer2(:,iii));
            hold on
        end
        hold off;
        
        oddnumber=oddnumber+1;
    end
    drawnow
end
print(['bybining',int2str(cube)],'-dsvg')

