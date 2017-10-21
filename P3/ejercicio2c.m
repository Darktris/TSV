% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Cargar y visualizar imagen
img = imread('verjanegra.jpg');
E = getEnergia(img);
subplot(1, 2, 1)
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Elemento estructurante
%'arbitrary', 'square', 'diamond', 'rectangle', 'octagon', 'line', 'disk', 'sphere', 'cube', 'cuboid'

se = strel('sphere', 3); % sphere 3 o diamond 3

% Pruebas
ima_res = Cierre(img, se);
E = getEnergia(ima_res);
subplot(1, 2, 2);
imshow(ima_res);
title({'Restaurada por apertura', sprintf('E = %g', E)});
