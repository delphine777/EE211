png_name = 'text.png';
data = imread(png_name);
data=rgb2gray(data);
[x,y]=find(data ~= 255);
data = data(x(1):x(length(x)),y(1):y(length(y)));
%data = im2double(data);
[m,n] = size(data);
figure(1)
imshow(data);
title('Original');
%first: dilation
se = strel('disk',5);
data2 = imdilate(data,se);
figure(2)
imshow(data2);
title('Dilation');
%second: rank filter, filp the dilated image right and left, up and down to
%process boundaries
data_1 = [data2(:,n:-1:1) data2(:,:) data2(:,n:-1:1)];
newdata = [data_1(m:-1:1,:); data_1(:,:); data_1(m:-1:1,:)];
background = zeros(m,n);
for i=1:m
    for j=1:n
        data3 = newdata(m+i-7:m+i+7,n+j-7:n+j+7);
        rankdata = sort((data3),'descend');
        background(i,j) = rankdata(5);
    end
end
figure(3)
imshow(background,[]);
%third: background-image
datadouble = im2double(data);
background2 = background./255;
data4 = (background2 - datadouble);
figure(4)
imshow(data4,[]);
title('Background - original image');
%fourth: globle thresholding
data5 = zeros(size(data4));
for i=1:m
    for j=1:400
         if data4(i,j) >= 0.03
             data5(i,j) = 0;
         else data5(i,j)=1;
         end
    end
end
for i= 1:m
    for j=401:n
        if data4(i,j) >= 0.08
             data5(i,j) = 0;
         else data5(i,j)=1;
         end
    end
end
figure(5)
imshow(data5,[]);
