%8/10/25

%real time observer- different from class13.m

clc; clear; close all;
m = 10;
k = 1000;
c = 10;
u = [0; 0];

A = [0 1; -k/m -c/m];
B = [0; 1/m];
C = [1 0];


x0=[-2,0,-10,-1]; %ICs - [x, xdot, x_t, x_t dot]

p_o = [-2.4, -2.5];

Ke = place(A', C', p_o)';

% state vector is [x, e]' = [x, xdot, x_t, x_t dot]'

A_o = [A zeros(2,2); zeros(2,2) A-(Ke*C)];
B_o = [B zeros(2,1); B Ke];

t_sim = 0:0.01:10;

% Y = transpose(C*x'); %actual o/p
% snr = 20;
% y = awgn(Y,snr); % Adding Gaussian noise -

[t,x_o] = ode45(@(t,x_o) smd2(x_o,A_o,B_o,u), t_sim, x0);


figure;
subplot(2,2,1);
plot(t,x_o(:,1));
title("x")

subplot(2,2,2);
plot(t,x_o(:,2));
title("xdot")

subplot(2,2,3);
plot(t,x_o(:,3));
title("x_t")

subplot(2,2,4);
plot(t,x_o(:,4));
title("x_t dot")


figure;
subplot(2,2,1);
plot(t,x_o(:,1)-x_o(:,3));
title("error in x and x_t")
grid on

subplot(2,2,2);
plot(t,x_o(:,2)-x_o(:,4));
title("error in xdot and x_t dot")
grid on

subplot(2,2,3);
plot(t,x_o(:,3)); hold on
plot(t,x_o(:,1)); hold off
legend("x_t", "x");

subplot(2,2,4);
plot(t,x_o(:,4)); hold on
plot(t,x_o(:,2)); hold off
legend("x_t dot", "x dot");




function dx=smd2(x,A,B,u)
%spring mass damper system-
%dx = zeros(2,1); %preallocating dx
%time appended as rows, and states as columns- since IC was [x0 xdot0]
dx = A*x + B*u;

%ie dx is Xdot, or derivative of state vector

end
