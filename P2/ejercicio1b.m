clc, close all, clear all;
addpath('autoevaluacion');
addpath('material');

ima1 = double(imread('enigma.jpg'));
ima2 = double(imread('puente.jpg'));

c=[3 5 7];
ima1_res = zeros([size(ima1), length(c)]);
ima2_res = zeros([size(ima2), length(c)]);
ima1_resbin = zeros([size(ima1), length(c)]);
ima2_resbin = zeros([size(ima2), length(c)]);
counter=1;
for i=c
    mask = ones(i,i);
    mask = NormalizaMascara(mask);
    ima1_res(:,:,:,counter)=imfilter(ima1, mask);
    ima2_res(:,:,:,counter)=imfilter(ima2, mask);
    
    diff = DiferenciaCanalACanal(ima1, ima1_res(:,:,:,counter));
    % Imagen 1 - media
    figure
    subplot(2,3,1)
    E = getEnergia(ima1);
    imshow(uint8(ima1)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima1_res(:,:,:,counter));
    imshow(uint8(ima1_res(:,:,:,counter))); 
    title(sprintf('media orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 1 - binomial
    ima1_resbin(:,:,:,counter)=imfilter_binomial(ima1, i);
    diff = DiferenciaCanalACanal(ima1, ima1_resbin(:,:,:,counter));
    figure
    subplot(2,3,1)
    E = getEnergia(ima1);
    imshow(uint8(ima1)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima1_resbin(:,:,:,counter));
    imshow(uint8(ima1_resbin(:,:,:,counter))); 
    title(sprintf('binomial orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 2 - media 
    diff = DiferenciaCanalACanal(ima2, ima2_res(:,:,:,counter));
    figure
    subplot(2,3,1)
     E = getEnergia(ima2);
    imshow(uint8(ima2)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima2_res(:,:,:,counter));
    imshow(uint8(ima2_res(:,:,:,counter))); 
    title(sprintf('media orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    % Imagen 2 - binomial
    ima2_resbin(:,:,:,counter)=imfilter_binomial(ima2, i);
    diff = DiferenciaCanalACanal(ima2, ima2_resbin(:,:,:,counter));
    figure
    subplot(2,3,1)
    E = getEnergia(ima2);
    imshow(uint8(ima2)); 
    title(sprintf('Original E=%g', E));
    
    subplot(2,3,3)
    E = getEnergia(ima2_resbin(:,:,:,counter));
    imshow(uint8(ima2_resbin(:,:,:,counter))); 
    title(sprintf('binomial orden c=%d E=%g', i, E));
    
    for j = 1:3
        subplot(2,3,3+j)
        E = getEnergia(diff(:,:,j));
        imagesc((diff(:,:,j))); 
        title(sprintf('Canal %d E=%g', j, E));
    end
    
    
    counter = counter + 1;
end