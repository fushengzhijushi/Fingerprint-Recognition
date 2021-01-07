%二值化

temp=(1/9)*[1 1 1;1 1 1;1 1 1];%模板系数     均值滤波
 Im=double(I);
 [m,n]=size(I);
 In=zeros(m,n);
 Icc = ones(m,n);
for a=2:m-1;
    for b=2:n-1;
        In(a,b)=Im(a-1,b-1)*temp(1,1)+Im(a-1,b)*temp(1,2)+Im(a-1,b+1)*temp(1,3)+Im(a,b-1)*temp(2,1)+Im(a,b)*temp(2,2)+Im(a,b+1)*temp(2,3)+Im(a+1,b-1)*temp(3,1)+Im(a+1,b)*temp(3,2)+Im(a+1,b+1)*temp(3,3);
    end
end
 
I=In;
Im=zeros(m,n);
for x=5:m-5;
   for y=5:n-5;
 
    sum1=I(x,y-4)+I(x,y-2)+I(x,y+2)+I(x,y+4);
    sum2=I(x-2,y+4)+I(x-1,y+2)+I(x+1,y-2)+I(x+2,y-4);
    sum3=I(x-2,y+2)+I(x-4,y+4)+I(x+2,y-2)+I(x+4,y-4);
    sum4=I(x-2,y+1)+I(x-4,y+2)+I(x+2,y-1)+I(x+4,y-2);
    sum5=I(x-2,y)+I(x-4,y)+I(x+2,y)+I(x+4,y);
    sum6=I(x-4,y-2)+I(x-2,y-1)+I(x+2,y+1)+I(x+4,y+2);
    sum7=I(x-4,y-4)+I(x-2,y-2)+I(x+2,y+2)+I(x+4,y+4);
    sum8=I(x-2,y-4)+I(x-1,y-2)+I(x+1,y+2)+I(x+2,y+4);
    sumi=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8];
    summax=max(sumi);
    summin=min(sumi);
     summ=sum(sumi);
     b=summ/8;
     if (summax+summin+ 4*I(x,y))> (3*summ/8)            
            sumf = summin;
         else
            sumf = summax;
         end
 
         if   sumf > b
           Im(x,y)=128;
        else
            Im(x,y)=255;
         end
   end
end
 
for i=1:m
     for j =1:n
         Icc(i,j)=Icc(i,j)*Im(i,j);
     end
end
 for i=1:m
     for j =1:n
         if (Icc(i,j)==128)
             Icc(i,j)=0;
         else
             Icc(i,j)=1;
         end;
     end
 end

%figure,imshow(double(Icc));title('二值化');