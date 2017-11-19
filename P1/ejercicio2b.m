close all;
clear all;
clc;

[ima, vlt] = imread('imagenes/edificio_bc_512.bmp');

a = 80;
b = 160;
sa = 30;
sb = 220;
L = length(vlt(:, 1));

[ima_ajustada, s] = AjustePorTramos(ima, a, b, sa, sb, L);

subplot(3, 2, 1)
plot(0:255, s)
title(sprintf('Funcion de ajuste contraste; a=%d, sa=%d, b=%d, sb=%d', a, sa, b, sb));

subplot(3, 2, 3)
imshow(ima)
E = getEnergia(uint8(ima));
title(sprintf('Imagen original E=%g', E));
subplot(3, 2, 4)
imhist(ima)
title('histograma')
subplot(3, 2, 5)
imshow(uint8(ima_ajustada))
E = getEnergia(uint8(ima_ajustada));
title(sprintf('Imagen contraste modificado; a=%d, sa=%d, b=%d, sb=%d, E=%g', a, sa, b, sb, E));
subplot(3, 2, 6)
imhist(uint8(ima_ajustada))
title('histograma modificado')




