clc
clear
addpath('./imagebase');
addpath('./process');
% image acquisition

%--------------加载指纹-------------------------------
OriFP=imread('101.tif');
%---------------灰度图像取反--------------------------
RevFP=255-OriFP;
%---------------进行二维适应性去噪过滤处理------------
FFP=wiener2(RevFP,[3 3]);
figure('name','FrontFilt');
imshow(uint8(FFP));
%---------------取图像的中心点------------------------

img=double(FFP);

[out,xc,yc]=centralizing(img,0);

figure('Name','指纹中心点');
imshow(FFP);
hold on;
plot(xc,yc,'rX');
hold off;

