% Limpiar espacio de trabajo
close all; clear all; clc;

% Paths
addpath('autoevaluacion');
addpath(genpath('toolboxes'));


% Cargar imagen
img = rgb2gray(imread('images/Shannon.jpg'));
I = single(img);

% Extraccion de puntos SIFT
[F,D] = vl_sift(I);

% Visualizacion de detecciones
imshow(img)
hold on
n2view = 30;
perm = randperm(size(F, 2));
sel = perm(1:n2view);
h2 = vl_plotframe(F(:, sel));
set(h2,'color','y');
h3 =vl_plotsiftdescriptor(D(:, sel),F(:, sel));
set(h3,'color','g')