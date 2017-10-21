% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Cargar y visualizar imagen
img = imread('Tools.bmp');
E = sum(double(img(:)).^2);
subplot(2, 2, 1)
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Elemento estructurante
se = strel('square', 3);

% Dilatada
dilated = imdilate(img, se);
% Erosionada
eroded = imerode(img, se);

% Calculo gradienes
grad_d = dilated - img;
grad_e = img - eroded;
grad_m = dilated - eroded;

E = getEnergia(grad_d);
subplot(2, 2, 2);
imshow(grad_d);
title({'Gradiente por dilatacion', sprintf('E = %g', E)});

E = getEnergia(grad_e);
subplot(2, 2, 3)
imshow(grad_e)
title({'Gradiente por erosion', sprintf('E = %g', E)})

E = getEnergia(grad_m);
subplot(2, 2, 4);
imshow(grad_m);
title({'Gradiente morfologico', sprintf('E = %g', E)});
