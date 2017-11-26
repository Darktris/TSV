clear all
close all
clc

addpath('imagenes')
addpath('autocorrectores')
addpath('material_básicos')

ima     = (rgb2gray(imread('Shannon.jpg')));
nlevels = 6;
nscales = 7;
sigma   = 0.64;
factor  = 2;
w       = 5;
N       = 100;
W       = 10;

se = strel('square', w);


PSSLoG=doLoGScaleSpacePyramid(ima,factor,nlevels,nscales,sigma,w);
[maxima_st,minima_st] = extractLocalMaximaAndMinima(PSSLoG,N,W,w,factor);


radios_minimo = zeros(size(minima_st.x));
for i=1:numel(minima_st.x)
    if minima_st.l(i) == 1
        radios_minimo(i) = sigma * minima_st.s(i);
    else
        radios_minimo(i) = sigma * (minima_st.s(i)) * factor * (minima_st.l(i) - 1);
    end
end

radios_maximo = zeros(size(maxima_st.x));
for i=1:numel(maxima_st.x)
    if maxima_st.l(i) == 1
        radios_maximo(i) = 1.1*sigma * (maxima_st.s(i));
    else
        radios_maximo(i) = 1.1* sigma * (maxima_st.s(i)) * factor * (maxima_st.l(i) - 1);
    end
end

imshow(ima)


for i=1:numel(minima_st.x)
    x = minima_st.x(i);
    y = minima_st.y(i);
    r = radios_minimo(i);
    d = r*2;
    px = x-r;
    py = y-r;
    hold on, rectangle('Position',[x-r, y-r,d,d],'Curvature',[1 1],'EdgeColor','b','LineWidth',1);
    x = maxima_st.x(i);
    y = maxima_st.y(i);
    r = radios_maximo(i);
    d = r*2;
    px = x-r;
    py = y-r;
    hold on, rectangle('Position',[x-r, y-r,d,d],'Curvature',[1 1],'EdgeColor','r','LineWidth',1);
end


%hold on, plot(minima_st.x,minima_st.y,'ob'),
%hold on, viscircles([minima_st.x' , minima_st.y'],  radios_minimo, 'Color','b', 'LineWidth', 1);
%hold on, viscircles([maxima_st.x' , maxima_st.y'],  radios_maximo, 'Color','r', 'LineWidth', 1);
%hold on, plot(maxima_st.x,maxima_st.y,'*r')
%legend('Local minima of image','Local maxima of image') 

% r = t * sigma si lvl = 1
% r = t * sigma * factor * (lvl -1)
