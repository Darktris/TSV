function [ E ] = getEnergia( ima )
%GETENERGIA Summary of this function goes here
%   Detailed explanation goes here
    E = sum(double(ima(:)).^2);
end

