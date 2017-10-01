close all;
clear all;
clc;

[ima, vlt] = imread('imagenes/7colores_uneq.bmp');

subplot(6, 4, 1)
imshow(ima)
E = getEnergia(uint8(ima));
title(sprintf('Imagen original. E=%g', E));
subplot(6, 4, 2)
imshow(ima(:,:,1))
E = getEnergia(uint8(ima(:,:,1)));
title(sprintf('Canal R. E=%g', E));
subplot(6, 4, 3)
imshow(ima(:,:,2))
E = getEnergia(uint8(ima(:,:,2)));
title(sprintf('Canal G. E=%g', E));
subplot(6, 4, 4)
imshow(ima(:,:,3))
E = getEnergia(uint8(ima(:,:,3)));
title(sprintf('Canal B. E=%g', E));


subplot(6, 4, 6)
imhist(ima(:, :, 1))
subplot(6, 4, 7)
imhist(ima(:, :, 2))
subplot(6, 4, 8)
imhist(ima(:, :, 3))

%%%%% No tiene VLT

%%%%% Opcion 1 Ecualizar RGB
ima_ecu(:,:,1) = Ecualizacion(ima(:,:,1), 256);
ima_ecu(:,:,2) = Ecualizacion(ima(:,:,2), 256);
ima_ecu(:,:,3) = Ecualizacion(ima(:,:,3), 256);

for i=1:3
    im = ima(:,:,i);
    im_ecu = ima_ecu(:,:,i);
    nM = 255;
    nm = 0;

    m = min(im_ecu(:));
    M = max(im_ecu(:));

    ima_ecu(:,:,i) = (im_ecu - m)*(nM-nm)/(M-m)+nm;
end

ima_ecu = uint8(ima_ecu);


subplot(6, 4, 9)
imshow(ima_ecu)
E = getEnergia(uint8(ima_ecu));
title(sprintf('Imagen ecualizada RGB. E=%g', E));
subplot(6, 4, 10)
imshow(ima_ecu(:,:,1))
E = getEnergia(uint8(ima_ecu(:,:,1)));
title(sprintf('Canal R. E=%g', E));
subplot(6, 4, 11)
imshow(ima_ecu(:,:,2))
E = getEnergia(uint8(ima_ecu(:,:,2)));
title(sprintf('Canal G. E=%g', E));
subplot(6, 4, 12)
imshow(ima_ecu(:,:,3))
E = getEnergia(uint8(ima_ecu(:,:,3)));
title(sprintf('Canal B. E=%g', E));


subplot(6, 4, 14)
imhist(ima_ecu(:, :, 1))
subplot(6, 4, 15)
imhist(ima_ecu(:, :, 2))
subplot(6, 4, 16)
imhist(ima_ecu(:, :, 3))



%%%%% Opcion 2 Ecualizar solo V
ima_hsv = rgb2hsv(ima);
v = ima_hsv(:,:,3);
v = uint8(v*255);
v_res = Ecualizacion(v, 256);
im = ima(:,:,i);

nM = 255;
nm = 0;

m = min(v_res(:));
M = max(v_res(:));

v_res = (v_res - m)*(nM-nm)/(M-m)+nm;


ima_hsv(:,:,3) = v_res;
ima_res = uint8(hsv2rgb(ima_hsv));

subplot(6, 4, 17)
imshow(ima_res)
E = getEnergia(uint8(ima_res));
title(sprintf('Imagen canal V ecualizado. E=%g', E));
subplot(6, 4, 18)
imshow(ima_res(:,:,1))
E = getEnergia(uint8(ima_res(:,:,1)));
title(sprintf('Canal R. E=%g', E));
subplot(6, 4, 19)
imshow(ima_res(:,:,2))
E = getEnergia(uint8(ima_res(:,:,2)));
title(sprintf('Canal G. E=%g', E));
subplot(6, 4, 20)
imshow(ima_res(:,:,3))
E = getEnergia(uint8(ima_res(:,:,3)));
title(sprintf('Canal B. E=%g', E));

subplot(6, 4, 22)
imhist(ima_res(:, :, 1))
subplot(6, 4, 23)
imhist(ima_res(:, :, 2))
subplot(6, 4, 24)
imhist(ima_res(:, :, 3))
