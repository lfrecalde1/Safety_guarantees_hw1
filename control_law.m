function [u] = control_law(x, k1, k2)
%UNTITLED4 Summary of this function goes here
x1 = x(1);
y1 = x(2);
theta_1 = x(3);
v = x(4);
omega  = x(5);
u_1 = -k1*v - x1*cos(theta_1) -y1*sin(theta_1);
u_2 = -k2*omega - theta_1;

u = [u_1; u_2];
end