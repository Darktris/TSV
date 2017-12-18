clear all, clc, close all
addpath('toolboxes/HoG/')
addpath('images')

% PARAMETROS
ima = imread('pandaModel.jpg');
ima2 = imread('panda2.jpg');
nwx = 6;
nwy = 6;


I = rgb2gray(ima);
I2 = rgb2gray(ima2);
sz = size(I2);

figure;
imshow(ima)
M = ginput(2);
M_plot = [M(1,1), M(1,2), M(2,1)-M(1,1), M(2,2)- M(1,2)];
figure;
subplot(1,2,1);
imshow(ima)
rectangle('Position',M_plot, 'LineWidth',2)
title('Imagen 1')
HM=HOG(obtenerSubimagen(I, uint8(M)),nwx,nwy);

ncM = M_plot(3);
nrM = M_plot(4);
step_x = floor(ncM./nwx);
step_y = floor(nrM./nwy);
i = 1;
j = 1;
dist_euclidea = zeros(numel(1:step_x:sz(1)), numel( 1:step_y:sz(2)))+inf; 
dist_euclidea_min = Inf;
x_min = 0;
y_min = 0;
for x = 1:step_x:sz(1)
    x_r = min(x, sz(1)-nrM);
    ext_x = floor(x_r+nrM);
    j = 1;
    for y = 1:step_y:sz(2)
        y_r = min(y, sz(2)-ncM);
        ext_y = floor(y_r+ncM);
        M_aux = [y_r x_r; ext_y ext_x];
        HM2=HOG(obtenerSubimagen(I2, M_aux),nwx,nwy);
        dist_euclidea(i, j) = sum((double(HM)-double(HM2)).^2);
        if (dist_euclidea(i, j) < dist_euclidea_min)
            dist_euclidea_min = dist_euclidea(i, j);
            x_min = x_r;
            y_min = y_r;
        end
        j = j + 1;
    end
    i = i + 1;
end

subplot(1,2,2);
imshow(ima2)
title('Imagen 2')
rectangle('Position', [y_min x_min ncM nrM], 'LineWidth',2)
