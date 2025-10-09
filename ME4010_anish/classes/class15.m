
clc; clear; close all;
m = 10;
k = 1000;
c = 10;
u = [0; 0];

A = [0 1; -k/m -c/m];
B = [0; 1/m];
C = [1 0];

p_o = eig(A)*2; %desired poles

Ke = place(A', C', p_o)';

A_o = [A zeros(2,2); zeros(2,2) A-(Ke*C)];
B_o = [B zeros(2,1); B Ke];


t_sim = 0:0.01:10;
x0=[-2; 0; 100; 100;]; %ICs - [x, xdot, e , edot]

[t,x] = ode45(@(t,x) smd2(A_o,x,B_o,u), t_sim, x0);

x_only = x(:,1);
xdot = x(:,2);
x_t = x(:,1) - x(:,3);
x_tdot = x(:,2) - x(:,4);

figure;
subplot(2,3,1);
plot(t,x_only);
title("x")

subplot(2,3,2);
plot(t,xdot);
title("xdot")

subplot(2,3,3);
plot(t,x_t);
title("x_t")

subplot(2,3,4);
plot(t,x_tdot);
title("x_t dot")

subplot(2,3,5);
plot(t,x(:,3));
title("error in x and x_t")

subplot(2,3,6);
plot(t,x(:,4));
title("error in xdot and x_t dot")


function dx = smd2(A_o,x, B_o,u)
    dx = A_o*x + B_o*u;
end