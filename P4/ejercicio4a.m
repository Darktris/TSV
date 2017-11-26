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

se = strel('square', w);


PSSLoG=doLoGScaleSpacePyramid(ima,factor,nlevels,nscales,sigma,w);
[maxima_st,minima_st] = extractLocalMaximaAndMinima(PSSLoG,N,W,w,factor);

imshow(ima),
hold on, plot(minima_st.x,minima_st.y,'ob'),
hold on, plot(maxima_st.x,maxima_st.y,'*r')
legend('Local minima of image','Local maxima of image') 
