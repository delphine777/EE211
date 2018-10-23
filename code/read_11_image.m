clear; close all; clc;
path = ('/Users/delphine/Documents/211A/project/picture');
addpath(path);
date = '2014_09_18';
folderNum = 5;%Folder number to check sorted by date

folderList = ListSubfolders(strcat(path,'/',date,'/',date,'*'));
folderPath = strcat(date,'/',folderList{end-(folderNum-1)},'/');
%fileList = dir(strcat(folderPath,'*.png'));
filt = {'uv' '407' '434' '465' '494' '520' '565'};
result = zeros(965,1024,7);

raw_img_path = strcat(path,'/',folderPath,'rgb.png');
tissue = Extract_2(raw_img_path);

for j = 1:length(filt)
    filtfile = strcat(path,'/',folderPath,filt{j},'_g.png');
    result(:,:,j) = K_means_3 ( filtfile, tissue );
end
img_total = clf(result);
figure()
imagesc(img_total),title('para,non-para, background and unsure area classification with all 11 filters'); 
mycolor = [0,0,0;0.9,0.3,0.2;0.7,0.7,0.7;1,1,0.1];
colormap(mycolor);
% figure()
% imagecs