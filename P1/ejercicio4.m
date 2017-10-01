close all;
clear all;
clc;

%%% Ejercicio 4a
ima = imread('imagenes/7_colores.jpg');
R = Negativo(ima(:, :, 1), 256);
G = Negativo(ima(:, :, 2), 256);
B = Negativo(ima(:, :, 3), 256);
ima_p = uint8(zeros(size(ima)));
ima_p(:, :, 1) = R;
ima_p(:, :, 2) = G;
ima_p(:, :, 3) = B;

subplot(4, 4, 1)
imshow(ima)
E = getEnergia(uint8(ima));
title(sprintf('Imagen original E=%g', E));
subplot(4, 4, 2)
imshow(ima(:, :, 1))
E = getEnergia(uint8(ima(:, :, 1)));
title(sprintf('Canal R E=%g', E));
subplot(4, 4, 3)
imshow(ima(:, :, 2))
E = getEnergia(uint8(ima(:, :, 2)));
title(sprintf('Canal G E=%g', E));

subplot(4, 4, 4)
imshow(ima(:, :, 3))
E = getEnergia(uint8(ima(:, :, 3)));
title(sprintf('Canal B E=%g', E));

subplot(4, 4, 6)
imhist(ima(:, :, 1))
subplot(4, 4, 7)
imhist(ima(:, :, 2))
subplot(4, 4, 8)
imhist(ima(:, :, 3))

subplot(4, 4, 9)
imshow(ima_p)
E = getEnergia(uint8(ima_p));
title(sprintf('Imagen negativo E=%g', E));
subplot(4, 4, 10)
imshow(ima_p(:, :, 1))
E = getEnergia(uint8(ima_p(:, :, 1)));
title(sprintf('Imagen negativo. Canal R E=%g', E));
subplot(4, 4, 11)
imshow(ima_p(:, :, 2))
E = getEnergia(uint8(ima_p(:, :, 2)));
title(sprintf('Imagen negativo. Canal G E=%g', E));
subplot(4, 4, 12)
imshow(ima_p(:, :, 3))
E = getEnergia(uint8(ima_p(:, :, 3)));
title(sprintf('Imagen negativo. Canal B E=%g', E));

subplot(4, 4, 14)
imhist(ima_p(:, :, 1))
subplot(4, 4, 15)
imhist(ima_p(:, :, 2))
subplot(4, 4, 16)
imhist(ima_p(:, :, 3))

%% Ejercicio 4b after image
close all;
time = 10;
[r,c,~] = size(ima);
imagray = rgb2gray(ima);
hFig = figure('units','normalized','outerposition',[0 0 1 1]);
imshow(ima_p); hold on, plot(ceil(c/2),ceil(r/2),'kx','MarkerSize',15,'LineWidth',3);
set(hFig, 'outerposition',[0 0 1 1],'Color',[0.7 0.7 0.7])
title(sprintf('Mire fijamente la X durante %d sec',time));
pause(time);
hold on, imshow(imagray);