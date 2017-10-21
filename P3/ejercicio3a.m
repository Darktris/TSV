% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Parametros
N = 20;
kernel_type = 'square';
ima = imread('object.png');
mostrar = true;
delay = 0.01;


% Estructuras
area_hist_close = zeros(1, N);
area_hist_open = zeros(1, N);
[w, h] = size(ima);
% ima_close = zeros(N, w, h);
% ima_open = zeros(N, w, h);
% for n=1:N
%     b_kernel = strel(kernel_type, n);
%     ima_close(n,:,:) = Cierre(ima, b_kernel);
%     ima_open(n,:,:) = Apertura(ima, b_kernel);
%     ima_res = ima_close(n, :, :);
%     area_hist_close(n) = sum(ima_res(:));
%     ima_res = ima_open(n, :, :);
%     ima_res(1)
%     area_hist_open(n) = sum(ima_res(:));
% end
% if mostrar
%     figure;
%     for n=1:N
%         ima_res = squeeze(ima_close(n,:,:));
%         imshow(ima_res);
%         pause(delay);
%     end
%     for n=1:N
%         ima_res = squeeze(ima_open(n,:,:));
%         imshow(ima_res);
%         pause(delay);
%     end
% end

for n=1:N
    b_kernel = strel(kernel_type, n);
    ima_close = Cierre(ima, b_kernel);
    area_hist_close(n) = sum(ima_close(:));
    if mostrar
        imshow(ima_close);
        pause(delay)
    end
end

for n=1:N
    b_kernel = strel(kernel_type, n);
    ima_open = Apertura(ima, b_kernel);
    area_hist_open(n) = sum(ima_open(:));
    if mostrar
        imshow(ima_open);
        pause(delay)
    end
end


figure;
area_hist = [fliplr(area_hist_close), sum(ima(:)), area_hist_open]; 
area_diff = abs([area_hist 0] - [0 area_hist]);
area_diff = area_diff(2:end-1);
subplot(2, 3, [4 5 6])
plot([-(N-1):N], area_diff);

E = getEnergia(ima);
subplot(2, 3, 2)
imshow(ima)
title({'Imagen original', sprintf('E = %g', E)})
% visualizar imagen
ima_cierre = Cierre(ima, strel(kernel_type, N));
E = getEnergia(ima_cierre);
subplot(2, 3, 1)
imshow(Cierre(ima_cierre, strel(kernel_type, N)));
title({sprintf('Cierre con %s de lado %d E = %g', kernel_type, N, E)})
% visualizar imagen
ima_apertura = Apertura(ima, strel(kernel_type, N));
E = getEnergia(ima_apertura);
subplot(2, 3, 3)
imshow(ima_apertura);
title({sprintf('Apertura con %s de lado %d E = %g', kernel_type, N, E)})

