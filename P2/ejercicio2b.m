clc, close all, clear all;
ima = double(imread('ny_gray.png'));
addpath('autoevaluacion');

% Roberts
s = [1 0; 0 -1];
s2 = [0 1; -1 0];

FX = imfilter(ima,s);
FY = imfilter(ima,s2);
F = sqrt(FX.^2 + FY.^2); 

subplot(3,3,1);
E = getEnergia(ima);
imshow(uint8(ima));
title(sprintf('Original E=%g', E));

subplot(3,3,2);

ima_res_roberts = (F)/(max(F(:)) - min(F(:)));
E = getEnergia(ima_res_roberts);
imshow(ima_res_roberts);
title(sprintf('Resultado Roberts 0-1 E=%g', E));

subplot(3,3,4);
imagesc(uint8(FX));
E = getEnergia(FX);
title(sprintf('Roberts FX E=%g', E));

subplot(3,3,5);
imagesc(uint8(FY));
E = getEnergia(FY);
title(sprintf('Roberts FY E=%g', E));

subplot(3,3,6);
imagesc(uint8(F));
E = getEnergia(F);
title(sprintf('Roberts F E=%g', E));


% Sobel
s = [1 2 1; 0 0 0; -1 -2 -1]/8;
s2 = [-1 -2 -1; 0 0 0; 1 2 1]'/8;

FX = imfilter(ima,s);
FY = imfilter(ima,s2);
F = sqrt(FX.^2 + FY.^2); 

subplot(3,3,3);

ima_res_sobel = (F)/(max(F(:)) - min(F(:)));%Estirado(F/255, 0, 1);
E = getEnergia(ima_res_sobel);
imshow(ima_res_sobel);
title(sprintf('Resultado Sobel 0-1 E=%g', E));

subplot(3,3,7);
imagesc(uint8(FX));
E = getEnergia(FX);
title(sprintf('Sobel FX E=%g', E));

subplot(3,3,8);
imagesc(uint8(FY));
E = getEnergia(FY);
title(sprintf('Sobel FY E=%g', E));

subplot(3,3,9);
imagesc(uint8(F));
E = getEnergia(F);
title(sprintf('Sobel F E=%g', E));
