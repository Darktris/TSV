function PL =doLaplacianPyramid(ima,factor,nlevels)
%ima���������: imagen le�da desde archivo
%factor������: factor de diezmado
%nlevels�����: n�mero de niveles en la pir�mide
% EJEMPLOS��:
%�� � doLaplacianPyramid(ima,2,5);
%NOTA: Por defecto usa filter_type=3�?> filtro Gaussiano 5x5 sigma=0.64
%NOTA: La pir�mide se devuelve sin ning�n tipo de estirado

filter_type = 3;

P = doGaussianPyramid(ima,factor,nlevels,filter_type);

for i=1:nlevels-1
    ima_rescaled = double(imresize(P{i+1},[size(P{i},1),size(P{i},2)],'bilinear'));
    ima_diff = P{i}-ima_rescaled;
    PL{i} = ima_diff;
end


end

