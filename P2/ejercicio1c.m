clc, close all, clear all;

addpath('autoevaluacion');
addpath('material');

ima1 = double(imread('enigma.jpg'))/255;
ima2 = double(imread('puente.jpg'))/255;

%% Filtro del 3a - circular paso bajo

fs=400;
v1=1/fs;
v2=1/fs;
x=[0:v1:1];
y=[0:v2:1];
[X,Y]=meshgrid(x,y); 

f0x=0.5;
f0y=0.5;
Xc = (X - f0x);Yc = (Y - f0y);

D0=fs/4;
% filtro paso bajo ideal con frecuencia de corte D0
f_filter =double(Xc.^2 + Yc.^2 <= (D0/fs).^2); 

f_filter_d = ifftshift(f_filter);
h_d = ifft2(f_filter_d);
h = fftshift(h_d);

cx = 1 + fs./2;
cy = 1 + fs./2;
w = 1;
%w = 0.5;

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
h_f(cy-w:cy+w,cx-w:cx+w) = filter_mask./C; 

h_f_d = fftshift(h_f);
f_filter_t_d = fft2(h_f_d);
f_filter_t = abs(ifftshift(f_filter_t_d));% sólo el módulo 

M = max(max( f_filter_t ));

m = min(min( f_filter_t ));

f_filter_t = (f_filter_t - m)/(M-m);
%% Filtro 3b - gaussiano
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
% filter_mask=filter_mask./C;

h_f = zeros(size(h));
h_f(cy-w:cy+w,cx-w:cx+w) = filter_mask./C; 

h_f_d = fftshift(h_f);
f_filter_t_d = fft2(h_f_d);
f_filter_t = abs(ifftshift(f_filter_t_d));% sólo el módulo 

M = max(max( f_filter_t ));

m = min(min( f_filter_t ));

f_filter_t = (f_filter_t - m)/(M-m);

%% Aplicacion
c=[3 5 7];
ima1_res = zeros([size(ima1), length(c)]);
ima2_res = zeros([size(ima2), length(c)]);
ima1_resbin = zeros([size(ima1), length(c)]);
ima2_resbin = zeros([size(ima2), length(c)]);
counter=1;
for i=c
    %%% Codigo filtro paso bajo circular
    
    
    mask = filter_mask
    mask = NormalizaMascara(mask);
    ima1_res(:,:,:,counter)=imfilter(ima1, mask);
    ima2_res(:,:,:,counter)=imfilter(ima2, mask);
    
    diff = DiferenciaCanalACanal(ima1, ima1_res(:,:,:,counter));
    % Imagen 1 - media
    figure
    subplot(2,3,1)
    E = getEnergia(ima1);
    imshow(uint8(ima1)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima1_res(:,:,:,counter));
    imshow(uint8(ima1_res(:,:,:,counter))); 
    title(sprintf('media orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 1 - binomial
    ima1_resbin(:,:,:,counter)=imfilter_binomial(ima1, i);
    diff = DiferenciaCanalACanal(ima1, ima1_resbin(:,:,:,counter));
    figure
    subplot(2,3,1)
    E = getEnergia(ima1);
    imshow(uint8(ima1)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima1_resbin(:,:,:,counter));
    imshow(uint8(ima1_resbin(:,:,:,counter))); 
    title(sprintf('binomial orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 2 - media 
    diff = DiferenciaCanalACanal(ima2, ima2_res(:,:,:,counter));
    figure
    subplot(2,3,1)
     E = getEnergia(ima2);
    imshow(uint8(ima2)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima2_res(:,:,:,counter));
    imshow(uint8(ima2_res(:,:,:,counter))); 
    title(sprintf('media orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 2 - binomial
    ima2_resbin(:,:,:,counter)=imfilter_binomial(ima2, i);
    diff = DiferenciaCanalACanal(ima2, ima2_resbin(:,:,:,counter));
    figure
    subplot(2,3,1)
    E = getEnergia(ima2);
    imshow(uint8(ima2)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima2_resbin(:,:,:,counter));
    imshow(uint8(ima2_resbin(:,:,:,counter))); 
    title(sprintf('binomial orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    
    counter = counter + 1;
end



%%
ima1_filtro3a = imfilter(ima1, filter_mask);
subplot 323
E = getEnergia(ima1_filtro3a);
imshow(ima1_filtro3a);
title(sprintf('Filtrado circular, E=%g', E));

ima2_filtro3a = imfilter(ima2, filter_mask);
subplot 324
E = getEnergia(ima2_filtro3a);
imshow(ima2_filtro3a);
title(sprintf('Filtrado circular, E=%g', E));
ima1_filtro3a = imfilter(ima1, filter_mask);