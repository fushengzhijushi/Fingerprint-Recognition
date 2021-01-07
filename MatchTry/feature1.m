clc
clear
addpath('./imagebase');
addpath('./process');
%--------------加载指纹-------------------------------
OriFP=imread('101.tif');
%---------------灰度图像取反--------------------------
RevFP=255-OriFP;
%---------------进行二维适应性去噪过滤处理------------
FFP=wiener2(RevFP,[3 3]);
figure('name','FrontFilt');
imshow(uint8(FFP));
%---------------取图像的中心点------------------------
[out1,XofCenter,YofCenter] = centralizing(FFP,0);
figure('name','FrontFilt');
imshow(uint8(FFP));
hold on;
plot(XofCenter,YofCenter,'or');
hold off;
%------------------分叉点和短纹端点---------------
[txy,thinFP]=bifurfeature(FFP);
figure('name','指纹细节特征');
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
%-----------------特征点到相对中心点的距离---------------
distant=zeros(count,3);  
for i=1:count
    distant(i)=sqrt((txy(i,2)-YofCenter)^2+(txy(i,1)-XofCenter)^2);
end
%------------------特征模板建立----------------------------------------------
PointOfModel=zeros(count,3);
for i=1:count
    PointOfModel(i,1)=txy(i,3);%特征端点分类为1 分叉点
    PointOfModel(i,2)=distant(i);%特征端点相对中心点的距离向量
    PointOfModel(i,3)=sum(sum(thinFP(txy(i,1)-4:txy(i,1)+4, txy(i,2)-4:txy(i,2)+4)));
end
%------------------------------------
close all
