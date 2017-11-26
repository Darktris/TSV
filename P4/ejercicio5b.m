clear all
close all
clc

addpath('imagenes')
addpath('autocorrectores')
addpath('material_básicos')

% Atencion: codigo sin optimizaciones (preallocation, loops simplification 
% ...), ya que se ha realizado tratando de entender el algoritmo paso a
% paso.
I     = double(rgb2gray(imread('Shannon.jpg')));
nlevels = 3;
nscales = 5;
sigma   = 0.64;
factor  = 2;
w       = 5;
k = 0.04;
N = 25+1;
W = 5;

SS=doGaussianScaleSpacePyramid(I,factor,nlevels,nscales,sigma,w);
% Para cada nivel de la piramide SS
for i=1:nlevels
    % Para cada escala de la piramide SS
    for j=1:nscales
        % Hallamos el detector Harris
        [X{i, j}, Y{i, j}, R{i, j}] = detectorHarris(SS{i, j}, sigma, k, N, W);
        % Amplitud del filtro Gaussiano
        Sigma{i, j} = j*sigma;
        X_rescaled{i, j} = X{i, j};
        Y_rescaled{i, j} = Y{i, j}
        % Reescalado para contrarrestar el diezmado de la piramide
        if i ~= 1
           X_rescaled{i, j} = X{i, j}*(i-1).*factor;
           Y_rescaled{i, j} = Y{i, j}*(i-1).*factor;
           Sigma{i, j} = Sigma{i, j}*(i-1)*factor;
        end
%         figure;
%         imshow(uint8(I)),
%         if i == 1
%             hold on, plot(X{i, j},Y{i, j},'*r')
%         else
%             hold on, plot(X{i, j}*(i-1).*factor,Y{i, j}*(i-1).*factor,'*r')
%         end
%         title(sprintf('nlevel %d nscale %d', i, j))
%         pause(0.5)
    end
end

figure;
showPyramidScale(R, 1);

% Pre-calculamos la LoG
figure
PSSLoG=doLoGScaleSpacePyramid(I,factor,nlevels,nscales,sigma,w);
showPyramidScale(PSSLoG, 1);


puntos_detectados = zeros(1,3);
% Para cada nivel de la piramide
for i=1:nlevels
    % Para cada escala de la LoG (salvo la ultima)
    for j=2:nscales-2
        x = X{i, j};
        y = Y{i, j};
        sigma_det = Sigma{i, j};
        % Para cada punto detectado
        for n=1:numel(x)
            x_n = y(n);
            y_n = x(n);
            x_n_escalado = X_rescaled{i, j}(n);
            y_n_escalado = Y_rescaled{i, j}(n);
            
            % Hallamos el LoG(x, y) entre escalas consecutivas
            % Nos quedamos con su valor absoluto porque un max o min local
            % tambien un max local de su valor absoluto (salvo que pase por
            % cero), pero precisamente los valores por debajo de un cierto
            % umbral y por tanto, cerca de cero, los queremos eliminar.
            LoG_ant = PSSLoG{i, j-1};
            LoG_ant = abs(LoG_ant(x_n, y_n));
            LoG = PSSLoG{i, j};
            LoG = abs(LoG(x_n, y_n));
            LoG_post = PSSLoG{i, j+1};
            LoG_post = abs(LoG_post(x_n, y_n));
            
            % Criterio de maximo local entre escalas
            % http://perception.inrialpes.fr/Publications/2002/Mik02/Mikolajczyk_these2002.pdf
            % Si es un max/min local de la LoG 
            if LoG > LoG_ant && LoG > LoG_post
                % Se añade el punto a los puntos detectados
                puntos_detectados = [puntos_detectados;x_n_escalado,y_n_escalado,sigma_det];
            end
        end  
    end
end

puntos_x = puntos_detectados(2:end, 1);
puntos_y = puntos_detectados(2:end, 2);
puntos_s = puntos_detectados(2:end, 3);

figure;
imshow(uint8(I)),
%hold on, viscircles([puntos_x, puntos_y],  puntos_s, 'Color','r', 'LineWidth', 1);
hold on, plot(puntos_x, puntos_y,'*r')