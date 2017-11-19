function [ima_th, th] = UmbralizaGlobalOtsu(ima)
    L = 256;
    r = 0:L-1;
    counts = imhist(ima);
    p = transpose(counts/sum(counts));
    ths = zeros(size(r));
    for T=r
        PO = sum(p(r<=T));
        PB = 1-PO;
        rpr = p.*r;
        muO = sum(rpr(r<=T))/PO;
        muB = sum(rpr(r>T))/PB;
        rminusMuO = r-muO;
        rminusMuB = r-muB;
        varO = sum(rminusMuO(r<=T).^2.*p(r<=T))/PO;
        varB = sum(rminusMuB(r>T).^2.*p(r>T))/PB;
        ths(T==r) = PO*varO+PB*varB;
    end
    [~, minloc] = min(ths);
    th = minloc - 1; % Este programa indexa en 1
    ima_th = zeros(size(ima));
    ima_th(ima>=th) = 1;
end 