pgm_name = 'Test_image.pbm';
data = imread(pgm_name);
data = im2double(data);
figure(1)
imshow(data);
title('The original image')
[m n] = size(data);
%flip the image right and left
data_1 = [data(:,n:-1:1) data(:,:) data(:,n:-1:1)];
%flip the image up and down
newdata = [data_1(m:-1:1,:);data_1(:,:);data_1(m:-1:1,:)];
%generate gaussian filter with sigma=1,size=5*5
gaussian_1=[];
for i=1:5
    for j=1:5
        gaussian_1(i,j) = 1/(2*pi)*exp(-((i-3)^2+(j-3)^2)/2);
    end
end
%generate gaussian filter with sigma=5,size=29*29
gaussian_5=[];
for i=1:29
    for j=1:29
        gaussian_5(i,j) = 1/(50*pi)*exp(-((i-15)^2+(j-15)^2)/50);
    end
end

%generate gaussian filter with sigma=15,size=225*225
gaussian_15=[];
for i=1:225
    for j=1:225
        gaussian_15(i,j) = 1/(450*pi)*exp(-((i-113)^2+(j-113)^2)/450);
    end
end
%gaussian sigma=1
data_1=[];
for i = 1:m
    for j = 1:n
        conmatrix_1 = newdata(m+i-2:m+i+2,n+j-2:n+j+2).*gaussian_1;
        data_1(i,j) = sum(conmatrix_1(:));
    end
end
figure(2)
imshow(data_1,[]);
title('The image obtained after convolution with gaussian filter, sigma=1')
%gaussian sigma=5
data_5=[];
for i = 1:m
    for j = 1:n
        conmatrix_5 = newdata(m+i-14:m+i+14,n+j-14:n+j+14).*gaussian_5;
        data_5(i,j) = sum(conmatrix_5(:));
    end
end
figure(3)
imshow(data_5,[]);
title('The image obtained after convolution with gaussian filter, sigma=5')
%gaussian sigma=15
data_15=[];
for i = 1:m
    for j = 1:n
        conmatrix_15 = newdata(m+i-112:m+i+112,n+j-112:n+j+112).*gaussian_15;
        data_15(i,j) = sum(conmatrix_15(:));
    end
end
figure(4)
imshow(data_15,[]);
title('The image obtained after convolution with gaussian filter, sigma=15')
