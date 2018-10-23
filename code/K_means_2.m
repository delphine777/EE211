clc;
clear;
close all;
img_raw = imread('/Users/delphine/Documents/211A/project/picture/2014_09_18/2014_09_18 04.00PM/rgb.png');
[a,b] = size(img_raw);
img_raw2 = img_raw(30:a-30,:,:);
figure()
imshow(img_raw2),title('original image');

SE = strel('diamond',55);
img_d = imdilate(img_raw2,SE);
% figure
% imshow(img_d),title('image after dilation');

SE1 = strel('disk',55)'
img = imerode(img_d,SE1);
% figure
% imshow(img),title('image after erosion');

%2
cform = makecform('srgb2lab');
lab_img = applycform(img,cform);

%3
ab = double(lab_img(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx_0, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);
[cluster_center_2,index] = sortrows(cluster_center);

[a,b] = size(cluster_idx_0);
cGray_idx = zeros(a,b);
for i = 1:a
    if cluster_idx_0(i,1) == 1
       cGray_idx(i,1) = index(1);
    end
    if cluster_idx_0(i,1) == 2
       cGray_idx(i,1) = index(2);
    end
    if cluster_idx_0(i,1) == 3
       cGray_idx(i,1) = index(3);
    end
end

%4
pixel_labels = reshape(cGray_idx,nrows,ncols);
figure
imshow(pixel_labels,[]), title('image labeled by cluster index');

%5
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = img;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
% figure
% imshow(segmented_images{1}), title('objects in cluster 1');
% figure
% imshow(segmented_images{2}), title('objects in cluster 2');
% figure
% imshow(segmented_images{3}), title('objects in cluster 3');

bg1 = rgb2gray(segmented_images{1});
bg1 = im2double(bg1);
%bg2 = rgb2gray(segmented_images{2});
% bg2 = im2double(bg2);
% bg3 = rgb2gray(segmented_images{3});
% bg3 = im2double(bg3);
% bg1 = im2bw(bg1,0.05);
% bg2 = im2bw(bg2,0.05);
% bg3 = im2bw(bg3,0.05);
figure
imshow(bg1)
% %figure
% imshow(bg2)
% figure
% imshow(bg3)

img = imread('/Users/delphine/Documents/211A/project/picture/2014_09_18/2014_09_18 04.00PM/uv_g.png');
[a,b] = size(img);
img = img(30:a-30,:,:);
[a,b] = size(img);
row = find(bg1 == 0);
tissue = img(row);

figure
imagesc(img); colormap(jet); % caxis([.6 1]); %colorbar; %normal .6-1
%k-means classification
C_Segments=3;  

% GraySeg= reshape(img_gray(:, :), m*n, 1);  
[cGray, cGrey_center] = kmeans(double(tissue), C_Segments);  
[cGrey_center2, index] = sortrows(cGrey_center);

[a,b] = size(cGray);
cGray_idx = zeros(a,b);
for i = 1:a
    if cGray(i,1) == 1
       cGray_idx(i,1) = index(1);
    end
    if cGray(i,1) == 2
       cGray_idx(i,1) = index(2);
    end
    if cGray(i,1) == 3
       cGray_idx(i,1) = index(3);
    end
end


index1 = find(cGray_idx == 1);
index2 = find(cGray_idx == 2);
index3 = find(cGray_idx == 3);

ind_c1 = row(index1);
ind_c2 = row(index2);
ind_c3 = row(index3);
            
bg1(ind_c1) = 1;
bg1(ind_c2) = 2;
bg1(ind_c3) = 3;
% figure(4)
% imshow(bg1,[]);
figure
imagesc(bg1),title('para and non-para classification with only one wavelength');
colormap(jet);
