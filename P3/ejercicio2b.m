% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Cargar y visualizar imagen
img = imread('enigma_garab.png');
E = getEnergia(img);
subplot(1, 2, 1)
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Elemento estructurante
se = strel('disk', 3);

% Pruebas
ima_res = Apertura(img, se);
E = getEnergia(ima_res);
subplot(1, 2, 2);
imshow(ima_res);
title({'Restaurada por apertura', sprintf('E = %g', E)});
