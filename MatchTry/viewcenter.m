clc
clear
addpath('./imagebase');
addpath('./process');
% image acquisition

%--------------����ָ��-------------------------------
OriFP=imread('101.tif');
%---------------�Ҷ�ͼ��ȡ��--------------------------
RevFP=255-OriFP;
%---------------���ж�ά��Ӧ��ȥ����˴���------------
FFP=wiener2(RevFP,[3 3]);
figure('name','FrontFilt');
imshow(uint8(FFP));
%---------------ȡͼ������ĵ�------------------------

img=double(FFP);

[out,xc,yc]=centralizing(img,0);

figure('Name','ָ�����ĵ�');
imshow(FFP);
hold on;
plot(xc,yc,'rX');
hold off;

