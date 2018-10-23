function tissue = Extract_2(path_raw)
img_raw = imread(path_raw);
[a,~] = size(img_raw);
img_raw2 = img_raw(30:a-30,:,:);
%figure
%imshow(img_raw2),title('original image');

SE = strel('diamond',55);
img_d = imdilate(img_raw2,SE);
% figure
% imshow(img_d),title('image after dilation');

SE1 = strel('disk',55);
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
[~,index] = sortrows(cluster_center);

[a,b] = size(cluster_idx_0);
cGray_idx = zeros(a,b);
for i = 1:a
    if cluster_idx_0(i,1) == 1
       cGray_idx(i,1) = find( index == 1 );
    end
    if cluster_idx_0(i,1) == 2
       cGray_idx(i,1) = find( index == 2 );
    end
    if cluster_idx_0(i,1) == 3
       cGray_idx(i,1) = find( index == 3 );
    end
end

%4
pixel_labels = reshape(cGray_idx,nrows,ncols);
%figure
%imshow(pixel_labels,[]), title('image labeled by cluster index');

%5
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = img;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

bg1 = rgb2gray(segmented_images{1});
bg1 = im2double(bg1);
%figure
%imshow(bg1)
tissue = bg1;
end