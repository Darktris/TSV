% Limpiar espacio de trabajo
close all; clear all; clc;

addpath('images')
% Cargar imagen
img = rgb2gray(imread('images/pupila_1.jpg'));
I = img;
th = 0.1;
sigma = 3;
mR = 55; % pupila 33, iris 50
E = edge(I,'canny',th,sigma);

[H] = circle_hough(E, 1:mR, 'same', 'normalise'); 
imshow(uint8(E).*255+0.75.*I)
c = zeros(mR, 2);
for r=1:mR
    image_r = H(:,:,r);
    linear = image_r(:);
    [~, idx] = max(linear);
    [y, x] = ind2sub(size(image_r), idx);
    c(r, 1) = x;
    c(r, 2) = y;
    hold on, plot(x,y,'xr')
    hold on, text(x-0.1,y-0.1,num2str((r)),'color','green');
    hold on, viscircles([x, y],r,'EdgeColor','b'); 
end

figure
imshow(uint8(E).*255+0.75.*I)
r = 33;
hold on, plot(c(r, 1),c(r, 2),'xr')
hold on, text(c(r, 1)-0.1,c(r, 2)-0.1,num2str((r)),'color','green');
hold on, viscircles(c(r, :),r,'EdgeColor','b'); 

r = 55;
hold on, plot(c(r, 1),c(r, 2),'xr')
hold on, text(c(r, 1)-0.1,c(r, 2)-0.1,num2str((r)),'color','green');
hold on, viscircles(c(r, :),r,'EdgeColor','b'); 
