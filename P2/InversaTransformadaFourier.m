function [ ima ] = InversaTransformadaFourier( ima_f )
    ima = ifftshift(ima_f);
    ima = ifft2(ima);
end

