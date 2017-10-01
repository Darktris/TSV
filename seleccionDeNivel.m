function [ima_selec,mk] = seleccionDeNivel(ima,nivel_inf,nivel_sup)

ima_selec = zeros(size(ima),'uint8');
mk = false(size(ima));
mk((ima < nivel_sup) & (ima >= nivel_inf)) = 1;
ima_selec(mk) = ima(mk);


return;
