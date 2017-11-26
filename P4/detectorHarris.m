function [I_col, I_row, R, maximos] = detectorHarris(I, sigma, k, N, W)

I = double(I);
% ii) x and y derivatives
hx = [-1,0,1];
IX = conv2(I,hx,'same');
hy = [-1,0,1]';
IY = conv2(I,hy,'same'); 

% iii)
IX2 = IX.*IX; IY2 = IY.*IY; IXY = IX.*IY;

% iv)
cutoff = ceil(3.5*sigma);
h = fspecial('gaussian',[2*cutoff+1,2*cutoff+1],sigma);
SX2 = conv2(IX2,h,'same');
SY2 = conv2(IY2,h,'same');
SXY = conv2(IXY,h,'same');

% iv) calculo respuesta

Trace = SX2 + SY2;
Det = SX2.*SY2 - (SXY).^2;
R = Det - k .* Trace.^2;

% v) calculo maximos locales
se = strel('square', W);
R(1:W,:)  = 0;R(:,1:W)= 0;R(end-W+1:end,:)= 0;R(:,end-W+1:end)= 0;

%i condición de máximo local de la LoG
mk = imdilate(R, se) - R;
mk = (mk == 0);
%ii localizar el máximo local de la LoG espacialmente
maximos = R.*mk;
valores_maximos = maximos(:);
[~  ,idx] = sort(valores_maximos,'descend');
idx = idx(1:(min(numel(idx),N)));
%ix = ix(1:N);
[I_row, I_col] = ind2sub(size(maximos),idx);

end

