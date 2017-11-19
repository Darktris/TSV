function [ ima_res ] = Apertura( ima, se )
%APERTURA Summary of this function goes here
%   Detailed explanation goes here
    ima_res = imdilate(imerode(ima, se), se);

end

