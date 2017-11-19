clear all
close all
clc

ima = imread('I1.jpg');

factor = 2;
nlevels = 5;

P = doLaplacianPyramid(ima,factor,nlevels)

for i=1:nlevels-1
    Paux{i} = (P{i}-min(P{i}))/(max(P{i})-min(P{i}));
end

showPyramid(P, 1);


