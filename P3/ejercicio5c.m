% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')

% Cargar y visualizar imagen
img = imread('material/Edificio.bmp');
E = sum(double(img(:)).^2);
subplot(1, 3, 1)
imshow(img)
title({'Imagen original', sprintf('E = %g', E)})

% Mascara 1
se1 = strel('square', 3);
se2 = strel('diamond', 1);
se3 = [0 1 1; 1 1 0; 0 0 1];
se3 = strel('arbitrary', se3);
img_dilated1 = imdilate(img, se1);
img_dilated2 = imdilate(img, se2);
img_dilated3 = imdilate(img, se3);


E = getEnergia(img);
subplot(3, 4, 1);
imshow(img);
title({'Imagen original', sprintf('E = %g', E)}, 'Interpreter', 'none')

E = getEnergia(se1.Neighborhood);
subplot(3, 4, 2);
imshow(se1.Neighborhood);
title({'El. estructurante 1', sprintf('E = %g', E)}, 'Interpreter', 'none')

E = getEnergia(se2.Neighborhood);
subplot(3, 4, 3);
imshow(se2.Neighborhood);
title({'El. estructurant2 1', sprintf('E = %g', E)}, 'Interpreter', 'none')

E = getEnergia(se3.Neighborhood);
subplot(3, 4, 4);
imshow(se3.Neighborhood);
title({'El. estructurante 3', sprintf('E = %g', E)}, 'Interpreter', 'none')


E = getEnergia(img_dilated1);
subplot(3, 4, 6);
imshow(img_dilated1);
title({'Imagen dilatada 1', sprintf('E = %g', E)}, 'Interpreter', 'none')

E = getEnergia(img_dilated2);
subplot(3, 4, 7);
imshow(img_dilated2);
title({'Imagen dilatada 2', sprintf('E = %g', E)}, 'Interpreter', 'none')

E = getEnergia(img_dilated3);
subplot(3, 4, 8);
imshow(img_dilated3);
title({'Imagen dilatada 3', sprintf('E = %g', E)}, 'Interpreter', 'none')


diff1 = img_dilated1 - img;
E = getEnergia(diff1);
subplot(3, 4, 10);
imshow(diff1);
title({'diff', sprintf('E = %g', E)}, 'Interpreter', 'none')

diff2 = img_dilated2 - img;
E = getEnergia(diff2);
subplot(3, 4, 11);
imshow(diff2);
title({'diff', sprintf('E = %g', E)}, 'Interpreter', 'none')

diff3 = img_dilated3 - img;
E = getEnergia(diff3);
subplot(3, 4, 12);
imshow(diff3);
title({'diff', sprintf('E = %g', E)}, 'Interpreter', 'none')
