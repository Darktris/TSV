% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Parametros
epsilon = 0.01; % Epsilon maquina
x = imread('texto_corrupto.png');
y = imread('marker.png');
marker = y;
kernel = strel('square', 3);

% Estructuras
diff = +Inf;
marker_erode = y;
niters = 0;
while diff > epsilon 
    niters = niters + 1;
    marker_erode = imerode(y, kernel);
    ima_max = max(marker_erode, x);
    diff = getEnergia(ima_max - y);
    y = ima_max;
end

E = getEnergia(x);
subplot(1, 3, 1)
imshow(x);
title({sprintf('Imagen original E = %g', E)})

E = getEnergia(marker);
subplot(1, 3, 2)
imshow(marker);
title({sprintf('Imagen marcador E = %g', E)})

E = getEnergia(y);
subplot(1, 3, 3)
imshow(y);
title({sprintf('Reconstruccion E = %g', E)})