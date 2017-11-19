% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Cargar y visualizar imagen
img = imread('Bandas.bmp');

col_central =cat(1, zeros(2,3), diag([1, 1, 1]), zeros(2,3));
col_ceros = zeros(7,2);
se1 = cat(2, col_ceros, col_central, col_ceros);
se2 = fliplr(diag([1 1 1]));

se_a = strel('arbitrary', se1);
se_b = strel('arbitrary', se2);
se3 = imfilter_dilateD(uint8(se1), se2);

se_c = strel('arbitrary', se3);


img_dilated_a = imdilate(img, se_a);
img_dilated_a_b = imdilate(img_dilated_a, se_b);
img_dilated_c = imdilate(img, se_c);


E = getEnergia(img);
subplot(2, 4, 1);
imshow(img);
title({'Original', sprintf('E = %g', E)});

E = getEnergia(se1);
subplot(2, 4, 2);
imshow(se1);
title({'El. estructurante a', sprintf('E = %g', E)});

E = getEnergia(se2);
subplot(2, 4, 3);
imshow(se2);
title({'El. estructurante a', sprintf('E = %g', E)});

E = getEnergia(se3);
subplot(2, 4, 4);
imshow(double(se3));
title({'El. estructurante a', sprintf('E = %g', E)});

E = getEnergia(img_dilated_a);
subplot(2, 4, 5);
imshow(img_dilated_a);
title({'Imagen dilatada con a', sprintf('E = %g', E)});


E = getEnergia(img_dilated_a_b);
subplot(2, 4, 6);
imshow(img_dilated_a_b);
title({'Imagen dilatada con a y b', sprintf('E = %g', E)});

E = getEnergia(img_dilated_c);
subplot(2, 4, 7);
imshow(img_dilated_c);
title({'Imagen dilatada con c', sprintf('E = %g', E)});

diff = (double(img_dilated_a_b) - double(img_dilated_c)).^2;
E = getEnergia(diff);
subplot(2, 4, 8);
imshow(diff);
title({'Diferencia', sprintf('E = %g', E)});

% Erosion
col_central =cat(1, zeros(2,3), ones(3, 3), zeros(2,3));
col_ceros = zeros(7,2);
se1 = cat(2, col_ceros, col_central, col_ceros);
se2 = diag([1 1 1]);

se_a = strel('arbitrary', se1);
se_b = strel('arbitrary', se2);
se3 = imfilter_dilateD(uint8(se1), se2);
se4 = imfilter_erodeD(uint8(se1), se2);

se_c1 = strel('arbitrary', se3);
se_c2 = strel('arbitrary', se4);

img_eroded_a = imerode(img, se_a);
img_eroded_a_b = imerode(img_eroded_a, se_b);
img_eroded_c1 = imerode(img, se_c1);
img_eroded_c2 = imerode(img, se_c2);

figure;
E = getEnergia(img);
subplot(2, 5, 1);
imshow(img);
title({'Original', sprintf('E = %g', E)});

E = getEnergia(se1);
subplot(2, 5, 2);
imshow(se1);
title({'El. estructurante a', sprintf('E = %g', E)});

E = getEnergia(se2);
subplot(2, 5, 3);
imshow(se2);
title({'El. estructurante b', sprintf('E = %g', E)});

E = getEnergia(se3);
subplot(2, 5, 4);
imshow(double(se3));
title({'El. estructurante b', sprintf('E = %g', E)});

E = getEnergia(se3);
subplot(2, 5, 4);
imshow(double(se3));
title({'El. estructurante c (1)', sprintf('E = %g', E)});

E = getEnergia(se4);
subplot(2, 5, 5);
imshow(double(se4));
title({'El. estructurante c (2)', sprintf('E = %g', E)});


E = getEnergia(img_eroded_a_b);
subplot(2, 5, 6);
imshow(img_eroded_a_b);
title({'Imagen erosionada con a y b', sprintf('E = %g', E)});

E = getEnergia(img_eroded_c1);
subplot(2, 5, 7);
imshow(img_eroded_c1);
title({'Imagen erosionada con c (1)', sprintf('E = %g', E)});

E = getEnergia(img_eroded_c2);
subplot(2, 5, 8);
imshow(img_eroded_c2);
title({'Imagen erosionada con c (2)', sprintf('E = %g', E)});

diff = (double(img_eroded_c1) - double(img_eroded_a_b)).^2;
E = getEnergia(diff);
subplot(2, 5, 9);
imshow(diff);
title({'Diferencia c (1)', sprintf('E = %g', E)});


diff = (double(img_eroded_c2) - double(img_eroded_a_b)).^2;
E = getEnergia(diff);
subplot(2, 5, 10);
imshow(diff);
title({'Diferencia c (2)', sprintf('E = %g', E)});

