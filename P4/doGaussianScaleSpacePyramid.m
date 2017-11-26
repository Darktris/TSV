function PSSG=doGaussianScaleSpacePyramid(ima,factor,nlevels,nscales,sigma,w)
%ima : imagen leida desde archivo
%factor : factor de diezmado
%nlevels : n�mero de niveles en la pir�mide
%nscales : n�mero de escalas en la pir�mide (si no es impar se le suma 1
%internamente)
%sigma : desviaci�n t�pica para el filtrado Gaussiano en el espacio escala
%w : tama�o (wxw) del filtro Gaussiano
%EJEMPLO :
% PSSG=doGaussianScaleSpacePyramid(ima,2,10,6,0.64,5); 
    if mod(nscales, 2)==0
        nscales = nscales + 1;
    end
    
    index_SS = ceil(nscales/2);
    filter_mask = fspecial('gaussian',[w,w], sigma);

    
    PSSG{1, 1} = double(ima);
    for j=2:nscales
        PSSG{1, j} = imfilter(PSSG{1, j-1}, filter_mask);
    end
    
    % Para cada nivel
    for i=2:nlevels      
        ima_filtrada = imfilter(PSSG{i-1, index_SS}, filter_mask);
        Idiezmada = ima_filtrada(1:factor:end, 1:factor:end);
        PSSG{i, 1} = Idiezmada;
        for j=2:nscales
            PSSG{i, j} = imfilter(PSSG{i, j-1}, filter_mask);
        end
    end

end