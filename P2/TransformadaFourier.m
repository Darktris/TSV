function [ ima_f ] = TransformadaFourier( ima )
    im_frec_2 = fft2(ima);
    ima_f = fftshift(im_frec_2);
end

