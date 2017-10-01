function [ res, s ] = Ecualizacion(ima, L)
    r = 0:L-1;
    counts = imhist(ima);
    cdf = cumsum(counts)/sum(counts);
    s = cdf(r+1);
    res = s(ima+1);
end