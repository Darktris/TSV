ima = imread('imagenes/cumulo_bala.jpg');
imargb = ima;
ima = rgb2gray(ima);
L = 256;
   
%% Ejercicio 5a
close all;
[ima_th, umbral] = UmbralizaGlobalOtsu(ima);
ima_th = uint8(ima_th*255);

subplot(2,2,1);
imshow(ima);
E = getEnergia(ima);
title(sprintf('Imagen original. E = %g', E));
subplot(2,2,2); 
imshow(ima_th);
E = getEnergia(ima_th);
title(sprintf('Imagen resultado. umbral = %d, E = %g', umbral, E));
subplot(2,2,3);
imhist(ima);
subplot(2,2,4);
imhist(ima_th);

%% Apartado 5b

close all;

% Compresion logaritmica de la original
r = 0:L-1;
s = log(r+1);
ima_compr = s(ima+1)/log(255)*255;
ima_compr = uint8(ima_compr);
ima_compr_th =  uint8(UmbralizaGlobalOtsu(ima_compr)*255);

not_ima_compr_th = ~ ima_compr_th;
negativo_not_ima_th = Negativo(not_ima_compr_th, L);
subplot(2,2,1)
imshow(ima_compr);
E = sum(double(ima_compr(:)).^2);
title(sprintf('Imagen original comprimida. E = %g', E));
subplot(2,2,2)
imhist(ima_compr)
subplot(2,2,3)
imshow(ima_compr_th);
E = sum(double(ima_compr_th(:)).^2);
title(sprintf('Imagen comprimida umbralizada. E = %g', E));
subplot(2,2,4)
imhist(ima_compr_th)

%% Apartado 5c
close all;
negativo_ima = Negativo(ima, L);
r = 0:L-1;
s = log(r+1);
negativo_compr = s(negativo_ima+1)/log(255)*255;
negativo_compr = uint8(negativo_compr);

negativo_compr_th =  uint8(UmbralizaGlobalOtsu(negativo_compr)*255);

subplot(2,2,1)
imshow(negativo_compr);
E = sum(double(negativo_compr(:)).^2);
title(sprintf('Imagen original comprimida. E = %g', E));
subplot(2,2,2)
imhist(negativo_compr)
subplot(2,2,3)
imshow(negativo_compr_th);
E = sum(double(negativo_compr_th(:)).^2);
title(sprintf('Imagen comprimida umbralizada. E = %g', E));
subplot(2,2,4)
imhist(negativo_compr_th)

%% Apartado 5d
close all;
clc;
ima_th1 = ima_th/255;
ima_th2 = ima_compr_th/255;
ima_th3 = negativo_compr_th/255;
not_ima_th1 = uint8(~ima_th);
not_ima_th2 = uint8(~ima_compr_th);
not_ima_th3 = uint8(~negativo_compr_th);

subplot(3,4,1)
imshow(imargb)
E = getEnergia(imargb);
title(sprintf('Imagen original. E = %g', E));
subplot(3,4,2);
imshow(ima_th1*255)
E = getEnergia(ima_th1*255);
title(sprintf('Imagen OTSU (mask). E = %g', E));
subplot(3,4,3);
imshow(imargb.*ima_th1)
E = getEnergia(imargb.*ima_th1);
title(sprintf('Imagen RGB OTSU. E = %g', E));
subplot(3,4,4);
imshow(imargb.*not_ima_th1)
E = getEnergia(imargb.*not_ima_th1);
title(sprintf('Imagen RGB not OTSU. E = %g', E));
 
subplot(3,4,6);
imshow(ima_th2*255)
E = getEnergia(ima_th2*255);
title(sprintf('Imagen OTSU Log (mask). E = %g', E));
subplot(3,4,7);
imshow(imargb.*ima_th2)
E = getEnergia(imargb.*ima_th2);
title(sprintf('Imagen RGB OTSU Log. E = %g', E));
subplot(3,4,8);
imshow(imargb.*not_ima_th2)
E = getEnergia(imargb.*not_ima_th2);
title(sprintf('Imagen RGB not OTSU Log. E = %g', E));

subplot(3,4,10);
imshow(ima_th3*255);
E = getEnergia(ima_th3*255);
title(sprintf('Imagen OTSU Log Neg (mask). E = %g', E));
subplot(3,4,11);
imshow(imargb.*ima_th3);
E = getEnergia(imargb.*ima_th3);
title(sprintf('Imagen RGB OTSU Log Neg. E = %g', E));
subplot(3,4,12);
imshow(imargb.*not_ima_th3)
E = getEnergia(imargb.*not_ima_th3);
title(sprintf('Imagen RGB not OTSU Log Neg. E = %g', E));
