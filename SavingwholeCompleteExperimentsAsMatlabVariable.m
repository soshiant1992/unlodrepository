object=["sphere","cube","cylinder"];
direction=["upward","downward","sideways"];
action=["bump","slip","push","grip"];
data2={};
beginp=50;
endp=64;
for person=beginp:endp
    participant_number=int2str(person);
    filename=['data/'];
    
    %% getting the files
    data={};
    
    count=0;
    i3=1;
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
    
    for i6=1:36
        
        count=0;
        a=cell2mat(data(i6));
        dd=zeros(size(a,1)-3,1);
        clear ee;
        for i=1:504
            
            
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
        
        
        firstponit=firstthreshold(dd,500000);
        thresh=500000;
        
        while(firstponit<90 && thresh>0)
            thresh=thresh-50000;
            firstponit=firstthreshold(dd,100000);
        end
        
        i6;
        
        begin=-2;
        endd=15;
        
        %         data2(person-beginp+1,i6)={ee(firstponit+begin:firstponit+endd,:)};
        
        
        
        
        a66=cell2mat(data(i6));
            
            % loop for pads
            for i=2:2:6
                
                % loop for dots in a pad
                try
                b=a66(firstponit+begin:firstponit+endd,(i-1)*84+1:i*84);
                data2(person-beginp+1,i6,i/2)={b/3400} ;
                catch
                    display('one array smaller than usual')
                  size(a66)
                  i6=i6
                end
                %% order of index: person, type of experiment, time
                %% finally it will store a matrix in that cell
                
                
            end
        
        
    end
    person
end
save(['person',int2str(beginp),'-',int2str(endp),'completehalfsecond'],'data2')
