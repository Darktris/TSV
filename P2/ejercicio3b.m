clc, close all, clear all;
addpath('material')
addpath('autoevaluacion')
ima = double(imread('enigma.jpg'));
addpath('autoevaluacion');

fs=400;
v1=1/fs;
v2=1/fs;
x=[0:v1:1];
y=[0:v2:1];
[X,Y]=meshgrid(x,y); 

f0x=0.5;
f0y=0.5;
Xc = (X - f0x);Yc = (Y - f0y);

D0=fs/8;
sigma = D0/fs;
norm = 1/(2*pi*sigma)*exp(-(0)/(2*sigma.^2));
f_gaussiana = 1/(2*pi*sigma)*exp(-(Xc.^2 + Yc.^2)/(2*sigma.^2))/norm;
%f_gaussiana = f_gaussiana./(1/(2*pi*sigma)*exp(-(0)/2*sigma^2));
% filtro paso bajo ideal con frecuencia de corte D0
f_filter = double(f_gaussiana); %double(Xc.^2 + Yc.^2 <= D0/fs); 

f_filter_d = ifftshift(f_filter);
h_d = ifft2(f_filter_d);
h = fftshift(h_d);

cx = 1 + fs./2;
cy = 1 + fs./2;

w = 1;
ws =round(w*(1/(2*pi*D0/fs))); 

filter_mask=h(cy-w:cy+w,cx-w:cx+w); 

[m,j] = min(filter_mask(:));
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
h_f(cy-w:cy+w,cx-w:cx+w) = filter_mask; 

h_f_d = fftshift(h_f);
f_filter_t_d = fft2(h_f_d);
f_filter_t = abs(ifftshift(f_filter_t_d));% sólo el módulo 

M = max(max( f_filter_t ));

m = min(min( f_filter_t ));

f_filter_t = (f_filter_t - m)/(M-m);

figure;
subplot 131
imagesc(f_filter);
colormap(gray)
E = getEnergia(f_filter);
title(sprintf('FPB gaussiano, E=%g', E));
subplot 132
imagesc(f_filter_t);
colormap(gray)
E = getEnergia(f_filter_t);
title(sprintf('FPB gaussiano, E=%g', E));
diff = (f_filter - f_filter_t).^2;
subplot 133
imagesc(diff);
colormap(gray)
E = getEnergia(diff);
title(sprintf('FPB gaussiano, E=%g', E));


