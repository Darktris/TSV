function ima_res=imfilter_dilate(ima,mask)

ima=uint8(ima); % Para asegurarse de que el tipo es uint8
[image_h,image_w,~] = size(ima);

[M,N]     = size(mask);
[cy]      = ceil((size(mask,1)+1)/2);
[cx]      = ceil((size(mask,2)+1)/2);


margen_up = cy-1;%
margen_dw = M-cy;
margen_lf = cx-1;%
margen_rg = N-cx;


mask    = uint8(255*fliplr(flipud(mask)));
ima_res = uint8(zeros(image_h,image_w));

for f=(margen_up+1):image_h-margen_dw,
    for c=(margen_lf+1):image_w-margen_rg,
        simage = ima( (f-margen_up):(f+margen_dw) , (c-margen_lf):(c+margen_rg));
        and_image    = bitand(simage,mask);
        ima_res(f,c) = max(max(and_image));
    end
end     

% sustituir los valores no calculados
ima_res(1:margen_up,:)         = ima(1:margen_up,:);
ima_res((end-margen_dw+1):end,:) = ima((end-margen_dw+1):end,:);
ima_res(:,1:margen_lf) = ima(:,1:margen_lf);
ima_res(:,(end-margen_rg+1):end) = ima(:,(end-margen_rg+1):end);

end
