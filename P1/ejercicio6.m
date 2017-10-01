%% ej 6: Coloreando una imagen en escala de grises::plantilla
% mev @ vpu 09/2015
clear all
close all
clc
%% cargar el path de imágenes
addpath('./imagenes/')
%% read image
ima = imread('imagen_gris.jpg');
E = sum(double(ima(:)).^2);
subplot(121),imshow(ima),title(sprintf('Imagen original, E = %g',E))
subplot(122),imhist(ima),title(sprintf('Histograma Imagen original'))
%% ej 2 a: Selección de niveles por máscara binaria
%keyboard; % borre este comando cuando haya completado este apartado 
          %(teclee dbquit en el command window para terminar la depuración)
% seleción de niveles (susitituya las valores a -1 por los valores adecuados)
nivel_inf = 0; nivel_sup = 115;
[ima_vegetacion,mk_vegetacion] = seleccionDeNivel(ima,nivel_inf,nivel_sup);
nivel_inf = 115; nivel_sup = 190;
[ima_asfalto,mk_asfalto]       = seleccionDeNivel(ima,nivel_inf,nivel_sup);
nivel_inf = 190; nivel_sup = 256;
[ima_cielo,mk_cielo]           = seleccionDeNivel(ima,nivel_inf,nivel_sup);
% representación
figure('Name','Selección de niveles')
subplot(231),imshow(ima_vegetacion),title(sprintf(' Imagen Vegetación'))
subplot(232),imshow(ima_asfalto),title(sprintf(' Imagen Asfalto'))
subplot(233),imshow(ima_cielo),title(sprintf(' Imagen Cielo'))
subplot(234),imhist(ima_vegetacion),title(sprintf('Histograma Imagen Vegetación'))
subplot(235),imhist(ima_asfalto),title(sprintf('Histograma Imagen Asfalto'))
subplot(236),imhist(ima_cielo),title(sprintf('Histograma Imagen Cielo'))
%% ej 2 b:ecualizando el histograma de cada nivel
%keyboard; % borre este comando cuando haya completado este apartado 
          %(puede teclear dbquit en el command window para terminar la depuración)
% ecualización de niveles
ima_vegetacion_eq = ecualiza_nivel(ima_vegetacion);
ima_asfalto_eq    = ecualiza_nivel(ima_asfalto);
ima_cielo_eq      = ecualiza_nivel(ima_cielo);
% representación
figure('Name','Vegetación ecualizada')
DibujaComparativaEcualizada(ima_vegetacion,ima_vegetacion_eq,'vegetación');
figure('Name','Asfalto ecualizado')
DibujaComparativaEcualizada(ima_asfalto,ima_asfalto_eq,'asfalto');
figure('Name','Cielo ecualizado')
DibujaComparativaEcualizada(ima_cielo,ima_cielo_eq,'cielo');
%% ej 2 c:especificicación del histograma de cada nivel
%keyboard; % borre este comando cuando haya completado este apartado 
          %(puede teclear dbquit en el command window para terminar la depuración)
% leer imágenes plantilla (patrón o pattern)
patt_vegetacion = imread('vegetacion_3.jpg');% sustituya la imagen patrón si lo desea.
patt_asfalto    = imread('asfalto_3.jpg');% sustituya la imagen patrón si lo desea.
patt_cielo      = imread('cielo_2.jpg');% sustituya la imagen patrón si lo desea.
% especificando los niveles
ima_vegetacion_eq_esp = especifica_nivel(ima_vegetacion_eq,patt_vegetacion);
ima_asfalto_eq_esp    = especifica_nivel(ima_asfalto_eq,patt_asfalto);
ima_cielo_eq_esp      = especifica_nivel(ima_cielo_eq,patt_cielo);
%% ej 2 d:coloreando la imagen
% combinando imágenes
Niveles{1}  = ima_vegetacion_eq_esp; 
Mascaras{1} = double(mk_vegetacion);
Niveles{2}  = ima_asfalto_eq_esp;    
Mascaras{2} = double(mk_asfalto); 
Niveles{3}  = ima_cielo_eq_esp;      
Mascaras{3} = double(mk_cielo); 
ima_combinada = combinaNiveles(Niveles,Mascaras);
% representación del resultado final
figure('Name','Imagen Coloreada')
E = sum(double(ima(:)).^2);
subplot(121),imshow(ima);title(sprintf('Imagen original, E = %g',E))
E = sum(double(ima_combinada(:)).^2);
subplot(122),imshow(ima_combinada);title(sprintf('Imagen Coloreada (ejemplo), E = %g',E))




