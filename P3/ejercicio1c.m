% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')

% Cargar y visualizar imagen
img = imread('material/Bandas.bmp');
E = sum(double(img(:)).^2);
subplot(1, 3, 1)
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Mascara 1
mask =  [1 1;1 0;1 0]; 

img_d = imfilter_dilateD(img, mask);
img_d2 = imfilter_dilate(img, mask);
E_d = sum(double(img_d(:)).^2);
subplot(1, 4, 2)
imshow(img_d)
title({'imfilter_dilateD', sprintf('E = %g', E_d)}, 'Interpreter', 'none')

E_d = sum(double(img_d2(:)).^2);
subplot(1, 4, 3)
imshow(img_d2)
title({'imfilter_dilate', sprintf('E = %g', E_d)}, 'Interpreter', 'none')

diff = abs(img_d - img_d2);
E = getEnergia(diff);
subplot(1, 4, 4);
imshow(diff);
title({'diff', sprintf('E = %g', E)}, 'Interpreter', 'none')



img_e = imfilter_erodeD(img, mask);
E_e = sum(double(img_e(:)).^2);
%subplot(1, 3, 3)
%imshow(img_e)
%title({'imfilter_erodeD', sprintf('E = %g', E_e)}, 'Interpreter', 'none')
