function imagenes_compuestas = generaImagenesCompuestas(ima,mascaras)

% procesa máscaras
if max(mascaras(:)) > 1, % comprueba el rango
    mascaras = mascaras > 0;
end
% componer imágenes
figure('Name','Resultado final','units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,1),imshow(ima);title('Imagen Original');
gray = repmat(rgb2gray(ima),[1,1,size(ima,3)]); 
imagenes_compuestas{1} = ima;imagenes_compuestas{2} = ima;imagenes_compuestas{3} = ima;
for ch=1:size(ima,3),
    imagenes_compuestas{ch} = ...
    uint8(0.25.*double(gray)).*uint8(~repmat(mascaras(:,:,ch),[1,1,size(ima,3)])) + ...
    ima.*uint8(repmat(mascaras(:,:,ch),[1,1,size(ima,3)])) ;   
    subplot(2,2,1+ch),imshow(imagenes_compuestas{ch});
    title(sprintf('Imagen compuesta %d',ch))
end
