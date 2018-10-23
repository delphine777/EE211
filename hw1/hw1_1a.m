pgm_name = 'Test_image.pbm';
data = imread(pgm_name);
data = im2double(data);
figure(1)
imshow(data);
[m n] = size(data);
sobel_x = [-1 0 1;-2 0 2;-1 0 1];
sobel_y = [-1 -2 -1;0 0 0;1 2 1];
data_1 = [data(:,n:-1:1) data(:,:) data(:,n:-1:1)];
newdata = [data_1(m:-1:1,:);data_1(:,:);data_1(m:-1:1,:)];
imshow(newdata);
title('The image obtained after flipping original image')
%sobel_x
data_sobel_x = [];
for i = 1:m
    for j = 1:n
             data_sobel_x(i,j) = (-1)*newdata(m+i-1,n+j-1)+1*newdata(m+i-1,n+j+1)+(-2)*newdata(m+i,n+j-1)+2*newdata(m+i,n+j+1)+(-1)*newdata(m+i+1,n+j-1)+1*newdata(m+i+1,n+j+1);
    end
end
figure(2)
imshow(data_sobel_x,[]);
title('The image obtained after x-sobel filter convolution')
%sobel_y
data_sobel_y = [];
for i = 1:m
    for j = 1:n
             data_sobel_y(i,j) = (-1)*newdata(m+i-1,n+j-1)+(-2)*newdata(m+i-1,n+j)+(-1)*newdata(m+i-1,n+j+1)+1*newdata(m+i+1,n+j-1)+2*newdata(m+i+1,n+j)+1*newdata(m+i+1,n+j+1);
    end
end
figure(3)
imshow(data_sobel_y,[]);
title('The image obtained after y-sobel filter convolution')
figure(4)
imshow(abs(data_sobel_x)+abs(data_sobel_y),[]);
title('The image obtained after sobel filter (add both x and y) convolution')