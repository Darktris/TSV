function PSSLoG=doLoGScaleSpacePyramid(ima,factor,nlevels,nscales,sigma,w)
%ima : imagen leida desde archivo
%factor : factor de diezmado
%nlevels : número de niveles en la pirámide
%nscales : número de escalas en la pirámide (si no es impar se le suma 1
%internamente)
%sigma : desviación típica para el filtrado Gaussiano en el espacio escala
%w : tamaño (wxw) del filtro Gaussiano
%EJEMPLO :
% PSSLoG=doLoGScaleSpacePyramid(ima,2,3,5,0.64,5);
    if (mod(nscales, 2) == 0)
        nscales = nscales + 1;
    end
    
    PSSG=doGaussianScaleSpacePyramid(ima,factor,nlevels,nscales,sigma,w);
    for i=1:nlevels
        for j=1:nscales-1
            %ima_diff = PSSG{i, j}-PSSG{i, j+1};
            ima_diff =  (j+1).*sigma.*(PSSG{i, j+1}-PSSG{i, j});
            PSSLoG{i, j} = ima_diff;
        end
    end


end