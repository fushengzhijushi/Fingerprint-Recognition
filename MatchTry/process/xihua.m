
v=~u;
se=strel('square',3);
fo=imopen(v,se);
v=imclose(fo,se); %对图像进行开操作和闭操作
w=bwmorph(v,'thin',Inf);%对图像进行细化

%figure,imshow(w)
%title('细化图')


