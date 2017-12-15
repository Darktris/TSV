function [x, y] = extraerMaximosLocales(I, se)
    mk = imdilate(I,se) - I;
    [y,x] = find(mk == 0);
end