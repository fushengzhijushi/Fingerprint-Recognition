function txy=point(thin)
count = 1;
txy(count, :) = [0,0,0];
siz=min(size(thin,1),size(thin,2));
for x=40:siz - 40
    for y=40:siz - 40
        if (thin(y, x) )
            CN = 0;
            for i = 1:8
                CN = CN + abs (P(thin, y, x, i) - P(thin, y, x, i + 1));
            end         
            if (CN == 2) 
                txy(count, :) = [x, y,1];
                count = count + 1;
            end
            if (CN == 6)
                txy(count, :) = [x, y,2];
                count = count + 1;
            end
        end
    end 
end 
for i=1:count - 1
    x(i) =txy(i, 1);
    y(i)= txy(i, 2);
end 
end
%imshow(double(thin));
%hold on;
%plot(x,y,'.');