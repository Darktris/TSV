function ima_combinada = combinaNiveles(Niveles,Mascaras)
% esta función no debe alterarla
nNiveles      = max(size(Niveles));
[nr,nc,nch]   = size(Niveles{1});
ima_combinada = zeros([nr,nc,nch]);

for nivel = 1:nNiveles,
ima_combinada = ima_combinada + Niveles{nivel}.*repmat(Mascaras{nivel},[1,1,nch]);
end

ima_combinada = uint8(ima_combinada);