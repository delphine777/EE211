function kmeans_result = K_means_3(path,tis)
img = imread(path);
[a,~] = size(img);
img = img(30:a-30,:,:);
%[a,b] = size(img);
row = find(tis == 0);
tissue = img(row);

%figure
%imagesc(img); colormap(jet); % caxis([.6 1]); %colorbar; %normal .6-1
%k-means classification
C_Segments=3;  

% GraySeg= reshape(img_gray(:, :), m*n, 1);  
[cGray, cGrey_center] = kmeans(double(tissue), C_Segments);  
[~, index] = sortrows(cGrey_center);

[a,b] = size(cGray);
cGray_idx = zeros(a,b);
for i = 1:a
    if cGray(i,1) == 1
       cGray_idx(i,1) = find( index == 1 );
    end
    if cGray(i,1) == 2
       cGray_idx(i,1) = find( index == 2 );
    end
    if cGray(i,1) == 3
       cGray_idx(i,1) = find( index == 3 );
    end
end


index1 = cGray_idx == 1;
index2 = cGray_idx == 2;
index3 = cGray_idx == 3;

ind_c1 = row(index1);
ind_c2 = row(index2);
ind_c3 = row(index3);
            
tis(ind_c1) = 1;
tis(ind_c2) = 2;
tis(ind_c3) = 3;
% figure(4)
% imshow(bg1,[]);
figure
imagesc(tis); colormap(jet);
kmeans_result = tis;
end
