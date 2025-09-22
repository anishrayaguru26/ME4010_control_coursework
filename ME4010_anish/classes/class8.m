%22nd sep 2025

%setting up a system-
clc; clear; close all;

%spring mass damper system- 

m = 10; %kg
k = 1000; %N/m
c = 10; %Ns/m
%u = 0;

t = 0:0.01:10; % timespan, 0 to 10 with steps of 0.01

x0 = [-1; 0]; %ICs of X- x and xdot

%x is time evolution of state vector, o/p of numerical integration
%[t, x] = ode45(@(t,x) smd(x,m,k,c,u),t,x0); %-in file smd.m - 
% filename mustmatch function names to do cross file functioning

%plot(t,x(:,2)); %plots only xdotx

zeta = (0.5*c)/sqrt(m*k);
wn = sqrt(k/m);

wd = wn*sqrt(1- zeta^2);

A = [0 1; -k/m -c/m];
B = [0; 1/m];

pole = -0.5 + 10*i;
p = [pole; conj(pole)]; %desired poles

%K = acker(A,B,p);
%acker or place can be used to compute K - 
% acker doesnt work for complicated systems

K = place(A,B,p);
t_dash = 0:0.01:10;
%done by including closed loop feedback
%[t_dash, x_dash] = ode45(@(t,x) smd(x,m,k,c,-K*x),t_dash,x0);

%Done directly via matrices
[t_dash, x_dash] = ode45(@(t,x) smd2(x,A,B,-K*x),t_dash,x0);
figure(2);
plot(t_dash,x_dash(:,1)); hold on
plot(t_dash,x_dash(:,2)); 

