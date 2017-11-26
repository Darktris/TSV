clear all
close all
clc

% ejercicio5a
I     = (rgb2gray(imread('Shannon.jpg')));
sigma = 0.64;
k = 0.04;
N = 50;
W = 5;

I = double(I);
% ii) x and y derivatives
hx = [-1,0,1];
IX = conv2(I,hx,'same');
hy = [-1,0,1]';
IY = conv2(I,hy,'same'); 

figure;
subplot(1,3,1)
imshow(uint8(I))
E = getEnergia(I);
title(sprintf('Imagen original I E=%g', E))
subplot(1,3,2)
imagesc(IX)
E = getEnergia(IX);
title(sprintf('IX E=%g', E))
subplot(1,3,3)
imagesc(IY)
E = getEnergia(IY);
title(sprintf('IY E=%g', E))
colormap gray

% iii)
IX2 = IX.*IX; IY2 = IY.*IY; IXY = IX.*IY;

figure;
subplot(1,3,1)
imagesc(IX2)
E = getEnergia(IX2);
title(sprintf('IX2 E=%g', E))
subplot(1,3,2)
imagesc(IY2)
E = getEnergia(IY2);
title(sprintf('IY2 E=%g', E))
subplot(1,3,3)
imagesc(IXY)
E = getEnergia(IXY);
title(sprintf('IXY E=%g', E))
colormap gray

% iv)
cutoff = ceil(3.5*sigma);
h = fspecial('gaussian',[2*cutoff+1,2*cutoff+1],sigma);
SX2 = conv2(IX2,h,'same');
SY2 = conv2(IY2,h,'same');
SXY = conv2(IXY,h,'same');

figure;
subplot(1,3,1)
imagesc(SX2)
E = getEnergia(SX2);
title(sprintf('SX2 E=%g', E))
subplot(1,3,2)
imagesc(SY2)
E = getEnergia(SY2);
title(sprintf('SY2 E=%g', E))
subplot(1,3,3)
imagesc(SXY)
E = getEnergia(SXY);
title(sprintf('SXY E=%g', E))
colormap gray

% iv) calculo respuesta

Trace = SX2 + SY2;
Det = SX2.*SY2 - (SXY).^2;
R = Det - k .* Trace.^2;

figure;
subplot(1,3,1)
imagesc(Trace)
E = getEnergia(Trace);
title(sprintf('Trace E=%g', E))
subplot(1,3,2)
imagesc(Det)
E = getEnergia(Det);
title(sprintf('Det E=%g', E))
subplot(1,3,3)
imagesc(R)
E = getEnergia(R);
title(sprintf('R E=%g', E))
colormap gray

% v) calculo maximos locales
se = strel('square', W);
R(1:W,:)  = 0;R(:,1:W)= 0;R(end-W+1:end,:)= 0;R(:,end-W+1:end)= 0;

%i condición de máximo local de la LoG
mk = imdilate(R, se) - R;
mk = (mk == 0);
%ii localizar el máximo local de la LoG espacialmente
maximos = R.*mk;
valores_maximos = maximos(:);
[~  ,idx] = sort(valores_maximos,'descend');
idx = idx(1:(min(numel(idx),N)));
%ix = ix(1:N);
[I_row, I_col] = ind2sub(size(maximos),idx);

figure;
imshow(uint8(I)),
hold on, plot(I_col,I_row,'*r')
legend('Local maxima of image') 