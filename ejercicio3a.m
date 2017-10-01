close all;
clear all;
clc;

[ima1] = imread('imagenes/unequalized.jpg');
[counts, binLocations] = imhist(ima1);
L = 256;

%%%% Parte 1 Estirado
nm = 0;
nM = 255;

m = min(binLocations(counts>0));
M = max(binLocations(counts>0));

r = 0:L-1;
s = (r - m)*(nM-nm)/(M-m)+nm;
ima_1 = s(ima1+1); % Sumamos 1 porque el valor 0 corresponde a s(1) 

ima_1 = uint8(ima_1);

subplot(2, 2, 1);
imhist(ima1);
subplot(2, 2, 2);
imshow(ima1);
subplot(2, 2, 3);
imhist(ima_1);
subplot(2, 2, 4);
imshow(ima_1);
figure;

%%%% Parte 2 Ecualizado manteniendo el rango

fpa = cumsum(counts/sum(counts));
s       = fpa(r+1);
ima_eq  = s(ima1+1);

nM = double(max(ima1(:)));
nm = double(min(ima1(:)));

m = min(ima_eq(:));
M = max(ima_eq(:));

ima_2 = (ima_eq - m)*(nM-nm)/(M-m)+nm;
ima_2 = uint8(ima_2); 

subplot(2, 2, 1);
imhist(ima1);
subplot(2, 2, 2);
imshow(ima1);
subplot(2, 2, 3);
imhist(ima_2);
subplot(2, 2, 4);
imshow(ima_2);
figure;

%%%% Parte 3 Ecualizado al rango maximo
s = fpa(r+1)*(L-1);
ima_3 = s(ima1+1);
ima_3 = uint8(ima_3);

subplot(2, 2, 1);
imhist(ima1);
subplot(2, 2, 2);
imshow(ima1);
subplot(2, 2, 3);
imhist(ima_3);
subplot(2, 2, 4);
imshow(ima_3);

test_ej_3_a(ima1, ima_1, ima_2, ima_3, 1)