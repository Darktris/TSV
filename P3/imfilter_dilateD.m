function ima_res=imfilter_dilateD(ima,mask)

ima=uint8(ima); % Para asegurarse de que el tipo es uint8
[mask_h,mask_w] = size(mask);
mask    = uint8(mask);
mask_cx = floor((mask_w+1)/2);
mask_cy = floor((mask_h+1)/2);

ima_res = ima;

for x = 1:mask_w
    for y = 1:mask_h
        if mask(y, x) > 0
            x_c = x - mask_cx;
            y_c = y - mask_cy;
            ima_res = max(ima_res, circshift(ima, [y_c x_c]));
        end
    end
end

% sustituir los valores (no) calculados
margen_up = mask_cy-1;
margen_dw = mask_h-mask_cy;
margen_lf = mask_cx-1;
margen_rg = mask_w-mask_cx;
ima_res(1:margen_up,:)         = ima(1:margen_up,:);
ima_res((end-margen_dw+1):end,:) = ima((end-margen_dw+1):end,:);
ima_res(:,1:margen_lf) = ima(:,1:margen_lf);
ima_res(:,(end-margen_rg+1):end) = ima(:,(end-margen_rg+1):end);

end
