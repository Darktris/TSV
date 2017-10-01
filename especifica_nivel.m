function ima_eq_esp = especifica_nivel(ima_eq,patt)

[nr,nc]      = size(ima_eq);
[~,~,nch]    = size(patt);
ima_eq_esp = zeros([nr,nc,nch]);

for ch=1:size(patt,3)
    ima = patt(:,:, ch);
    counts = imhist(ima);
    ima_eq_esp(:,:,ch) = histeq(ima_eq, counts);
end

return;