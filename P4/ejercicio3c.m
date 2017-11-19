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

SS=doGaussianScaleSpacePyramid(ima,factor,nlevels,nscales,sigma,w);
showPyramidScale(SS, 0);
