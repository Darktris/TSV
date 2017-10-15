clc, close all, clear all;
ima = double(imread('ny_gray.png'));
addpath('autoevaluacion');


% Suavizado de ima
fs=400;
v1=1/fs;
v2=1/fs;
x=0:v1:1;
y=0:v2:1;
[X,Y]=meshgrid(x,y); 

f0x=0.5;
f0y=0.5;
Xc = (X - f0x);Yc = (Y - f0y);

D0=fs/8;
sigma = D0/fs;
norm = 1/(2*pi*sigma);
f_gaussiana = 1/(2*pi*sigma)*exp(-(Xc.^2 + Yc.^2)/(2*sigma.^2))/norm;
%f_gaussiana = f_gaussiana./(1/(2*pi*sigma)*exp(-(0)/2*sigma^2));
% filtro paso bajo ideal con frecuencia de corte D0
f_filter = double(f_gaussiana); %double(Xc.^2 + Yc.^2 <= D0/fs); 

f_filter_d = ifftshift(f_filter);
h_d = ifft2(f_filter_d);
h = fftshift(h_d);

cx = 1 + fs./2;
cy = 1 + fs./2;

%%%%% Orden del filtro normal
w = 3;
ws =round(w*(1/(2*pi*D0/fs))); 

filter_mask=h(cy-w:cy+w,cx-w:cx+w); 

[m,~] = min(filter_mask(:));
filter_mask = filter_mask./m; 
R = ceil(127./max(abs(filter_mask(:)))); 

% búsqueda de la versión entera que minimiza el MSE 
mse = Inf.*ones(1,R);
for j =1:R
    dif = (filter_mask - double(round(filter_mask.*j)./j)).^2;
    mse(j) = mean(dif(:));
end
[~,j]=find(mse==min(mse),1);
filter_mask = round(filter_mask.*j);

C = sum(filter_mask(:));
filter_mask=filter_mask./C;

h_f = zeros(size(h));
h_f(cy-w:cy+w,cx-w:cx+w) = filter_mask./C; 

h_f_d = fftshift(h_f);
f_filter_t_d = fft2(h_f_d);
f_filter_t = abs(ifftshift(f_filter_t_d));% sólo el módulo 

M = max(max( f_filter_t ));

m = min(min( f_filter_t ));

f_filter_t = (f_filter_t - m)/(M-m);

ima = abs(imfilter(ima, filter_mask));
% Busqueda de bordes

% Prewitt
s = [ones(1,3); zeros(1,3); -ones(1,3)]/6;
s2 = [ones(3,1), zeros(3,1), -ones(3,1)]/6;

FX = imfilter(ima,s);
FY = imfilter(ima,s2);
F = sqrt(FX.^2 + FY.^2); 

subplot(3,3,1);
imagesc(uint8(FX));
title(sprintf('Prewitt FX E=%g', getEnergia(FX)))

subplot(3,3,2);
imagesc(uint8(FY));
title(sprintf('Prewitt FY E=%g', getEnergia(FY)))

subplot(3,3,3);
imagesc(uint8(F));
title(sprintf('Prewitt F E=%g', getEnergia(F)))


% Roberts
s = [1 0; 0 -1];
s2 = [0 1; -1 0];

FX = imfilter(ima,s);
FY = imfilter(ima,s2);
F = sqrt(FX.^2 + FY.^2); 


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