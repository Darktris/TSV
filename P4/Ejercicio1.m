clear all
close all
clc

ima = imread('I1.jpg');

factor = 2;
nlevels = 5;
filter_type = 0;

P = doGaussianPyramid(ima,factor,nlevels,filter_type);

showPyramid(P, 0);


figure
factor = 2;
nlevels = 5;
filter_type = 1;

P = doGaussianPyramid(ima,factor,nlevels,filter_type);

showPyramid(P, 0);

figure
factor = 2;
nlevels = 5;
filter_type = 2;

P = doGaussianPyramid(ima,factor,nlevels,filter_type);

showPyramid(P, 0);

figure
factor = 2;
nlevels = 5;
filter_type = 3;

P = doGaussianPyramid(ima,factor,nlevels,filter_type);

showPyramid(P, 0);

