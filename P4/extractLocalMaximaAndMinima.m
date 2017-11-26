function [maxima_st,minima_st] = extractLocalMaximaAndMinima(PSSLoG,N,W,w,factor)
% mev @ vpu 2017
maxima_st=[];
minima_st=[];
if nargin > 5 || nargin < 5
   
    sprintf(['PARAMETROS extractLocalMaximaAndMinima\n' ...
    'extractLocalMaximaAndMinima(PSSLoG,N,W,w,factor)\n'...
    'PSSLoG      : pir�mide LoG espacio-escala\n'  ...
    'N           : n�mero de m�ximos y n�mero m�nimos a extraer (los N m�s intensos, N m�ximos y N m�nimos)\n'...
    'W           : tama�o del vecindario para supresi�n espacial de no m�ximos y no m�nimos\n'...
    'w           : tama�o (wxw) del filtro Gaussiano usado para construir la pir�mide\n'...
    'factor      : factor de diezmado usado para construir la pir�mide\n'...
    'EJEMPLO     :\n' ...
    '            [maxima_st,minima_st] = extractLocalMaximaAndMinima(PSSLoG,100,10,5,2);\n'])
    return
    
end

%% calcular el n�mero de escalas y niveles
[nlevels,nscales]=size(PSSLoG);
%% crear im�genes de m�ximos y m�nimos por nivel e im�genes que almacenen escala
PMaxima  = cell(nlevels);
PMaximaS = cell(nlevels); 
PMinima  = cell(nlevels);
PMinimaS = cell(nlevels); 


for lv = 1:1:nlevels
    PMaxima{lv}   =  zeros(size(PSSLoG{lv,end}));
    PMaximaS{lv}  =  zeros(size(PSSLoG{lv,end}));
    
    PMinima{lv}   =  255.*ones(size(PSSLoG{lv,end}));
    PMinimaS{lv}  =  zeros(size(PSSLoG{lv,end}));
    
    for sc = 1:1:nscales
    %% imagen de m�ximos
        %i aislar imagen actual
        localP           = PSSLoG{lv,sc};
        %ii eliminar el efecto del suavizado Gaussiano de lado w (padding)
        localP(1:w,:)    = 0;localP(:,1:w)= 0;localP(end-w+1:end,:)= 0;localP(:,end-w+1:end)= 0;
        %iii actualizar la imagen de m�ximos
        mk               = localP > PMaxima{lv};
        PMaxima{lv}(mk)  = localP(mk);
        PMaximaS{lv}(mk) = sc+1;
    %% imagen de m�nimos
        %i aislar imagen actual
        localP           = PSSLoG{lv,sc};
        %ii eliminar el efecto del suavizado Gaussiano de lado w
        localP(1:w,:)    = 255;localP(:,1:w)= 255;localP(end-w+1:end,:)= 255;localP(:,end-w+1:end)= 255;
        %iii actualizar la imagen de m�nimos
        mk               = localP < PMinima{lv};
        PMinima{lv}(mk)  = localP(mk);
        PMinimaS{lv}(mk) = sc+1;
    end
end
%% extraer m�ximos y m�nimos locales
% estructuras auxiliares para extraer m�ximos y m�nimos de la imagen
    maximum_number_of_points = 0;
    for lv=1:nlevels,
        maximum_number_of_points = maximum_number_of_points + ceil(numel(PSSLoG{lv,1})./(W.*W));
    end
    % m�nimos
    minimaaux.it=1;
    minimaaux.y = zeros(1,maximum_number_of_points);
    minimaaux.x = zeros(1,maximum_number_of_points);
    minimaaux.v = zeros(1,maximum_number_of_points);
    minimaaux.s = zeros(1,maximum_number_of_points);
    minimaaux.l = zeros(1,maximum_number_of_points);

    % m�ximos
    maximaaux.it=1; 
    maximaaux.y = zeros(1,maximum_number_of_points);
    maximaaux.x = zeros(1,maximum_number_of_points);
    maximaaux.v = zeros(1,maximum_number_of_points);
    maximaaux.s = zeros(1,maximum_number_of_points);
    maximaaux.l = zeros(1,maximum_number_of_points);

