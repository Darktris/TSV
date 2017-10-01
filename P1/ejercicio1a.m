close all;
clear all;
clc;
addpath('correctores');
[x,map] = imread('imagenes/edificio_bw_512.bmp');
L = length(map(:,1));

c = [8,32,64,128];
% Opcion1 
ima_1 = zeros([size(x), length(c)]);

for i=1:length(c)
    ima_1(:, :, i) = min(x+c(i),L-1);
end

% Opcion2
r = [0:L-1];
ima_2 = zeros([size(x), length(c)]);

for i=1:length(c)
    s = min(r+c(i),L-1);
    ima_2(:, :, i) = s(x+1); % Sumamos 1 porque el valor 0 corresponde a s(1) 
end
% Opcion 3
maps_3 = zeros([size(map), length(c)]);

for i=1:length(c)
    maps_3(:, :, i) = (L-1)*map+c(i);
end
maps_3(maps_3>(L-1)) = L-1;
maps_3 = maps_3/(L-1);

for i=1:length(c)
    subplot(4,4,i)
    imshow(uint8(ima_1(:,:,i)));
    E = getEnergia(uint8(ima_1(:,:,i)));
    title(sprintf('Opción 1. C=%d E=%g', c(i), E));
    test_ej_1_a(x, map, map, ima_1(:,:,i), c(i), 1, 0);
    
    subplot(4,4,i+4)
    imshow(uint8(ima_2(:,:,i)));
    E = getEnergia(uint8(ima_2(:,:,i)));
    title(sprintf('Opción 2. C=%d E=%g', c(i), E));
    test_ej_1_a(x, map, map, ima_2(:,:,i), c(i), 2, 0); 
    
    subplot(4,4,i+8)
    subimage(x,maps_3(:,:,i));
    title(sprintf('Opción 3 (subimage). C=%d', c(i)));
    
    subplot(4,4,i+12)
    imshow(x,maps_3(:,:,i));
    title(sprintf('Opción 3 (imshow). C=%d', c(i)));
    test_ej_1_a(x, map, maps_3(:, :, i), x, c(i), 3, 0); 
end
