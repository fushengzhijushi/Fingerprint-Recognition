function  [cost,thetagrad,P] = softmax_cost_grad(X,label,lambda,theta)
% 用于计算代价函数值及其梯度
% X：m*p输入矩阵，m为案例个数，p为加上常数项之后的属性个数
% label：m*1标签向量（数值型）
% lambda：权重衰减参数weight decay parameter
% theta：p*k系数矩阵，k为标签类别数
% cost：总代价函数值
% thetagrad：梯度矩阵
% P：m*k分类概率矩阵，P（i，j）表示第i个样本被判别为第j类的概率
m = size(X,1);
% 将每个标签扩展为一个k维横向量（k为标签类别数），若样本i属于第j类，则
% label_extend（i，j）= 1，否则label_extend（i，j）= 0。
label_extend = [full(sparse(label,1:length(label),1))]';
% 计算预测概率矩阵
P = zeros(m,size(label_extend,2));
for smp = 1:m
    P(smp,:) = exp(X(smp,:)*theta)/sum(exp(X(smp,:)*theta));
end
% 计算代价函数值
cost = -1/m*[label_extend(:)]'*log(P(:))+lambda/2*sum(theta(:).^2);
% 计算梯度
thetagrad = -1/m*X'*(label_extend-P)+lambda*theta;