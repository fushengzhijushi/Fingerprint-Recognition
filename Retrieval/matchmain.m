clear,clc
%% ����Ŀ��ͼ��
addpath('./imagebase');
Ides=imread('103_6.tif');
matchnum=zeros(10,1);
%% ƥ��
Files = dir(fullfile('imagebase\\','*.tif'));
LengthFiles = length(Files);
for i = 1:LengthFiles;
   I = imread(strcat('imagebase\\',Files(i).name));
   matchnum(i)=match1(Ides,I);
end
close all

%% ��ʾ
pic1=find(matchnum==max(matchnum));
b= imread(strcat('imagebase\\',Files(pic1).name));
subplot(1,2,1);
imshow(b);
title(strcat('ָ�Ƽ�����',Files(pic1).name));

s=imread('103_6.tif');
subplot(1,2,2);
imshow(s);
title('ԭָ��');
set(gcf,'position',[500,250,450,220])
%match1(strcat('imagebase\\',Files(pic1).name),'103_6.tif')
