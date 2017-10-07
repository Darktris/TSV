clc, close all, clear all;
ima = double(imread('enigma.jpg'));
addpath('autoevaluacion');

s = [ones(1,3); zeros(1,3); -ones(1,3)]/6;
s2 = [ones(3,1), zeros(3,1), -ones(3,1)]/6;

FX = imfilter(ima,s);
FY = imfilter(ima,s2);
F = sqrt(FX.^2 + FY.^2); 

subplot(1,4,1);
imshow(uint8(ima));
subplot(1,4,2);
imshow(uint8(FX));
subplot(1,4,3);
imshow(uint8(FY));
subplot(1,4,4);
imshow(uint8(F));