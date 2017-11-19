clear all
close all
clc

addpath('material_lunes')
ima = imread('ima_ej1.png');

% Apartado a
for i=1:3
    subplot(2,3,i)
    imshow(ima(:,:,i))
    subplot(2,3,i+3)
    imhist(ima(:,:,i))
end

ima_res = zeros(size(ima));
L = 256;

% Apartado b
figure
for i=1:3
    canal = ima(:,:,i);
    ima_res(:,:,i) = (exp(double(L-1-canal)));
    M = max(max(ima_res(:,:,i)));
    m = min(min(ima_res(:,:,i)));
    ima_res(:,:,i) = (ima_res(:,:,i)-m)/(M-m);
    subplot(2,3,i)
    imshow(ima_res(:,:,i))
    subplot(2,3,i+3)
    imhist(ima_res(:,:,i))
end

% Apartado c
addpath('../P1/')
figure
for i=1:3
    canal = ima_res(:,:,i);
    canal = uint8(255*canal);
    ima_res(:,:,i) = UmbralizaGlobalOtsu(canal);
    M = max(max(ima_res(:,:,i)));
    m = min(min(ima_res(:,:,i)));
    %ima_res(:,:,i) = (ima_res(:,:,i)-m)/(M-m);
    subplot(2,3,i)
    imshow(ima_res(:,:,i))
    subplot(2,3,i+3)
    imhist(ima_res(:,:,i))
end
ima_umbral = ima_res;

% Apartado d
figure
se = strel('diamond', 1);
for i=1:3
    canal = ima_res(:,:,i);
    ima_res(:,:,i) = imerode(canal, se);
    M = max(max(ima_res(:,:,i)));
    m = min(min(ima_res(:,:,i)));
    ima_res(:,:,i) = (ima_res(:,:,i)-m)/(M-m);
    subplot(2,3,i)
    imshow(ima_res(:,:,i))
    subplot(2,3,i+3)
    imhist(ima_res(:,:,i))
end
