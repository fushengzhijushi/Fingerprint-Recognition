function  [cost,thetagrad,P] = softmax_cost_grad(X,label,lambda,theta)
% ���ڼ�����ۺ���ֵ�����ݶ�
% X��m*p�������mΪ����������pΪ���ϳ�����֮������Ը���
% label��m*1��ǩ��������ֵ�ͣ�
% lambda��Ȩ��˥������weight decay parameter
% theta��p*kϵ������kΪ��ǩ�����
% cost���ܴ��ۺ���ֵ
% thetagrad���ݶȾ���
% P��m*k������ʾ���P��i��j����ʾ��i���������б�Ϊ��j��ĸ���
m = size(X,1);
% ��ÿ����ǩ��չΪһ��kά��������kΪ��ǩ���������������i���ڵ�j�࣬��
% label_extend��i��j��= 1������label_extend��i��j��= 0��
label_extend = [full(sparse(label,1:length(label),1))]';
% ����Ԥ����ʾ���
P = zeros(m,size(label_extend,2));
for smp = 1:m
    P(smp,:) = exp(X(smp,:)*theta)/sum(exp(X(smp,:)*theta));
end
% ������ۺ���ֵ
cost = -1/m*[label_extend(:)]'*log(P(:))+lambda/2*sum(theta(:).^2);
% �����ݶ�
thetagrad = -1/m*X'*(label_extend-P)+lambda*theta;