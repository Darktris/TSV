clc, close all, clear all;
ima = double(imread('enigma.jpg'));
addpath('autoevaluacion');

load('filteredI.mat');

%% Calculo del filtro laplaciano
[rows,cols] = size(Ifilt);
fs=400;
v1=1/fs;
v2=1/fs;
x = [0:1/(cols-1):1] - 1/2;
y = [0:1/(rows-1):1] - 1/2;
[X,Y]=meshgrid(x,y); 

f0x=0.5;
f0y=0.5;
Xc = (X);Yc = (Y);

D0=fs/8;

%f_gaussiana = f_gaussiana./(1/(2*pi*sigma)*exp(-(0)/2*sigma^2));
% filtro paso bajo ideal con frecuencia de corte D0
f_filter = -double(Xc.^2 + Yc.^2); %double(Xc.^2 + Yc.^2 <= D0/fs); 

f_filter_d = ifftshift(f_filter);
h_d = ifft2(f_filter_d);
h = fftshift(h_d);
if (sum(abs(imag(h(:)))) < exp(-10))
    h = real(h);
end    
cx = 1 + fs./2;
cy = 1 + fs./2;

w = 2;

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
% filter_mask=filter_mask./C;

h_f = zeros(size(h));
h_f(cy-w:cy+w,cx-w:cx+w) = filter_mask./C; 

h_f_d = fftshift(h_f);
f_filter_t_d = fft2(h_f_d);
f_filter_t = abs(ifftshift(f_filter_t_d));% sólo el módulo 

M = max(max( f_filter_t ));

m = min(min( f_filter_t ));

f_filter_t = (f_filter_t - m)/(M-m);

%% Calculo de la H
j = sqrt(-1);
[rows,cols] = size(Ifilt);
k = pi;
ax =30;
ay =10;
H = k.*(ax.*(X))+(ay.*(Y)) + 1e-10;
H = (1./(H)).*sin(H).*exp(-j*H);
Hc=H.*conj(H);
w_filter=(1./H).*(Hc./(Hc+k));

%% Calculo de las filtradas con ruido 
Ifilt_Q = double(uint8(255.*Ifilt./max(Ifilt(:))))/255;
Ifilt_G=imnoise(Ifilt,'gaussian',0,0.001);

im_frec = TransformadaFourier(Ifilt_G);
%% Calculo de las restauraciones 

% Wiener
k = 0.00170;
tsi_wiener = im_frec.*(1./H.*(abs(H).^2)./(abs(H).^2+k));
ima_res_wiener = InversaTransformadaFourier(tsi_wiener);
ima_res_wiener = real(ima_res_wiener);
%CLS
gamma=235;
laplacian_filter = f_filter;
f_lapc= laplacian_filter.*conj(laplacian_filter);
cls_filter=conj(H)./(Hc+gamma*f_lapc);
tsi_cls = cls_filter.*im_frec;
ima_res_cls = InversaTransformadaFourier(tsi_cls);
ima_res_cls = real(ima_res_cls);
% Sin ruido
tsi_naive = im_frec./H;
ima_res_naive = InversaTransformadaFourier(tsi_naive);
ima_res_naive = real(ima_res_naive);

%% Graficos 
subplot(2,2,1);
imshow(Ifilt);
E = getEnergia(Ifilt);
title(sprintf('Solo H E=%g', E));
subplot(2,2,2);
imshow(Ifilt_G);
E = getEnergia(Ifilt_G);
title(sprintf('Ruido G E=%g', E));

subplot(2,3,4);
imshow(ima_res_naive);
E = getEnergia(ima_res_naive);
title(sprintf('Ausencia de ruido E=%g', E));
subplot(2,3,5);
imshow(ima_res_wiener);
E = getEnergia(ima_res_wiener);
title(sprintf('Wiener E=%g', E));
subplot(2,3,6);
imshow(ima_res_cls);
E = getEnergia(ima_res_cls);
title(sprintf('CLS E=%g', E));