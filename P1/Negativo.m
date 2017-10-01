function [ ima_res ] = Negativo( ima , L)
%NEGATIVO Summary of this function goes here
%   Detailed explanation goes here
    r = 0:L-1;
    s = fliplr(r);
    ima_res = s(ima+1);
end

