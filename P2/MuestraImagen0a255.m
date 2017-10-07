function [ none ] = MuestraImagen0a255( ima , title, pos, mode)
    if nargin == 3
        mode=0;
    end
    none=0;
    ima = uint8(ima);
    E = getEnergia(ima);
    subplot(pos(1),pos(2),pos(3));
    if mode==0
        titulo = sprintf('E=%g', E);
        imshow(ima),
        title(titulo);

    elseif mode==1
        imhist(ima),
        title(sprintf('%s, E=%g', title, E));
    elseif mode==2
        imagesc(ima),
        title(sprintf('%s, E=%g', title, E));
    end
end

