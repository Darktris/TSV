function SS=doSpaceScale_decomp(ima,nscales,sigma,w)
%ima��������������: imagen le�da desde archivo
%nscales��������: n�mero de escalas en la descomposici�n
%sigma����������: desviaci�n del kernel Gaussiano cuadrado
%w�����������������: lado del kernel Gaussiano cuadrado
% EJEMPLO���:
%� ���doSpaceScale_decomp(ima,5,0.64,5);

SS{1} = double(ima);
filter_mask = fspecial('gaussian',[w,w],sigma);
for i=2:nscales
   SS{i} = imfilter(SS{i-1}, filter_mask);
end

end

