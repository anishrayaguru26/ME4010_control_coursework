clc; clear; close all;

clc; clear; close all;

m = 1;
M = 5;
L = 2;
g = -9.81;
b = 10;

t_span = 0:0.01:30;
x0 = [0; 0; pi/60; 0];


% A = [0 1 0 0;
%  0 -b/M -m*g/M 0; 
%  0 0 0 1; 
%  0 b/(M*L) 0 1/(M*L)];

% B = [0; 1/M; 0; 1/(M*L)];


A = [0       1              0                  0;
     0   -b/M   (m*g)/M              0;
     0       0              0                  1;
     0  b/(M*L) -(M+m)*g/(M*L)       0];

B = [0;
     1/M;
     0;
    -1/(M*L)];


K = place(A, B, [-2+2i, -2-2i, -3, -4]);

[t,x] = ode45(@(t,x) inv_pen(A,B,x,-K*x), t_span, x0);

%[t_span,x_span] = ode45(@(t,x) CtP(t,x,0,M,m,L,g,b), t_span, x0);

% figure(1);
% plot(t_span,x_span(:,1)); hold on
% plot(t_span,x_span(:,3)); hold off
% legend('Cart position','Pendulum angle')


figure(2);
plot(t,x(:,1)); hold on
plot(t,x(:,3)); hold off
legend('Cart position','Pendulum angle')

% % --- function must be last ---
% function dx = CtP(t, x, u, M, m, L, g, b)
%     D = m*L^2 * (M + m*(1 - cos(x(3))^2));
%     dx(1,1) = x(2);
%     dx(3,1) = x(4);
%     dx(2,1) = (-(m*L)^2 * g * cos(x(3)) * sin(x(3)) ...
%                + (m*L)^2 * sin(x(3)) * cos(x(3)) * x(4)^2 ...
%                + (m*L)^2 * u - b*x(2)) / D;
%     dx(4,1) = ((m+M)*m*g*L*sin(x(3)) ...
%                - m*L*cos(x(3))*u ...
%                + b*x(2)*m*L*cos(x(3))) / D;
% end



function dx = inv_pen(A,B, x, u)
    dx = A*x + B*u;
end


