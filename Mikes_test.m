close all;
clear;
object=["sphere","cube","cylinder"];
direction=["upward","downward","sideways"];
action=["bump","slip","push","grip"];
for person=19:23
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
            try
                data(count)={importdata(nomad)};
            catch ME
                data(count)={zeros(130,504)*3500};
            end
        end
    end
    
    %% plotting stuff
    % figure(1);
    figure('units','normalized','outerposition',[0 0 1 1])
    for i6=1:12
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
            nn=diff(b);
            nn=nn.^2;
            dd=dd+nn;
            
            if(mean(abs(nonzeros(b)))>10 )
                count=count+1;
                ee(:,count)=b;
                
                
                padnumber=floor(i/86);
                arraynum=rem(i,86);
                col=rem(arraynum,6);
                row=floor(arraynum/14);
            end
            
        end
        try
            firstponit=firstthreshold(dd,500000);
            thresh=500000;
            while(firstponit>90 && thresh>0)
                thresh=thresh-50000;
                firstponit=firstthreshold(dd,100000)
            end
            
            
            for iii=1:size(ee,2)
                subplot(3,4,i6)
                title(names(i6));
                plot((ee(firstponit-3:firstponit+30,iii)));
                ylim([0 3400])
                hold on
            end
        end
    end
    drawnow
    %     print([int2str(person),'mike_diff'],'-dsvg')
end

