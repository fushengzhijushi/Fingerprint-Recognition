u=Icc;
[m,n]=size(u); %È¥³ý¿Õ¶´ºÍÃ«´Ì
for x=2:m-1
for y=2:n-1
if u(x,y)==0
if u(x,y-1)+u(x-1,y)+u(x,y+1)+u(x+1,y)>=3
u(x,y)=1;
end
else u(x,y)=u(x,y);
end
end
end
figure,imshow(u)
%title('È¥³ýÃ«´Ì')
for a=2:m-1
for b=2:n-1
if u(a,b)==1
if abs(u(a,b+1)-u(a-1,b+1))+abs(u(a-1,b+1)-u(a-1,b))+abs(u(a-1,b)-u(a-1,b-1))+abs(u(a-1,b-1)-u(a,b-1))+abs(u(a,b-1)-u(a+1,b-1))+abs(u(a+1,b-1)-u(a+1,b))+abs(u(a+1,b)-u(a+1,b+1))+abs(u(a+1,b+1)-u(a,b+1))~=1%Ñ°ÕÒ¶Ëµã
if (u(a,b+1)+u(a-1,b+1)+u(a-1,b))*(u(a,b-1)+u(a+1,b-1)+u(a+1,b))+(u(a-1,b)+u(a-1,b-1)+u(a,b-1))*(u(a+1,b)+u(a+1,b+1)+u(a,b+1))==0 %È¥³ý¿Õ¶´ºÍÃ«´Ì
u(a,b)=0;
end
end
end
end
end
figure,imshow(u)
%title('È¥³ý¿Õ¶´')