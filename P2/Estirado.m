function [ ima_res ] = Estirado( ima, MM, mm )
    %ESTIRADO Summary of this function goes here
    %   Detailed explanation goes here
    m = min(ima(:));
    M = max(ima(:));
    
    ima_res = (ima - m)/(M-m)*(MM-mm)+mm;

end

