function [ mask2 ] = NormalizaMascara( mask1 )
%NORMALIZAMASCARA Summary of this function goes here
%   Detailed explanation goes here
    mask2 = mask1/sum(mask1(:));
end

