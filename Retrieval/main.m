clear,clc
%% 加载图像
addpath('./data/DB1');
addpath('./imagebase');

matchnum=zeros(10,1);
index=0;
for i=1:10
    for j=1:8
        if i~=10
            b=['./data/DB1/10',num2str(i),'_',num2str(j),'.tif'];%
            c=['10',num2str(i),'_',num2str(j),'.tif'];%
        else
            b=['./data/DB1/110_',num2str(j),'.tif'];%
            c=['1',num2str(i),'_',num2str(j),'.tif'];%
        end  
        Ides=imread(b);
        Files = dir(fullfile('imagebase\\','*.tif'));
        LengthFiles = length(Files);
        for k = 1:LengthFiles;
            I = imread(strcat('imagebase\\',Files(k).name));
            matchnum(k)=match1(Ides,I);
        end
        pic1=find(matchnum==max(matchnum));
        if strncmp(Files(pic1(1)).name,c,3)
            index=index+1;
        end
        close all
    end
end
close all
(index-8)./72
%减去原本数据库里就有的那个