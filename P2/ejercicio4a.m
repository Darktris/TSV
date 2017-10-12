clc, close all, clear all;
ima = double(imread('enigma.jpg'));
addpath('autoevaluacion');

load('filteredI.mat');

j = sqrt(-1);
[rows,cols] = size(Ifilt);
x = [0:1/(cols-1):1] - 1/2;
y = [0:1/(rows-1):1] - 1/2;
k = pi;
ax =30;
ay =10;
[X,Y] = meshgrid(x,y);
H = k.*(ax.*(X))+(ay.*(Y)) + 1e-10;
H = (1./(H)).*sin(H).*exp(-j*H); 

subplot 132
imshow(abs(H))
title(sprintf('H E=%g', getEnergia(abs(H))))

subplot 131
imshow(Ifilt);
title(sprintf('Imagen original E=%g', getEnergia(Ifilt)))


im_frec_2 = fft2(Ifilt);
im_frec = fftshift(im_frec_2);

Tsi = im_frec./H;

Tsi_temp = ifftshift(Tsi);
Tsi_2 = (ifft2(Tsi_temp));

ima_res = abs((Tsi_2));


subplot 133
imshow((ima_res))
title(sprintf('Imagen restaurada E=%g', getEnergia(ima_res)))

test_ej_4_a(Ifilt, Tsi_2,0)
