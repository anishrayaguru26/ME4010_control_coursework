%clc; clear;
% close all;
%Anuj's code


syms x1 x2 x3 x4
syms F m M l g
f1 = x2; f3 = x4;

n2 = F * cos(x3) - m * l * (x4 ^ 2) * sin(x3) * cos(x3) + (M + m) * g * sin(x3) - g * sin(x3) * (M + m * sin(x3)^2);
d2 = cos(x3) * (M + m * ((sin(x3))^2));

n4 = F * cos(x3) - m * l * (x4 ^ 2) * sin(x3) * cos(x3) + (M + m) * g * sin(x3);
d4 = l * (M + m * ((sin(x3))^2));

f2 = n2 / d2; f4 = n4 / d4;

J = [diff(f1, x1) diff(f1, x2) diff(f1, x3) diff(f1, x4);
    diff(f2, x1) diff(f2, x2) diff(f2, x3) diff(f2, x4);
    diff(f3, x1) diff(f3, x2) diff(f3, x3) diff(f3, x4);
    diff(f4, x1) diff(f4, x2) diff(f4, x3) diff(f4, x4)];

J1 = vpa(subs(J, [x1 x2 x3 x4 m M g l], [0 0 0 0 1 5 9.81 2]), 6);
J2 = vpa(subs(J, [x1 x2 x3 x4], [0 0 pi 0]), 2);

m = 1; % mass of pendulum
M = 5; % mass of cart
L = 2; % length of pendulum
g = -9.81; % m/s^2
d = 1; % Ns/m

t_sim = 0:.1:30;
s = 1;
A = [0 1 0 0;
    0 0 1.962 0;
    0 0 0 1;
    0 0 5.886 0];


B = [0; 1/M; 0; s*1/(M*L)];
%%
x0 = [0;0;pi+1; 0]; % initial conditions
ref = [2;0;pi;0]; % reference value
%%
Q = [1 0 0 0;
    0 1 0 0;
    0 0 10 0;
    0 0 0 1]; % penalty on system states deviating from reference
R = .010; % penalty on input
K = lqr(A,B,Q,R);

disp('Eigenvalues of A-BK = ')
eig(A-B*K)
%%
disp('solving');
[t,x] =  ode45(@(t,x)CtP(x,M,m,L,g,0,-K*(x-ref)),t_sim, x0);

disp('rendering')
%figure(1)
%CtP_render(t,x,m,M,L);

figure(1);
plot(t, x(:,1)); hold on;
