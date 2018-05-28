function index1 = firstthreshold(arr1,threshold)
index1=size(arr1,1)-15;

for i=5:size(arr1)-15
    
if(arr1(i)>threshold)
index1=i;
break
end
    
end

% return index1;
