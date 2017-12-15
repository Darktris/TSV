clear all, clc, close all
addpath('toolboxes/HoG/')
addpath('images')
I = imread('pandaModel.jpg');
nwx = 2;
nwy = 2;
I2 = imread('panda1.jpg');
sz = size(I2);

figure;
imshow(I)
M = ginput(2);
M_plot = [M(1,1), M(1,2), M(2,1)-M(1,1), M(2,2)- M(1,2)];
rectangle('Position',M_plot)
HM=HOG(I(M),nwx,nwy);


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
    for y = 1:step_y:sz(2)
        M_aux = [y x; y+step_y x+step_x];
        HM2=HOG(I2(M_aux),nwx,nwy);
        dist_euclidea(i, j) = sum((double(HM)-double(HM2)).^2);
        if (dist_euclidea(i, j) < dist_euclidea_min)
            dist_euclidea_min = dist_euclidea(i, j);
            x_min = x;
            y_min = y;
        end
        j = j + 1;
    end
    i = i + 1;
end

figure;
imshow(I2)
rectangle('Position', [x_min y_min step_x step_y])
