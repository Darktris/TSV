close all;
clear all;
clc;

%%% Parametro del numero de iteraciones
niters = 100;
title_ima1 = 'imagenes/edificio_bw_512.bmp';
title_ima2 = 'imagenes/edificio_bw_1024.bmp';
[ima1,map1] = imread(title_ima1);
[ima2,map2] = imread(title_ima2);

L = length(map1(:,1));

c = [8,32,64,128];



% Opcion 2
% Usamos la opcion 2 por ser el más rápido de los dos primeros
% y por que el tercero trabaja sobre el mapa.
r = [0:L-1];
ima_1 = zeros([size(ima1), length(c)]);
tic;
for j=1:niters
    for i=1:length(c)
        s = min(r+c(i),L-1);
        ima_1(:, :, i) = s(ima1+1); % Sumamos 1 porque el valor 0 corresponde a s(1) 
    end
end
t2_512=toc;
fprintf('Method 2 Image %s\n', title_ima1)
fprintf('Number of iterations: %d\tTotal time: %fs\t Time per iter: %fs\n', niters, t2_512, t2_512/niters);


ima_2 = zeros([size(ima2), length(c)]);
tic;
for j=1:niters
    for i=1:length(c)
        s = min(r+c(i),L-1);
        ima_2(:, :, i) = s(ima2+1); % Sumamos 1 porque el valor 0 corresponde a s(1) 
    end
end
t2_1024 = toc;
fprintf('Method 2 Image %s\n', title_ima2)
fprintf('Number of iterations: %d\tTotal time: %fs\t Time per iter: %fs\n', niters, t2_1024, t2_1024/niters);

for i=1:length(c)
    test_ej_2_a(ima1, map1, map1, ima_1(:,:,i), c(i), 2, 0);
    subplot(2,4,i)
    imhist(uint8(ima_1(:,:,i)));
    E = getEnergia(uint8(ima_1(:,:,i)));
    title(sprintf('Imagen 512. C=%d E=%g', c(i), E));

    test_ej_2_a(ima2, map2, map2, ima_2(:,:,i), c(i), 2, 0);
    subplot(2,4,i+4)
    imhist(uint8(ima_2(:,:,i)));
    E = getEnergia(uint8(ima_2(:,:,i)));
    title(sprintf('Imagen 1024. C=%d E=%g', c(i), E));
end

