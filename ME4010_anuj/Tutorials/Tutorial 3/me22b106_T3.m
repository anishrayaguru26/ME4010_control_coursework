clc; clear;
syms s;
G_n_sym = 160 * (2 * s + 0.1); G_d_sym = s * (s^2 + 0.1 * s + 4);
G = tf(sym2poly(G_n_sym), sym2poly(G_d_sym));
%q1
figure(1);
bode(G); grid on; title("Uncompensated");
figure(2);
a = 10 ^ ((50/45) - log10(180));
A = tf([a, 1], 1);
G1 = G * A;
bode(G1); grid on; title("PD Compensated");

%q3
figure(3);
R = tf([1/0.1, 1], 1);
G1 = G * R;
T = tf(1, [1/0.08 1]);
G2 = G1 * T;
bode(G2); grid on; title("Lag Compensated");
figure(4);
P = tf([10/16.1 1], 1);
G3 = G2 * P;
bode(G3); grid on; title("Numerator of Lead Compensated");
figure(5);
q = 10 ^ (39/45 - log10(1590));
Q = tf(1, [q 1]);
G4 = G3 * Q;
bode(G4); grid on; title("Lead Lag Compensated");