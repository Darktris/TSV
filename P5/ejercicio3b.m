% Limpiar espacio de trabajo
close all; clear all; clc;

% Cargar imagen
img = rgb2gray(imread('images/road_1.jpg'));
I = img;
th = 0.3;
sigma = 0.64;


thresh = zeros(1, 2);
thresh(2) = th;
thresh(1) = 0.4*th;

rho_r = 0.5; 
theta = -90:0.5:89.5;
%rho = x*cosd(theta)+y*sind(theta); 


% Canny
E = edge(I,'canny',thresh,sigma);
figure(1)
imshow(255.*uint8(E)+0.5.*I);
En = getEnergia(255.*uint8(E)+0.5.*I);
title(sprintf('th: %d sg: %d\nE: %d', th, sigma, En))


% Hough
[H,T,R] = hough(E,'RhoResolution',rho_r,'Theta',theta); 
figure(2),
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,'InitialMagnification','fit');
En = getEnergia(H);
title(sprintf('Hough transform\nE=%d', En));
xlabel('\theta'), ylabel('\rho');
axis on, axis normal; colormap(hot); 

% Maximos locales
NHOOD = 50;
H_max = H;
H_max(1:NHOOD,:)  = 0;H_max(:,1:NHOOD)= 0;H_max(end-NHOOD+1:end,:)= 0;H_max(:,end-NHOOD+1:end)= 0;

NHOOD = 50;
se = strel('square', NHOOD);
[mtheta, mrho] = extraerMaximosLocales(H_max, se);
v = zeros(size(mrho));

for i = 1:numel(mtheta)
    v(i) = H_max(mrho(i), mtheta(i));
end

[~, idx] = sort(v, 'descend');



jtheta = [mtheta(idx(1)), mtheta(idx(2))];
jrho = [mrho(idx(1)), mrho(idx(2))];
figure(2),hold on, plot(T(jtheta),R(jrho),'sg','MarkerSize',10)


x = 1:size(E,2);
y1 = (R(jrho(1))-x*cosd(T(jtheta(1))))/sind(T(jtheta(1)));
y2 = (R(jrho(2))-x*cosd(T(jtheta(2))))/sind(T(jtheta(2)));
figure(3), imshow(255.*uint8(E)+0.5.*I);
title(sprintf('Detecciones y punto de fuga en la imagen'))

figure(3),hold on, plot(x,y1,'sg','MarkerSize',2)
figure(3),hold on, plot(x,y2,'sg','MarkerSize',2)


