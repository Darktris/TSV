% Limpiar espacio de trabajo
close all
clear all
clc

% Path para autoevaluacion
addpath('autoevaluacion')
addpath('material')

% Parametros
N = 100;
kernel_type = 'square';
ima = imread('object.png');
mostrar = true;
delay = 0.00000001;


for n=fliplr(1:N)
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
subplot(3, 3, [4 5 6])
plot([-(N-1):N], area_diff);
title({sprintf('Delta M, N=%d', N)})

E = getEnergia(ima);
subplot(3, 3, 2)
imshow(ima)
title({'Imagen original', sprintf('E = %g', E)})

% visualizar imagen
ima_cierre = Cierre(ima, strel(kernel_type, N));
E = getEnergia(ima_cierre);
subplot(3, 3, 1)
imshow(Cierre(ima_cierre, strel(kernel_type, N)));
title({sprintf('Cierre con %s de lado %d E = %g', kernel_type, N, E)})

% visualizar imagen
ima_apertura = Apertura(ima, strel(kernel_type, N));
E = getEnergia(ima_apertura);
subplot(3, 3, 3)
imshow(ima_apertura);
title({sprintf('Apertura con %s de lado %d E = %g', kernel_type, N, E)})

subplot(3, 3, [7 8 9])
plot([-N:N], area_hist);
title({sprintf('M, N=%d', N)})
