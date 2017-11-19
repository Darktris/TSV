function PL =doLaplacianPyramid(ima,factor,nlevels)
%ima         : imagen leída desde archivo
%factor      : factor de diezmado
%nlevels     : número de niveles en la pirámide
% EJEMPLOS  :
%     doLaplacianPyramid(ima,2,5);
%NOTA: Por defecto usa filter_type=3 ?> filtro Gaussiano 5x5 sigma=0.64
%NOTA: La pirámide se devuelve sin ningún tipo de estirado

filter_type = 3;

P = doGaussianPyramid(ima,factor,nlevels,filter_type);

for i=1:nlevels-1
    ima_rescaled = double(imresize(P{i+1},[size(P{i},1),size(P{i},2)],'bilinear'));
    ima_diff = P{i}-ima_rescaled;
    PL{i} = ima_diff;
end


end

