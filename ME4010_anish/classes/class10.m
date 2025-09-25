%24/09/2025


%LQR - linear quadratic regulator
%regulator system? - i/p is a fixed value
m = 1;
M = 5;
L = 2;
g = -9.81;
b = 10;
%u = 0;

A = [0       1              0                  0;
     0   -b/M   (m*g)/M              0;
     0       0              0                  1;
     0  b/(M*L) -(M+m)*g/(M*L)       0];

B = [0;
     1/M;
     0;
    -1/(M*L)];


x0 = [-4; 0; pi+deg2rad(10); 0]; %ICs of X- x and xdot
Q = [1 0 0 0;1 1 0 0 ; 0 0 1 0; 0 0 0 1];

R = 1;
K = lqr(A,B,Q,R);

eig(A-B*K);
t_sim = 0:.1:20.0;


[t,x] = ode45(@(t,x) CtP(t,x,-K*x, M, m, L, g, b), t_sim, x0);




% function dx = CtP(t, x, u, M, m, L, g, b)
%     %CtP - Cart to Pendulum dynamics
%     D = m*L^2 * (M + m*(1 - cos(x(3))^2));
%     dx(1,1) = x(2);
%     dx(3,1) = x(4);
%     dx(2,1) = (-(m*L)^2 * g * cos(x(3)) * sin(x(3)) + (m*L)^2 * sin(x(3)) * cos(x(3)) * x(4)^2 + (m*L)^2 * u) - b*x(2)/D;
%     dx(4,1) = ( (m+M)*m* g *L* sin(x(3)) - (m*L)^2 * sin(x(4)) * cos(x(3)) * x(4)^2 - m*L*cos(x(3)) * u + b*x(2)*m*L*cos(x(3)))/D;

% end