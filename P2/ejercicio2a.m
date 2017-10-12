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
title(sprintf('Imagen original E=%g', getEnergia(ima)))

subplot(1,4,2);
imagesc(uint8(FX));
title(sprintf('Grad. H E=%g', getEnergia(FX)))

subplot(1,4,3);
imagesc(uint8(FY));
title(sprintf('Grad. v E=%g', getEnergia(FY)))

subplot(1,4,4);
imagesc(uint8(F));
title(sprintf('Gradiente E=%g', getEnergia(F)))

test_ej_2_a(ima,F,FX,FY,0);
