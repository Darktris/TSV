function DoG = doDoG(ima,nscales,sigma,w)
%ima��������������: imagen le�da desde archivo
%nscales��������: n�mero de escalas en la descomposici�n espacio escala
%sigma����������: desviaci�n del kernel Gaussiano cuadrado
%w�����������������: lado del kernel Gaussiano cuadrado
% EJEMPLO���:
%� doDoG(ima,5,0.64,5);

SS=doSpaceScale_decomp(ima,nscales,sigma,w);

for i=1:nscales-1
    DoG{i} = (i+1).*sigma.*(SS{i+1}-SS{i});
end
end

