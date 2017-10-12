
clc, close all, clear all;
addpath('autoevaluacion');
addpath('material');


ima = imread('enigma.jpg');

w = ones(3,3);
w = w./sum(w(:));


ima_res = imfilter(double(ima), w);

diff = zeros(size(ima));
for c=1:3
    diff(:,:,c) = (ima_res(:,:,c) - double(ima(:,:,c))).^2;
    
    subplot(1,3,c);
    imagesc((diff(:,:,c)));
    title(sprintf('Canal %c, E=%g', c, getEnergia(diff(:,:,c))))
end

figure
subplot(1,2,1);
imshow(ima);
title(sprintf('Imagen original E=%g', getEnergia(ima)))

subplot(1,2,2);
imshow(uint8(ima_res));
title(sprintf('Imagen resultado E=%g', getEnergia(ima_res)))
test_ej_1_a(ima,ima_res,0)
