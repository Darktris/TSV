% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Parametros
x = imread('Cuadros.bmp');
y = imread('Edificio.bmp');
se = strel('square', 3);

% Calculos
max_x_y = max(x, y);
min_x_y = min(x, y);

% Composicion con dilatacion
x_dilated = imdilate(x, se);
y_dilated = imdilate(y, se);
x_eroded = imerode(x, se);
y_eroded = imerode(y, se);
max_x_y_dilated = imdilate(max_x_y, se);
min_x_y_eroded = imerode(min_x_y, se);

E = getEnergia(x);
subplot(2, 4, 1)
imshow(x);
title({sprintf('Imagen 1 E = %g', E)})

E = getEnergia(y);
subplot(2, 4, 2)
imshow(y);
title({sprintf('Imagen 2 E = %g', E)})


E = getEnergia(max_x_y);
subplot(2, 4, 3)
imshow(max_x_y);
title({sprintf('Maximo Imagen 1 y 2 E = %g', E)})

E = getEnergia(max_x_y_dilated);
subplot(2, 4, 4)
imshow(max_x_y_dilated);
title({sprintf('Maximo dilatado Imagen 1 y 2 E = %g', E)})


E = getEnergia(x_dilated);
subplot(2, 4, 5)
imshow(x_dilated);
title({sprintf('Imagen 1 dilatada E = %g', E)})

E = getEnergia(y_dilated);
subplot(2, 4, 6)
imshow(y_dilated);
title({sprintf('Imagen 2 dilatada E = %g', E)})


E = getEnergia(max(x_dilated, y_dilated));
subplot(2, 4, 7)
imshow(max(x_dilated, y_dilated));
title({sprintf('Maximo Imagen 1 y 2 dilatadas E = %g', E)})

diff = max(x_dilated, y_dilated) - max_x_y_dilated;
E = getEnergia(diff);
subplot(2, 4, 8)
imshow(diff);
title({sprintf('diferencia (A-B)^2 E = %g', E)})

% Erosion
figure
E = getEnergia(x);
subplot(2, 4, 1)
imshow(x);
title({sprintf('Imagen 1 E = %g', E)})

E = getEnergia(y);
subplot(2, 4, 2)
imshow(y);
title({sprintf('Imagen 2 E = %g', E)})


E = getEnergia(min_x_y);
subplot(2, 4, 3)
imshow(min_x_y);
title({sprintf('Minimo Imagen 1 y 2 E = %g', E)})

E = getEnergia(min_x_y_eroded);
subplot(2, 4, 4)
imshow(min_x_y_eroded);
title({sprintf('Maximo erosionado Imagen 1 y 2 E = %g', E)})


E = getEnergia(x_eroded);
subplot(2, 4, 5)
imshow(x_eroded);
title({sprintf('Imagen 1 erosionada E = %g', E)})

E = getEnergia(y_dilated);
subplot(2, 4, 6)
imshow(y_dilated);
title({sprintf('Imagen 2 erosionada E = %g', E)})


E = getEnergia(min(x_eroded, y_eroded));
subplot(2, 4, 7)
imshow(min(x_eroded, y_eroded));
title({sprintf('Minimo Imagen 1 y 2 erosionadas E = %g', E)})

diff = min(x_eroded, y_dilated) - max_x_y_dilated;
E = getEnergia(diff);
subplot(2, 4, 8)
imshow(diff);
title({sprintf('diferencia (A-B)^2 E = %g', E)})
