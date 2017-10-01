function DibujaComparativaEcualizada(ima,ima_eq,nombre)
% esta función no debe alterarla
E    = sum(double(ima(:)).^2);
E_eq = sum(double(ima_eq(:)).^2);

subplot(221),imshow(ima),   title(['Imagen ', nombre, sprintf(' E: %g',E)])
subplot(222),imshow(ima_eq),title(['Imagen eq. ', nombre, sprintf(' E: %g',E_eq)])
subplot(223),imhist(ima),   title(['Histograma imagen ', nombre, sprintf(' E: %g',E)])
subplot(224),imhist(ima_eq),title(['Histograma imagen eq. ', nombre, sprintf(' E: %g',E_eq)])

return