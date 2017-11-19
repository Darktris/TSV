function P = doGaussianPyramid(ima,factor,nlevels,filter_type)
%ima         : imagen leída desde archivo
%factor      : factor de diezmado
%nlevels     : número de niveles en la pirámide
%filter_type : tipo de filtrado pre diezmado:


P{1} = double(ima);

for i=2:nlevels
    if filter_type==0
        ima_filtrada = P{i-1};
    elseif filter_type==1
        filter_mask = [1, 1; 1, 1]/4;
        ima_filtrada = imfilter(P{i-1}, filter_mask);
    elseif filter_type==2
        a = 0.4;
        vector = [1/4 - a/2,1/4,a,1/4,1/4-a/2]';
        filter_mask = vector * vector';
        ima_filtrada = imfilter(P{i-1}, filter_mask);
    elseif filter_type==3
        filter_mask = fspecial('gaussian',[5,5],0.64);
        ima_filtrada = imfilter(P{i-1}, filter_mask);
    end
    
    Idiezmada = ima_filtrada(1:factor:end, 1:factor:end);
    P{i} = Idiezmada;
end

end