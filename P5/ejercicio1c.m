% Limpiar espacio de trabajo
close all; clear all; clc;

% Paths
addpath('autoevaluacion');
addpath(genpath('toolboxes'));

% Cargar las imagenes
I1 = rgb2gray(imread('images/I1.jpg'));
I2 = rgb2gray(imread('images/I3.jpg'));
nM = 100;

% Redimensionado de las imagenes
[nr1,nc1] = size(I1);
[nr2,nc2] = size(I2);
I1= padarray(I1,[double(uint32((nr2-nr1)/2)),double(uint32((nc2-nc1)/2))],0);
I2= padarray(I2,[double(uint32((nr1-nr2)/2)),double(uint32((nc1-nc2)/2))],0);

I1 = imresize(I1, 0.25);
I2 = imresize(I2, 0.25);

I1 = im2single(I1);
I2 = im2single(I2);

figure

[Pos1, Pos2, H, inliers] = doHomography(I1,I2,nM);
test_doHomography(I1, I2, 30, @doHomography, 0)
imshow([I1 I2]); hold on;
plot([Pos1(:,1) Pos2(:,1)+size(I1,2)]',[Pos1(:,2) Pos2(:,2)]','-');
plot([Pos1(:,1) Pos2(:,1)+size(I1,2)]',[Pos1(:,2) Pos2(:,2)]','o'); 

Pos1_inliers = Pos1(inliers,:);
Pos2_inliers = Pos2(inliers,:);
figure;
imshow([I1 I2]); hold on;
plot([Pos1_inliers(:,1) Pos2_inliers(:,1)+size(I1,2)]',[Pos1_inliers(:,2) Pos2_inliers(:,2)]','-');
plot([Pos1_inliers(:,1) Pos2_inliers(:,1)+size(I1,2)]',[Pos1_inliers(:,2) Pos2_inliers(:,2)]','o'); 
tform = maketform('projective',H');
I1T = imtransform(I1,tform,'XData',[1 size(I1,2)], 'YData',[1 size(I1,1)]);
figure;
imshow(I1T)
