function [ ima_res ] = Cierre( ima, se )
%APERTURA Summary of this function goes here
%   Detailed explanation goes here
    ima_res = imerode(imdilate(ima, se), se);

end

