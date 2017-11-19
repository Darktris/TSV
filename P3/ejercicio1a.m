% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')

% Cargar y visualizar imagen
img = imread('material/Bandas.bmp');
E = sum(double(img(:)).^2);
subplot(2, 3, [1 4])
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Mascara 1
mask1 = [1 1 1];
img_d1 = imfilter_dilate(img, mask1);
E_d1 = sum(double(img_d1(:)).^2);
subplot(2, 3, 2)
imshow(img_d1)
title({'Dilatacion (Mask 1)', sprintf('E = %g', E_d1)})
img_e1 = imfilter_erode(img, mask1);
E_e1 = sum(double(img_e1(:)).^2);
subplot(2, 3, 3)
imshow(img_e1)
title({'Erosion (Mask 1)', sprintf('E = %g', E_e1)})

% Mascara 2
mask2= [1 1 1; 1 1 1; 1 0 0];
img_d2 = imfilter_dilate(img, mask2);
E_d2 = sum(double(img_d2(:)).^2);
subplot(2, 3, 5)
imshow(img_d2)
title({'Dilatacion (Mask 2)', sprintf('E = %g', E_d2)})
img_e2 = imfilter_erode(img, mask2);
E_e2 = sum(double(img_e2(:)).^2);
subplot(2, 3, 6)
imshow(img_e2)
title({'Erosion (Mask 2)', sprintf('E = %g', E_e2)})

% Autoevaluacion
test_imfilter_dilate(img, @imfilter_dilate, 0)
test_imfilter_erode(img, @imfilter_erode, 0)