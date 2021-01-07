function Count=match(ThinFingerPrint,thinFP1,PointOfModel,PointOfMatch,txy,txy1)
figure('name','ModelFingerPrint');
imshow(ThinFingerPrint);
hold on;
Count=0;
PointOfModelCount=size(PointOfModel,1);
PointOfMatchCount=size(PointOfMatch,1);
flag=zeros(PointOfMatchCount,1);
for i=1:PointOfModelCount
    for j=1:PointOfMatchCount
        if ( PointOfModel(i,1)==PointOfMatch(j,1))&&(abs(PointOfModel(i,2)-PointOfMatch(j,2))<2)&&...
      (abs(PointOfModel(i,3)-PointOfMatch(j,3))<3)&&flag(j)==0
            Count=Count+1;
            flag(j)=1; 
            if PointOfModel(i,1)==1
                plot(txy(i,1),txy(i,2),'or');
            else
                plot(txy(i,1),txy(i,2),'og');
            end
            break;
        end
    end
end

figure('name','MatchFingerPrint');
imshow(thinFP1);
hold on;
for j=1:PointOfMatchCount
    if flag(j)==1
            if PointOfMatch(j,1)==1
                plot(txy1(j,1),txy1(j,2),'or');
            else
                plot(txy1(j,1),txy1(j,2),'og');
            end 
    end
end

if Count>20
    disp('PointOfMatch pass');
else
    disp('Not the same fingerprint');
end    
hold off;