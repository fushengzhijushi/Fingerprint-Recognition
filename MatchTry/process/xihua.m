
v=~u;
se=strel('square',3);
fo=imopen(v,se);
v=imclose(fo,se); %��ͼ����п������ͱղ���
w=bwmorph(v,'thin',Inf);%��ͼ�����ϸ��

%figure,imshow(w)
%title('ϸ��ͼ')


