% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Cargar y visualizar imagen
img = imread('totoro.jpg');
% Nos quedamos con un solo canal
%img = rgb2ycbcr(img);
img_proc = img(:,:,1);

% Umbralizamos
umbral = 175;
img_proc(img_proc > umbral) = 255;
img_proc(img_proc <= umbral) = 0;

% Mostramos la imagen original umbralizada
E = getEnergia(img);
subplot(1, 2, 1)
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Realizamos una erosion (para dilatar los minimos, los tonos oscuros)
se = strel('disk', 7);
ima_res = Apertura(img_proc, se);
E = getEnergia(ima_res);
subplot(1, 2, 2);
imshow(ima_res);
title({'Imagen tras umbralización y apertura', sprintf('E = %g', E)});
