% 分割
M =3;      %3*3
H = m/M;  L= n/M;

aveg1=zeros(H,L);
var1=zeros(H,L);
% 计算每一块的平均值
for x=1:H;
   for y=1:L;
       aveg=0;var=0;
        for i=1:M;
            for j=1:M;
                aveg=I(i+(x-1)*M,j+(y-1)*M)+aveg;

            end
        end
         aveg1(x,y)=aveg/(M*M);
% 计算每一块的方差值
        for i=1:M;
            for j=1:M;
                var=(I(i+(x-1)*M,j+(y-1)*M)-aveg1(x,y)).^2+var;
            end
        end
       var1(x,y)=var/(M*M);
   end
end
Gmean=0;Vmean=0;
for x=1:H
    for y=1:L
        Gmean=Gmean+aveg1(x,y);
        Vmean=Vmean+var1(x,y);  
    end
end
Gmean1=Gmean/(H*L);%所有块的平均值
Vmean1=Vmean/(H*L);%所有块的方差
 
gtemp=0;gtotle=0;vtotle=0;vtemp=0;
for x=1:H
    for y=1:L
       if Gmean1>aveg1(x,y)
           gtemp=gtemp+1;
           gtotle=gtotle+aveg1(x,y);
       end
       if Vmean1<var1(x,y)
           vtemp=vtemp+1;
           vtotle=vtotle+var1(x,y);
       end 
    end
end
G1=gtotle/gtemp;V1=vtotle/vtemp;  

gtemp1=0;gtotle1=0;vtotle1=0;vtemp1=0;
for x=1:H
    for y=1:L
       if G1<aveg1(x,y)
           gtemp1=gtemp1-1;
           gtotle1=gtotle1+aveg1(x,y);
       end
       if 0<var1(x,y)<V1
           vtemp1=vtemp1+1;
           vtotle1=vtotle1+var1(x,y);
       end 
    end
end
G2=gtotle1/gtemp1;V2=vtotle1/vtemp1; 
 
e=zeros(H,L);
for x=1:H
   for y=1:L
       if aveg1(x,y)>G2 && var1(x,y)<V2
           e(x,y)=1;
       end
       if aveg1(x,y)< G1-100 && var1(x,y)< V2
           e(x,y)=1;
       end
   end
end
 
for x=2:H-1
    for y=2:L-1
        if e(x,y)==1
            if e(x-1,y) + e(x-1,y+1) +e(x,y+1) + e(x+1,y+1) + e(x+1,y) + e(x+1,y-1) + e(x,y-1) + e(x-1,y-1) <=4
                e(x,y)=0;
            end
        end
    end
end  
Icc = ones(m,n);
for x=1:H
   for y=1:L
       if  e(x,y)==1
          for i=1:M
            for j=1:M
                I(i+(x-1)*M,j+(y-1)*M)=G1;
                Icc(i+(x-1)*M,j+(y-1)*M)=0;
            end
          end 
       end
   end
end
figure, imshow(uint8(I));title('分割');