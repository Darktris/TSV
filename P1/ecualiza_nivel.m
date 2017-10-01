function ima_eq = ecualiza_nivel(ima)
    [counts, bins] = imhist(ima);
    hist = counts(2:255);
    cdf = cumsum(hist)/sum(hist);
    cdf = cat(1, 0, cdf);
    ima_eq  = cdf(ima+1);

    m = min(ima_eq(:));
    M = max(ima_eq(:));

    ima_eq = (ima_eq - m)*(255)/(M-m);
    ima_eq = uint8(ima_eq); 
return;