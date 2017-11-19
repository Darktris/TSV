clear all
close all
clc

ima = imread('ojo.jpg');
ima = rgb2gray(ima);
ima = ima(40:end-40, 70:end-70);

sigma = 0.64;
nscales = 200;
w = 5;

SS=doSpaceScale_decomp(ima,nscales,sigma,w);

% showScaleSpace(SS, 0);

DoG = doDoG(ima,nscales,sigma,w);

% figure;
% showScaleSpace(DoG, 1);

for j=2:numel(SS),
    clf
    subplot(221),imshow(uint8(SS{j-1}))
    subplot(222),imshow(uint8(SS{j}))
    subplot(223),mesh(SS{j-1})
    subplot(224),mesh(DoG{j-1})
    title(sprintf('scala: %d',j))
    pause(0.1);
end