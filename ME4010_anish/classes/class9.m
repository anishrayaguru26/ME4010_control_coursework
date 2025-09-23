clc; clear; close all;

m = 1;
M = 5;
L = 2;
g = -9.81;
b = 10;

A = [0 1 0 0;
 0 -b/M -m*g/M 0; 
 0 0 0 1; 
 0 b/(M*L) 0 1/(M*L)];

B = [0; 1/M; 0; 1/(M*L)];

t_span = 0:0.01:30;
x0 = [0; 0; pi/60; 0];

[t,x] = ode45(@(t,x) inv_pen(A,B,x,0), t_span, x0);
figure(1);
plot(t,x(:,3));

function dx = inv_pen(A,B, x, u)
    dx = A*x + B*u;
end


% function dx = inv_pen_2(m, g, L, b, M, x, u)

%     dx(1,1) = x(1);
%     dx(2,1) = - (m*L)^2 * g * sin(x(3)) - b*x(2) + m*L*cos(x(3))* (m*L*x(4)^2*sin(x(3)) + u) / (M + m) ) / ( (M + m)*L^2 - (m*L*cos(x(3)))^2 );
%     dx(3,1) = x(3);
%     dx(4,1) = x(4);

%     return
% end