close all;
clear;
% i=im2double(imread('seg1.jpeg'));
% i=im2double(imread('seg2.png'));
% i=im2double(imread('seg3.jpg'));
% i=im2double(imread('seg4.jpg'));
i=im2double(imread('seg5.jpg'));
% i=im2double(imread('seg6.jpg'));

imshow(i)
% edgee='sobel'
% edgee='log'
% edgee='Roberts'
% edgee='Prewitt'
% edgee='Prewitt'
edgee='Canny'
% edgee='approxcanny'
% edgee='zerocross'


% i=im2double(imread('seg1.jpeg'));
% figure
% imshow(rgb2gray(i));

figure
imshow(edge(rgb2gray(i),edgee));

r=i(:,:,1);
g=i(:,:,2);
b=i(:,:,3);


a=((r<g).*(g<b)).*(b+g);
mean(a(:))
a1=((r<b).*(b<g)).*(b+g)+max(a(:));
mean(a1(:))
b=((b<g)+(g<r)).*(r+g)+max(a1(:));
mean(b(:))
b1=((b<r)+(r<g)).*(r+g)+max(b(:));
mean(b1(:))
c=((g<r).*(r<b)).*(b+r)+max(b1(:));
mean(c(:))
c1=((g<b).*(b<r)).*(b+r)+max(c(:));
mean(c1(:))
mono=a+b+c+a1+b1+c1;
mono=mono/max(mono(:));
% figure
% imshow(mono);
figure
imshow(edge(mono,edgee));
% imageSegmenter(mono)
% figure
% imshow(edge(mono,edgee)-edge(rgb2gray(i),edgee));
% 
% figure
% imshow(-edge(mono,edgee)+edge(rgb2gray(i),edgee));



figure
h=rgb2hsv(i);


% imshow(h(:,:,3))
imshow(edge(h(:,:,1),edgee))