%% extraer los m�ximos y m�nimos en cada nivel
se = strel('square',W);
for lv = 1:1:nlevels
%% M�nimos de la imagen 
    % localizador de m�ximos locales de los LoG (m�nimos locales de la imagen)
    %i condici�n de m�ximo local de la LoG
    mk         = (imdilate(PMaxima{lv},se) - PMaxima{lv}) == 0;
    %ii localizar el m�ximo local de la LoG espacialmente
    [y,x]    = find(mk > 0); 
    %ii n�mero de m�ximos local de la LoG extra�dos
    nextraidos = numel(y);
    %iv rellenar estructuras auxiliares
    if nextraidos > 0
        if lv == 1
        minimaaux.y(minimaaux.it:(minimaaux.it+nextraidos-1)) = y;
        minimaaux.x(minimaaux.it:(minimaaux.it+nextraidos-1)) = x;
        else % compensar el diezmado
        minimaaux.y(minimaaux.it:(minimaaux.it+nextraidos-1)) = (lv-1).*factor.*y;
        minimaaux.x(minimaaux.it:(minimaaux.it+nextraidos-1)) = (lv-1).*factor.*x;    
        end
        minimaaux.v(minimaaux.it:(minimaaux.it+nextraidos-1)) =  PMaxima{lv}(y + (x-1).*size(PMaximaS{lv},1));
        minimaaux.s(minimaaux.it:(minimaaux.it+nextraidos-1)) = PMaximaS{lv}(y + (x-1).*size(PMaximaS{lv},1));
        minimaaux.l(minimaaux.it:(minimaaux.it+nextraidos-1)) = lv;
        minimaaux.it = minimaaux.it + nextraidos;
    end
%% M�ximos de la imagen
% localizador de m�ximos locales de los LoG (m�ximos locales de la imagen)
    %i condici�n de m�ximo local de la LoG
    mk         = (imerode(PMinima{lv},se) - PMinima{lv}) == 0;
    %ii localizar el m�ximo local de la LoG espacialmente
    [y,x]    = find(mk > 0); 
    %ii n�mero de m�ximos local de la LoG extra�dos
    nextraidos = numel(y);
    %iv rellenar estructuras auxiliares
    if nextraidos > 0
        if lv == 1
        maximaaux.y(maximaaux.it:(maximaaux.it+nextraidos-1)) = y;
        maximaaux.x(maximaaux.it:(maximaaux.it+nextraidos-1)) = x;
        else % compensar el diezmado
        maximaaux.y(maximaaux.it:(maximaaux.it+nextraidos-1)) = (lv-1).*factor.*y;
        maximaaux.x(maximaaux.it:(maximaaux.it+nextraidos-1)) = (lv-1).*factor.*x;    
        end
        maximaaux.v(maximaaux.it:(maximaaux.it+nextraidos-1)) =  PMinima{lv}(y + (x-1).*size(PMinimaS{lv},1));
        maximaaux.s(maximaaux.it:(maximaaux.it+nextraidos-1)) = PMinimaS{lv}(y + (x-1).*size(PMinimaS{lv},1));
        maximaaux.l(maximaaux.it:(maximaaux.it+nextraidos-1)) = lv;
        maximaaux.it = maximaaux.it + nextraidos;
    end


end

%% obtenci�n de los N m�ximos m�s altos y los N m�nimos m�s bajos
% N m�nimos de la imagen asociados a los N m�ximos m�s altos de la LoG
[~  ,ix] = sort(minimaaux.v,'descend');
ixN      = ix(1:(min(numel(ix),N)));
minima_st.y = minimaaux.y(ixN);
minima_st.x = minimaaux.x(ixN);
minima_st.v = minimaaux.v(ixN);
minima_st.s = minimaaux.s(ixN);
minima_st.l = minimaaux.l(ixN);

% N m�ximos de la imagen asociados a los N m�nimos m�s altos (~m�s negativos) de la LoG
[~  ,ix] = sort(maximaaux.v,'ascend');
ixN      = ix(1:(min(numel(ix),N)));
maxima_st.y = maximaaux.y(ixN);
maxima_st.x = maximaaux.x(ixN);
maxima_st.v = maximaaux.v(ixN);
maxima_st.s = maximaaux.s(ixN);
maxima_st.l = maximaaux.l(ixN);


end
