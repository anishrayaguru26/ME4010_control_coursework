clc; close all; clear;

m = 1; % mass of pendulum
M = 5; % mass of cart
L = 2; % length of pendulum
g = -9.81; % m/s^2
d = 10; % Ns/m

t_sim = 0:.1:10;



x0 = [0;0;pi+.01; 0.0]; %initial condition
[t,x] =  ode45(@(t,x)CtP(x,M,m,L,g,d,0),t_sim, x0);
CtP_render(t,x,m,M,L);