clear,clc
%% 加载图像
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
%% 设置训练参数
label = group(1:80); % 训练集标签
X = [ones(length(label),1),[data(:,1:80)]']; % 训练集输入数据
lambda = 0.004; % 权重衰减参数Weight decay parameter
alpha = 0.1; % 学习速率
MAX_ITR=1000; % 最大迭代次数
%% 梯度下降寻优
[m,p] = size(X);
numClasses = length(unique(label)); % 求取标签类别数
cost=zeros(MAX_ITR,1); % 用于追踪代价函数的值
theta = 0.005*randn(p,numClasses); % 若没有输入可选参数，则随机初始化系数
for k=1:MAX_ITR
    [cost(k),grad] = softmax_cost_grad(X,label,lambda,theta); % 计算代价函数值和梯度
    theta=theta-alpha*grad; % 更新系数
end
%% 回判预测
[~,~,Probit] = softmax_cost_grad(X,label,lambda,theta);
[~,label_pre] = max(Probit,[],2);
index = find(label==label_pre); % 找出预测正确的样本的位置
rate = length(index)/m % 计算预测精度
%% 绘制代价函数图
figure('Name','损失函数值变化图');
plot(0:MAX_ITR-1,cost)
xlabel('迭代次数'); ylabel('损失函数值')
title('损失函数值变化图');% 绘制代价函数值变化图
%%