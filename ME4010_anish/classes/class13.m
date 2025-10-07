%1/10/25
%Observer for spring mass damper system
%% system variables - 
clc; clear; close all;
m = 10;
k = 1000;
c = 10;
u = 0;

A = [0 1; -k/m -c/m];
B = [0; 1/m];
C = [1 0];

%place poles at 2-5x eigenvectors of the system - ...
%in this case A matrix

eigenvals = eig(A);

x_0 = [-2;0;]; %ICs

p_o = [-2.4, -2.5]; %2-5x eigenvalues of A -...
%  forces error to settle, fig 4

%transpose of controller gain matrix of the dual system
Ke = place(A', C', p_o)';

t_span = 0:0.01:10;

%check observability
fprintf("rank of observability matrix")
disp(rank(obsv(A,C)));

%system
[t, x] = ode45(@(t,x) smd2(x,A,B,u), t_span, x_0);

Y = transpose(C*x'); %causes error- why? x is all time, y is at an instant
% is actual o/p
%([1x2]*[mx2]')'


snr = 20;
y = awgn(Y,snr); % Adding Gaussian noise -
%snr - signal to noise ratio - 20 is good



%observer %y and x_t?
x_0 = [-10; 1]; %initial guess of states
[t_o, x_t] = ode45(@(t_o,x_t) obs(t_o,y,x_t,A,B,C,Ke,u,t), t_span, x_0);


%x_t plotting
figure;
subplot(2,2,1);
plot(t,y); hold on
plot(t_o,x_t(:,1)); hold off
legend("o/p measurement y", "estimated displacement, x_t");
title("x_t plotting")


%error plotting
subplot(2,2,2);
plot(t_o, y - x_t(:,1)); hold off% Convergence of error to 0
title("error plotting")

% see x vs x_t velocity
subplot(2,2,3);
plot(t, x(:,2)); hold on
plot(t_o, x_t(:,2)); hold off
title("x vs x_t velcoity")
legend("x","x_t")

% see difference in velocity

subplot(2,2,4);
plot(t_o, x(:,2) - x_t(:,2)); % error development
title("error development in velocity")

%% Observer function

function dx_t = obs(t_o, Y, x_t, A, B, C, Ke, u, t) %caps Y instead of small Y
    y = interp1(t, Y, t_o); %interpolating all y data at time t_o wrt to variable t
    dx_t = A*x_t + B*u + Ke*(y - C*x_t);
end

function dx=smd2(x,A,B,u)
%spring mass damper system-
%time appended as rows, and states as columns- since IC was [x0 xdot0]
dx = A*x + B*u;
%ie dx is Xdot, or derivative of state vector
end