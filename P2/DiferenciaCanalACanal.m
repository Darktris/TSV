function [ diff ] = DiferenciaCanalACanal( ima, ima_res )
    diff = zeros(size(ima));
    for c=1:3
        diff(:,:,c) = (ima_res(:,:,c) - double(ima(:,:,c))).^2;
    end


end

