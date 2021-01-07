clc
clear
addpath('./imagebase');
addpath('./process');
%--------------����ָ��-------------------------------
OriFP=imread('101.tif');
%---------------�Ҷ�ͼ��ȡ��--------------------------
RevFP=255-OriFP;
%---------------���ж�ά��Ӧ��ȥ����˴���------------
FFP=wiener2(RevFP,[3 3]);
figure('name','FrontFilt');
imshow(uint8(FFP));
%---------------ȡͼ������ĵ�------------------------
[out1,XofCenter,YofCenter] = centralizing(FFP,0);
figure('name','FrontFilt');
imshow(uint8(FFP));
hold on;
plot(XofCenter,YofCenter,'or');
hold off;
%------------------�ֲ��Ͷ��ƶ˵�---------------
[txy,thinFP]=bifurfeature(FFP);
figure('name','ָ��ϸ������');
imshow(thinFP);
count=length(txy);
hold on;
for i=1:count
    if txy(i,3)==1
        plot(txy(i,1),txy(i,2),'or');
    else
        plot(txy(i,1),txy(i,2),'og');
    end
end
hold off;
%-----------------�����㵽������ĵ�ľ���---------------
distant=zeros(count,3);  
for i=1:count
    distant(i)=sqrt((txy(i,2)-YofCenter)^2+(txy(i,1)-XofCenter)^2);
end
%------------------����ģ�彨��----------------------------------------------
PointOfModel=zeros(count,3);
for i=1:count
    PointOfModel(i,1)=txy(i,3);%�����˵����Ϊ1 �ֲ��
    PointOfModel(i,2)=distant(i);%�����˵�������ĵ�ľ�������
    PointOfModel(i,3)=sum(sum(thinFP(txy(i,1)-4:txy(i,1)+4, txy(i,2)-4:txy(i,2)+4)));
end
%------------------------------------
close all
