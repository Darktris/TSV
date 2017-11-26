clear all
close all
clc

addpath('imagenes')
addpath('autocorrectores')
addpath('material_básicos')

ima     = (rgb2gray(imread('Shannon.jpg')));
nlevels = 6;
nscales = 7;
sigma   = 0.64;
factor  = 2;
w       = 5;
N       = 100;
W       = 10;

SS=doLoGScaleSpacePyramid(ima,factor,nlevels,nscales,sigma,w);
showPyramidScale(SS, 1);

%% Imagen memoria, Protocolo DoG necesario
scale = 6;
I = SS{1, scale};
I_not_scale = I/((scale+1).*sigma);
I_not_scale2 = SS{1, 2}/((1+2).*sigma);
subplot(1,2,1)
imagesc(I_not_scale2);
title('Piramide SS LoG Level=1, Scale=2')
subplot(1,2,2)
imagesc(I_not_scale);
title('Piramide SS LoG Level=1, Scale=6')

%title(sprintf('R E=%g', E))
colormap gray
