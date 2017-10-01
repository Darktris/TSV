function [ ima_res, s ] = AjustePorTramos( ima, a, b, sa, sb, L )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    alpha = sa/a;
    beta = (sb-sa)/(b-a);
    gamma = (L-1-sb)/(L-1-b);
    r = 0:L-1;
    s(r<a) = alpha*r(r<a);
    s(r>=a & r < b) = beta*(r(r>=a & r < b) - a) + sa;
    s(r>=b) = gamma*(r(r>=b) - b) + sb;
    ima_res = s(ima+1);
end

