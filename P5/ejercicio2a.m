% Limpiar espacio de trabajo
close all; clear all; clc;

% Cargar imagen
img = rgb2gray(imread('images/bowie.jpg'));
I = img;
th= 0.1:0.1:0.6; s = 0.2:0.2:2;
thresh = zeros(1, 2);
it = 1;
for threshold = th
    for sigma = s
        thresh(2) = threshold;
        thresh(1) = 0.4*threshold;
        %subplottight(numel(th),numel(s),it)
        subplot(numel(th),numel(s),it)
        res = edge(I,'canny',thresh,sigma);
        imshow(255.*uint8(res)+0.5.*I); 
        E = getEnergia(res);
        title(sprintf('th: %d sg: %d\nE: %d', threshold, sigma, E))
        it = it + 1;
    end
end




