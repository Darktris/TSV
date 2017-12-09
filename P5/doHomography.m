function [Pos1, Pos2, H, inliers]=doHomography(I1,I2,nM)
if nargin > 3 || nargin < 3
    sprintf(['PARAMETROS INCORRECTOS\n'
        'function[DoG] = doHomography(ima1,ima2,nMatches)\n'
        'ima1 :imagen leida desde archivo1\n'
        'ima2 :imagen leida desde archivo2\n'
        'nM :número de correspondencias Pos1/2 de la homografia\n'
        'EJEMPLOS :\n'
        ' doHomography(ima1,ima2,30);\n'])
    return
end

    [F1,D1] = vl_sift(I1);
    [F2,D2] = vl_sift(I2);
    [matches, err] = vl_ubcmatch(D1,D2);
    
    [~  ,ind] = sort(err,'ascend');
    ind = ind(1:(min(numel(ind),nM)));
    
    Best_ind = ind(1:nM);
    cor1 = matches(1, Best_ind);
    cor2 = matches(2, Best_ind);
    Pos1=[F1(1,cor1)',F1(2,cor1)'];
    Pos2=[F2(1,cor2)',F2(2,cor2)'];
    [H, inliers] = ransacfithomography(Pos1',Pos2', 0.001); 
end
