clc; close all; clear;

m = 1; % mass
M = 5; % cart mass
L = 2; % length of pendulum
g = -9.81; % gravity
d = 10; %Ns/m - damping?

t = 0:.001:30;

x0 = [0; 0; pi + .1; 0]; % initial conditions 
% x = [x; x_dot; theta; theta_dot]

[t, x] = ode45(@(t,x) CtP(t, x, m, M, L, g, d), t, x0);
%TBD

