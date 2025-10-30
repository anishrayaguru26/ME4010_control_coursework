
m = 1; % mass of pendulum
M = 5; % mass of cart
L = 2; % length of pendulum
g = -9.81; % m/s^2
d = 1; % Ns/m
s = 1;

g = -9.81;
b = 10;

A = [0       1              0                  0;
     0   -b/M   (m*g)/M              0;
     0       0              0                  1;
     0  b/(M*L) -(M+m)*g/(M*L)       0];

B = [0;
     1/M;
     0;
    -1/(M*L)];

Q = [1 0 0 0;
    0 1 0 0;
    0 0 10 0;
    0 0 0 1]; % penalty on system states deviating from reference
R = .010; % penalty on input
K = lqr(A,B,Q,R);

disp('Eigenvalues of A-BK = ')
eig(A-B*K)