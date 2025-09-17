%17th september 2025

%setting up a system-
clc; clear; close all;

%spring mass damper system- 

m = 10; %kg
k = 1000; %N/m
c = 10; %Ns/m
u = 0;

t = 0:0.01:10; % timespan, 0 to 10 with steps of 0.01

x0 = [10; 0]; %ICs of X- x and xdot

%x is time evolution of state vector, o/p of numerical integration
[t, x] = ode45(@(t,x) smd(x,m,k,c,u),t,x0); %-in file smd.m - 
% filename mustmatch function names to do cross file functioning


plot(t,x(:,2)); %plots only xdotx

zeta = (0.5*c)/sqrt(m*k);
wn = sqrt(k/m);

wd = wn*sqrt(1- zeta^2);


