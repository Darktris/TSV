clear all, close all, clc

I = double(imread('moon_gray.png'));
K = [1, 6, 11];
w = 2;
counter = 1;
masks = zeros((w*2+1), (w*2+1), length(K));


subplot 421
imshow(uint8(I));
E = getEnergia(uint8(I));
title(sprintf('Imagen original, E=%g', E));


for i=K
    I = double(I);
    % Filtro 3c - Laplaciano
    fs=400;
    v1=1/fs;
    v2=1/fs;
    x=[0:v1:1];
    y=[0:v2:1];
    [X,Y]=meshgrid(x,y); 

    f0x=0.5;
    f0y=0.5;
    Xc = (X - f0x);Yc = (Y - f0y);

    D0=fs/8;
    
    %f_gaussiana = f_gaussiana./(1/(2*pi*sigma)*exp(-(0)/2*sigma^2));
    % filtro paso bajo ideal con frecuencia de corte D0
    f_filter = 1+i.*(Xc.^2+Yc.^2); %double(Xc.^2 + Yc.^2 <= D0/fs); 

    f_filter_d = ifftshift(f_filter);
    h_d = ifft2(f_filter_d);
    h = fftshift(h_d);
    if (sum(abs(imag(h(:)))) < exp(-10))
        h = real(h);
    end    
    cx = 1 + fs./2;
    cy = 1 + fs./2;



    filter_mask=h(cy-w:cy+w,cx-w:cx+w); 

    [m,j] = min(filter_mask(:));
    filter_mask = filter_mask./m; 
    R = ceil(127./max(abs(filter_mask(:)))); 

    % búsqueda de la versión entera que minimiza el MSE 
    mse = Inf.*ones(1,R);
    for j =1:R
        dif = (filter_mask - double(round(filter_mask.*j)./j)).^2;
        mse(j) = mean(dif(:));
    end
    [~,j]=find(mse==min(mse),1);
    filter_mask = round(filter_mask.*j);

    C = sum(filter_mask(:));
    filter_mask=filter_mask./C;
    masks(:,:,counter) = filter_mask;
    

    IC = imfilter(I, filter_mask);
    m = min(IC(:));
    M = max(IC(:));
    ICest = (IC-m)/(M-m)*255;

    I = uint8(I);
    hist = imhist(I);
    I_res = histeq(uint8(ICest), hist);
    diff = (double(I)/255-double(I_res)/255).^2;
    % Por que esto en vez de abs(I-I_res)? esto se come muchos bordes que
    % de la otra manera salen...
    m = min(diff(:));
    M = max(diff(:));
    diff = (diff)/(M-m);

    subplot(4, 2, 2*counter+1);
    imshow(uint8(I_res));
    E = getEnergia(I_res);
    title(sprintf('Imagen combinada estirada K=%d, E=%g', i,  E));
    counter = counter + 1;
    subplot(4, 2, 2*counter)
    imshow((diff));
    E = getEnergia(diff);
    title(sprintf('Diferencia cuadrados K=%d, E=%g', i, E));
end


