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

Ifilt_Q = double(uint8(255.*Ifilt./max(Ifilt(:))))/255;

im_frec_2 = fft2(Ifilt_Q);
im_frec = fftshift(im_frec_2);

k = 0.00170;
Tsi = im_frec.*(1./H.*(abs(H).^2)./(abs(H).^2+k));
Tsi_mal = im_frec./H;

Tsi_temp = ifftshift(Tsi);
Tsi_2 = (ifft2(Tsi_temp));
Tsi_tempmal = ifftshift(Tsi_mal);
Tsi_2mal = (ifft2(Tsi_tempmal));

ima_res = abs((Tsi_2));
ima_resmal = real((Tsi_2mal));

subplot(2,2,1);
imshow(Ifilt);
E = getEnergia(Ifilt);
title(sprintf('Solo H E=%g', E));
subplot(2,2,2);
imshow(Ifilt_Q);
E = getEnergia(Ifilt_Q);
title(sprintf('Ruido Q E=%g', E));
subplot(2,2,3);
imshow(ima_resmal);
E = getEnergia(ima_resmal);
title(sprintf('Ausencia de ruido E=%g', E));
subplot(2,2,4);
imshow(ima_res);
E = getEnergia(ima_res);
title(sprintf('Wiener E=%g', E));
