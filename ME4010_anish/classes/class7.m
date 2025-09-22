clc; clear; close all;

%18/9/2025


X0 = [0; 0; 0.001; 0]; %ICs of X- x and xdot
M=10;m=1;l=1;g=-9.81;
u = 0;
t = 0:0.01:10; %time span for simulation
%x is time evolution of state vector, o/p of numerical integration
[t, X] = ode45(@(t,X) inv_pen(X,m,M,l,g,u),t,X0); %-in file smd.m - 
% filename mustmatch function names to do cross file functioning

figure(3);
hold on;
plot(t,X(:,1),LineWidth=1.5); % Position of cart
plot(t,X(:,2),LineWidth=1.5); % Velocity of cart
plot(t,X(:,3),LineWidth=1.5); % Angle of pendulum
plot(t,X(:,4),LineWidth=1.5); % Angular velocity of pendulum
grid on;
legend;
hold off;

function dx = inv_pen(X,m,M,l,g,u)
    x = X(1); % position of cart
    x_dot = X(2); % velocity of cart
    theta = X(3); % angle of pendulum
    theta_dot = X(4); % angular velocity of pendulum

    dx = zeros(4,1); % preallocate

    dx(1) = x_dot; % x dot
    dx(2) = (-m*l*(theta_dot^2)*sin(theta) + u + m*g*sin(theta)*cos(theta)) / ...
            (M + m - m*(cos(theta))^2); % x double dot
    dx(3) = theta_dot; % theta dot
    dx(4) = (dx(2)*cos(theta) + g*sin(theta)) / l; % theta_ddot
end
