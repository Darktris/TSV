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

ima_res_roberts = Estirado(F/255, 0, 1);
E = getEnergia(ima_res_roberts);
imshow(ima_res_roberts);
title(sprintf('Resultado 0-1 E=%g', E));

subplot(3,3,4);
imagesc(uint8(FX));
E = getEnergia(FX);
title(sprintf('FX E=%g', E));

subplot(3,3,5);
imagesc(uint8(FY));
E = getEnergia(FY);
title(sprintf('FY E=%g', E));

subplot(3,3,6);
imagesc(uint8(F));
E = getEnergia(F);
title(sprintf('F E=%g', E));


% Sobel
s = [1 1 1; 0 -1];
s2 = [0 1; -1 0];

FX = imfilter(ima,s);
FY = imfilter(ima,s2);
F = sqrt(FX.^2 + FY.^2); 

subplot(3,3,1);
E = getEnergia(ima);
imshow(uint8(ima));
title(sprintf('Original E=%g', E));

subplot(3,3,2);

ima_res_roberts = Estirado(F/255, 0, 1);
E = getEnergia(ima_res_roberts);
imshow(ima_res_roberts);
title(sprintf('Resultado 0-1 E=%g', E));

subplot(3,3,4);
imagesc(uint8(FX));
E = getEnergia(FX);
title(sprintf('FX E=%g', E));

subplot(3,3,5);
imagesc(uint8(FY));
E = getEnergia(FY);
title(sprintf('FY E=%g', E));

subplot(3,3,6);
imagesc(uint8(F));
E = getEnergia(F);
title(sprintf('F E=%g', E));
