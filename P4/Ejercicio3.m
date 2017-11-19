clear all
close all
clc

ima = imread('I1.jpg');

sigma = 0.64;
nscales = 200;
w = 5;

SS=doSpaceScale_decomp(ima,nscales,sigma,w);
showScaleSpace(SS, 0);

DoG = doDoG(ima,nscales,sigma,w);
figure;
showScaleSpace(DoG, 1);
