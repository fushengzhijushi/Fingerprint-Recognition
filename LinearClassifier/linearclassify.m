clear,clc
%% ����ͼ��
addpath('./data/DB1');
addpath('./siftDemoV4');
%match('103_4.tif','103_5.tif');
%[im1, des1, loc1] = sift('101_1.tif');
%showkeys(im1, loc1);

group=zeros(80,1);

data=zeros(80,1280);
for i=1:10
    for j=1:8
        if i~=10
            b=['./data/DB1/10',num2str(i),'_',num2str(j),'.tif'];%
        else
            b=['./data/DB1/110_',num2str(j),'.tif'];%
        end  
        [im1, des1, loc1] = sift(b);
        [idx,C]=kmeans(des1,10);
        data((i-1)*8+j,:)=C(:);
        group((i-1)*8+j)=i;
    end
end

clearvars -except data group;
%data=mapminmax(data,0,1);
data=data';
%% ����ѵ������
label = group(1:80); % ѵ������ǩ
X = [ones(length(label),1),[data(:,1:80)]']; % ѵ������������
lambda = 0.004; % Ȩ��˥������Weight decay parameter
alpha = 0.1; % ѧϰ����
MAX_ITR=1000; % ����������
%% �ݶ��½�Ѱ��
[m,p] = size(X);
numClasses = length(unique(label)); % ��ȡ��ǩ�����
cost=zeros(MAX_ITR,1); % ����׷�ٴ��ۺ�����ֵ
theta = 0.005*randn(p,numClasses); % ��û�������ѡ�������������ʼ��ϵ��
for k=1:MAX_ITR
    [cost(k),grad] = softmax_cost_grad(X,label,lambda,theta); % ������ۺ���ֵ���ݶ�
    theta=theta-alpha*grad; % ����ϵ��
end
%% ����Ԥ��
[~,~,Probit] = softmax_cost_grad(X,label,lambda,theta);
[~,label_pre] = max(Probit,[],2);
index = find(label==label_pre); % �ҳ�Ԥ����ȷ��������λ��
rate = length(index)/m % ����Ԥ�⾫��
%% ���ƴ��ۺ���ͼ
figure('Name','��ʧ����ֵ�仯ͼ');
plot(0:MAX_ITR-1,cost)
xlabel('��������'); ylabel('��ʧ����ֵ')
title('��ʧ����ֵ�仯ͼ');% ���ƴ��ۺ���ֵ�仯ͼ
%%