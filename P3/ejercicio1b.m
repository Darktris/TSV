% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')

% Cargar y visualizar imagen
img = imread('material/Bandas.bmp');
E = sum(double(img(:)).^2);
subplot(4, 4, [1 5 9 13])
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Mascara 1
mask1 = [1 1 1];

img_d1 = imfilter_dilate(img, mask1);
E_d1 = sum(double(img_d1(:)).^2);
subplot(4, 4, 2)
imshow(img_d1)
title({'imfilter_dilate (Mask 1)', sprintf('E = %g', E_d1)}, 'Interpreter', 'none')

img_e1 = imfilter_erode(img, mask1);
E_e1 = sum(double(img_e1(:)).^2);
subplot(4, 4, 6)
imshow(img_e1)
title({'imfilter_erode (Mask 1)', sprintf('E = %g', E_e1)}, 'Interpreter', 'none')

img_d1D = imfilter_dilateD(img, mask1);
E_d1D = sum(double(img_d1D(:)).^2);
subplot(4, 4, 3)
imshow(img_d1D)
title({'imfilter_dilateD (Mask 1)', sprintf('E = %g', E_d1D)}, 'Interpreter', 'none')

img_e1D = imfilter_erodeD(img, mask1);
E_e1D = sum(double(img_e1D(:)).^2);
subplot(4, 4, 7)
imshow(img_e1D)
title({'imfilter_erodeD (Mask 1)', sprintf('E = %g', E_e1D)}, 'Interpreter', 'none')

img_diff_d1 = abs(img_d1-img_d1D);
E_diff_d1 = sum(double(img_diff_d1(:)).^2);
subplot(4, 4, 4)
imshow(img_diff_d1)
title({'Dif. Dilate (Mask 1)', sprintf('E = %g', E_diff_d1)}, 'Interpreter', 'none')

img_diff_e1 = abs(img_e1-img_e1D);
E_diff_e1 = sum(double(img_diff_e1(:)).^2);
subplot(4, 4, 8)
imshow(img_diff_e1)
title({'Dif. Erode (Mask 1)', sprintf('E = %g', E_diff_e1)}, 'Interpreter', 'none')

% Mascara 2
mask2= [1 1 1; 1 1 1; 1 0 0];

img_d2 = imfilter_dilate(img, mask2);
E_d2 = sum(double(img_d2(:)).^2);
subplot(4, 4, 10)
imshow(img_d2)
title({'imfilter_dilate (Mask 2)', sprintf('E = %g', E_d2)}, 'Interpreter', 'none')

img_e2 = imfilter_erode(img, mask2);
E_e2 = sum(double(img_e2(:)).^2);
subplot(4, 4, 14)
imshow(img_e2)
title({'imfilter_erode (Mask 2)', sprintf('E = %g', E_e2)}, 'Interpreter', 'none')

img_d2D = imfilter_dilateD(img, mask2);
E_d2D = sum(double(img_d2D(:)).^2);
subplot(4, 4, 11)
imshow(img_d2D)
title({'imfilter_dilateD (Mask 2)', sprintf('E = %g', E_d2D)}, 'Interpreter', 'none')

img_e2D = imfilter_erodeD(img, mask2);
E_e2D = sum(double(img_e2D(:)).^2);
subplot(4, 4, 15)
imshow(img_e2D)
title({'imfilter_erodeD (Mask 2)', sprintf('E = %g', E_e2D)}, 'Interpreter', 'none')

img_diff_d2 = abs(img_d2-img_d2D);
E_diff_d2 = sum(double(img_diff_d2(:)).^2);
subplot(4, 4, 12)
imshow(img_diff_d2)
title({'Dif. Dilate (Mask 2)', sprintf('E = %g', E_diff_d2)}, 'Interpreter', 'none')

img_diff_e2 = abs(img_e2-img_e2D);
E_diff_e2 = sum(double(img_diff_e2(:)).^2);
subplot(4, 4, 16)
imshow(img_diff_e2)
title({'Dif. Erode (Mask 2)', sprintf('E = %g', E_diff_e2)}, 'Interpreter', 'none')

% Autoevaluacion
test_imfilter_dilate(img, @imfilter_dilate, 0)
test_imfilter_erode(img, @imfilter_erode, 0)