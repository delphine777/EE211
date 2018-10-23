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
newdata = [data_1(m:-1:1,:); data_1(:,:); data_1(m:-1:1,:)];
%sigma_s = [3 10 25];  %s=3, size=17*17, s=10, size=59*59, s=25, size=149*149
%sigma_r
sigma_r = [0.1 0.3 10];
%generate gaussian filter with sigma_s=3,size=17*17
gaussian_s1=[];
for i=1:17
   for j=1:17
       gaussian_s1(i,j) = 1/(2*pi*9)*exp(-((i-9)^2+(j-9)^2)/(2*9));
   end
end
gaussian_s1=(gaussian_s1)./gaussian_s1(9,9);
%generate gaussian filter with sigma_s=10,size=59*59%gaussian_s2=[]
for i=1:59
   for j=1:59
       gaussian_s2(i,j) = 1/(2*pi*100)*exp(-((i-30)^2+(j-30)^2)/200);
   end
end
gaussian_s2=(gaussian_s2)./gaussian_s2(30,30);
%generate gaussian filter with sigma_s=25,size=17*17
gaussian_s3=[];
for i=1:149
   for j=1:149
       gaussian_s3(i,j) = 1/(2*pi*625)*exp(-((i-75)^2+(j-75)^2)/(2*625));
   end
end
gaussian_s3=(gaussian_s3)./gaussian_s3(75,75);
%%gaussian sigma_r with filter s1,size=17*17
for a = 1:3
    data_1 = [];
    r = sigma_r(a);
    for i = 1:m
        for j = 1:n
            for p = 1:17
                for q = 1:17
                    gaussian_r1(p,q) = 1/(2*pi*r^2)*exp(-(newdata(m+i,n+j)-newdata(m+i+p-9,n+j+q-9))^2/(2*r^2));
                end
            end
            A = gaussian_s1.*gaussian_r1;
            gaussian_1 = A./max(max(A));
            B= gaussian_1.*newdata(m+i-8:m+i+8,n+j-8:n+j+8);
            data_1(i,j)=sum(B(:));
        end
    end
    %data_1 = data_1./max(max(data_1));
    figure
    imshow(data_1,[])
end
%%gaussian sigma_r with filter s2,size=59*59
for a = 1:3
    data_2 = [];
    r = sigma_r(a);
    for i = 1:m
        for j = 1:n
            for p = 1:59
                for q = 1:59
                    gaussian_r2(p,q) = 1/(2*pi*r^2)*exp(-(newdata(m+i,n+j)-newdata(m+i+p-30,n+j+q-30))^2/(2*r^2));
                end
            end
            A = gaussian_s2.*gaussian_r2;
            gaussian_2 = A./max(max(A));
            B= gaussian_2.*newdata(m+i-29:m+i+29,n+j-29:n+j+29);
            data_2(i,j)=sum(B(:));
        end
    end
    %data_2 = data_2./max(max(data_2));
    figure
    imshow(data_2,[])
end
%%gaussian sigma_r with filter s3,size=149*149
for a = 1:3
    data_3 = [];
    r = sigma_r(a);
    for i = 1:m
        for j = 1:n
            for p = 1:149
                for q = 1:149
                    gaussian_r3(p,q) = 1/(2*pi*r^2)*exp(-(newdata(m+i,n+j)-newdata(m+i+p-75,n+j+q-75))^2/(2*r^2));
                end
            end
            A = gaussian_s3.*gaussian_r3;
            gaussian_3 = A./max(max(A));
            B= gaussian_3.*newdata(m+i-74:m+i+74,n+j-74:n+j+74);
            data_3(i,j)=sum(B(:));
        end
    end
    %data_3 = data_3./max(max(data_3));
    figure
    imshow(data_3,[])
end