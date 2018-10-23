clear; close all; clc;
uv = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/uv_g.png');
figure(1)
imagesc(uv);
colormap(jet);
im676 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/676_g.png');
im632 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/632_g.png');
im605 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/605_g.png');
im594 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/594_g.png');
im565 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/565_g.png');
im520 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/520_g.png');
im494 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/494_g.png');
im465 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/465_g.png');
im434 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/434_g.png');
im407 = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/407_g.png');
figure(2)
imagesc(im676);
colormap(jet);
figure(3)
imagesc(im632);
colormap(jet);
figure(4)
imagesc(im605);
colormap(jet);
figure(5)
imagesc(im594);
colormap(jet);
figure(6)
imagesc(im565);
colormap(jet);
figure(7)
imagesc(im520);
colormap(jet);
figure(8)
imagesc(im494);
colormap(jet);
figure(9)
imagesc(im465);
colormap(jet);
figure(10)
imagesc(im434);
colormap(jet);
figure(11)
imagesc(im407);
colormap(jet);
figure(12)
rgb = imread('/Users/delphine/Documents/211A/project/picture/2014_10_09/2014_10_09 04.43PM/rgb.png');
imshow(rgb);