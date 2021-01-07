clear,clc
%% 加载目标图像
addpath('./imagebase');
Ides=imread('103_6.tif');
matchnum=zeros(10,1);
%% 匹配
Files = dir(fullfile('imagebase\\','*.tif'));
LengthFiles = length(Files);
for i = 1:LengthFiles;
   I = imread(strcat('imagebase\\',Files(i).name));
   matchnum(i)=match1(Ides,I);
end
close all

%% 显示
pic1=find(matchnum==max(matchnum));
b= imread(strcat('imagebase\\',Files(pic1).name));
subplot(1,2,1);
imshow(b);
title(strcat('指纹检索：',Files(pic1).name));

s=imread('103_6.tif');
subplot(1,2,2);
imshow(s);
title('原指纹');
set(gcf,'position',[500,250,450,220])
%match1(strcat('imagebase\\',Files(pic1).name),'103_6.tif')
