function [x] = system_vehicle(x, u, ts)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
k1 = func_vehicle(x, u);
k2 = func_vehicle(x + ts/2*k1, u);
k3 = func_vehicle(x + ts/2*k2, u);
k4 = func_vehicle(x + ts*k3, u);
x = x +ts/6*(k1 +2*k2 +2*k3 +k4);

end