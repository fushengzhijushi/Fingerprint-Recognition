% ¹éÒ»»¯

M=0;var=0;
for x=1:m
    for y=1:n
        M=M+I(x,y);
    end
end
M1=M/(m*n);
for x=1:m
    for y=1:n
        var=var+(I(x,y)-M1).^2;
    end
end
var1=var/(m*n);
for x=1:m
    for y=1:n
        if I(x,y)>=M1
            I(x,y)=150+sqrt(2000*(I(x,y)-M1)/var1);
        else
            I(x,y)=150-sqrt(2000*(M1-I(x,y))/var1);
        end
    end
end
figure, imshow(uint8(I)) ;