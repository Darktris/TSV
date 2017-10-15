clc, close all, clear all;

addpath('autoevaluacion');
addpath('material');

ima1 = double(imread('enigma.jpg'));
ima2 = double(imread('puente.jpg'));


%% Aplicacion
c=[1 2 3];

ima1_res = zeros([size(ima1), length(c)]);
ima2_res = zeros([size(ima2), length(c)]);
ima1_resbin = zeros([size(ima1), length(c)]);
ima2_resbin = zeros([size(ima2), length(c)]);
counter=1;
for i=c
    %%%% Elaboracion de los filtros
    %Filtro del 3a - circular paso bajo
    w = i;
    fs=400;
    v1=1/fs;
    v2=1/fs;
    x=[0:v1:1];
    y=[0:v2:1];
    [X,Y]=meshgrid(x,y); 

    f0x=0.5;
    f0y=0.5;
    Xc = (X - f0x);Yc = (Y - f0y);

    D0=fs/4;
    % filtro paso bajo ideal con frecuencia de corte D0
    f_filter =double(Xc.^2 + Yc.^2 <= (D0/fs).^2); 

    f_filter_d = ifftshift(f_filter);
    h_d = ifft2(f_filter_d);
    h = fftshift(h_d);

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

    filter_mask_3a = filter_mask;

    % Filtro 3b - gaussiano
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
    sigma = D0/fs;
    norm = 1/(2*pi*sigma)*exp(-(0)/(2*sigma.^2));
    f_gaussiana = 1/(2*pi*sigma)*exp(-(Xc.^2 + Yc.^2)/(2*sigma.^2))/norm;
    %f_gaussiana = f_gaussiana./(1/(2*pi*sigma)*exp(-(0)/2*sigma^2));
    % filtro paso bajo ideal con frecuencia de corte D0
    f_filter = double(f_gaussiana); %double(Xc.^2 + Yc.^2 <= D0/fs); 

    f_filter_d = ifftshift(f_filter);
    h_d = ifft2(f_filter_d);
    h = fftshift(h_d);

    cx = 1 + fs./2;
    cy = 1 + fs./2;

    w = i;
    ws =round(w*(1/(2*pi*D0/fs))); 

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

    filter_mask_3b = filter_mask;
    
    %%%%
    ima1_resa(:,:,:,counter)=imfilter(ima1, filter_mask_3a);
    ima2_resa(:,:,:,counter)=imfilter(ima2, filter_mask_3a);
    ima1_resb(:,:,:,counter)=imfilter(ima1, filter_mask_3b);
    ima2_resb(:,:,:,counter)=imfilter(ima2, filter_mask_3b);
    diff1a = DiferenciaCanalACanal(ima1, ima1_resa(:,:,:,counter));
    diff2a = DiferenciaCanalACanal(ima2, ima2_resa(:,:,:,counter));
    diff1b = DiferenciaCanalACanal(ima1, ima1_resb(:,:,:,counter));
    diff2b = DiferenciaCanalACanal(ima2, ima2_resb(:,:,:,counter));
    % Imagen 1 - 3a
    figure
    subplot(2,3,1)
    E = getEnergia(ima1);
    imshow(uint8(ima1)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima1_resa(:,:,:,counter));
    imshow(uint8(ima1_resa(:,:,:,counter))); 
    title(sprintf('FPB orden w=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff1a(:,:,j));
        imagesc((diff1a(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 1 - 3b
    figure
    subplot(2,3,1)
    E = getEnergia(ima1);
    imshow(uint8(ima1)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima1_resb(:,:,:,counter));
    imshow(uint8(ima1_resb(:,:,:,counter))); 
    title(sprintf('Filtro gaussiano orden w=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff1b(:,:,j));
        imagesc((diff1b(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 2 - 3a 
    figure
    subplot(2,3,1)
     E = getEnergia(ima2);
    imshow(uint8(ima2)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima2_resa(:,:,:,counter));
    imshow(uint8(ima2_resa(:,:,:,counter))); 
    title(sprintf('FPB orden w=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff2a(:,:,j));
        imagesc((diff2a(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 2 - 3b
    figure
    subplot(2,3,1)
    E = getEnergia(ima2);
    imshow(uint8(ima2)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima2_resb(:,:,:,counter));
    imshow(uint8(ima2_resb(:,:,:,counter))); 
    title(sprintf('Filtro gaussiano orden w=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff2b(:,:,j));
        imagesc((diff2b(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    
    counter = counter + 1;
end

