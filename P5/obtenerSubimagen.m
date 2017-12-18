function [subI] = obtenerSubimagen(I, M)
    M = floor(M);
    subI = I(M(1,2):M(2,2), M(1,1):M(2,1));
end

