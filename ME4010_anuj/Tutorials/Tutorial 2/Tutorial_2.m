% Question 1

clear; clc;

syms s;

OS = 0.15; T_s = 1.2;
zeta = (-log(OS)) / sqrt(pi^2 + (log(OS))^2);
w_n = 4 / (zeta * T_s);
w_d = w_n * sqrt(1 - zeta^2);

disp("[1(a)] Poles are at:");
r1 = complex(-zeta * w_n, w_d); r2 = complex(-zeta * w_n, -w_d); %pole values
disp(r1); disp(r2);

G_n_sym = 1; G_d_sym = (s + 5)^3; %initial G without gain
G = tf(G_n_sym,sym2poly(G_d_sym));

G_poles = roots(sym2poly(G_d_sym));

angle_lhs = 0; %this will be the term on the lhs of the angle equation to that will have all contributions of the poles and zeros we know

i = 1;

%summing angle contributions from poles
while i <= length(G_poles)
    angle_lhs = angle_lhs - atan2(imag(r1 - G_poles(i)),real(r1 - G_poles(i)));
    i = i + 1;
end

zero_given = -1;
angle_lhs = angle_lhs + atan2(imag(r1 - zero_given),real(r1 - zero_given));

angle_pole = angle_lhs - pi; %finding angle contribution of the compensator pole
disp("[1(b)] Angle _contribution of compensator pole (in degrees):");
disp(angle_pole*(180/pi));

pole_comp = real(r1) - imag(r1)/(tan(angle_pole)); %compernstor pole

disp("[1(c)] Compensator pole value is:");
disp(pole_comp);

G_new_n_sym = G_n_sym * (s - zero_given); G_new_d_sym = G_d_sym * (s - pole_comp);
K = round(abs(vpa(subs(G_new_d_sym/G_new_n_sym, s, r1))), 4); %K = 1/|G|

disp("[1(d)] Gain obtained:");
disp(K);

%closed loop transfer function
G_new_closed_d_sym = G_new_d_sym + K*G_new_n_sym;
G_new_closed_d = sym2poly(G_new_closed_d_sym);

disp("[1(e)] Poles of closed loop transfer function after compensation:");
root_list = roots(G_new_closed_d);
disp(root_list);

%if any of the poles and not 5 times farther away than the dominant one
%then the approximation is nott valid
i = 1; check = 1;
while i <= length(root_list)
    if pole_comp <= 5 * real(root_list(i))
        check = 1;
    else
        check = 0;
        break;
    end
    i = i + 1;
end

if check == 1
    disp("[1(f)] Our second order approximation is valid");
else
    disp("[1(f)] Our second order approximation is not valid");
end

clear; 
disp('-------------------------------')
% Question 2

syms s

G_d_sym = s^2 * (s + 5) * (s + 15); G_n_sym = s^2; %explanation for why it is s^2 and not 1 is given in pdf

OS = 0.205; T_s = 3;
zeta = (-log(OS)) / sqrt(pi^2 + (log(OS))^2);
w_n = 4 / (zeta * T_s);
w_d = w_n * sqrt(1 - zeta^2);

r1 = complex(-zeta * w_n, w_d); r2 = complex(-zeta * w_n, -w_d);

G_poles = roots(sym2poly(G_d_sym));
G_zeros = roots(sym2poly(G_n_sym));
i = 1;

angle_lhs = 0;

%summing angle contributions from poles
while i <= length(G_poles)
    angle_lhs = angle_lhs - atan2(imag(r1 - G_poles(i)), real(r1 - G_poles(i)));
    i = i + 1;
end

i = 1;
%summing angle contributions from zeros
while i <= length(G_zeros)
    angle_lhs = angle_lhs + atan2(imag(r1 - G_zeros(i)), real(r1 - G_zeros(i)));
    i = i + 1;
end

zero_comp = -13; %guessing zero and calculating pole based on resulting angle contribution
theta_zero_comp = atan2(imag(r1 - zero_comp),real(r1 - zero_comp));
theta_pole_comp = angle_lhs + theta_zero_comp - pi;
pole_comp = (real(r1) - imag(r1)/tan(theta_pole_comp));
rlocus(tf(sym2poly(G_n_sym * (s - zero_comp)),sym2poly(G_d_sym * (s - pole_comp)))); hold on; plot(complex(r1), 'rx');

G_new_d_sym = G_d_sym * (s - pole_comp); G_new_n_sym = G_n_sym * (s - zero_comp);

K = round(abs(vpa(subs(G_new_d_sym/G_new_n_sym, s, r1))), 4);

disp("[2(a)] gain:");
disp(K)
disp("poles of open loop:")
disp(roots(sym2poly(G_new_d_sym)));
disp("zeros of open loop:")
disp(roots(sym2poly(G_new_n_sym)));

G_new_closed_d_sym = G_new_d_sym + K*G_new_n_sym;
G_new_closed_d = sym2poly(G_new_closed_d_sym);

disp("Poles of closed loop transfer function after compensation:");
root_list = roots(G_new_closed_d);
disp(root_list);

%if any of the poles and not 5 times farther away than the dominant one
%then the approximation is nott valid
i = 1; check = 1;
while i <= length(root_list)
    if pole_comp <= 5 * real(root_list(i)) 
        check = 1;
    elseif root_list(i) == 0
        check = 1;
    else
        check = 0;
        break
    end
    i = i + 1;
end

if check == 1
    disp("[2(b)] Our second order approximation is valid");
else
    disp("[2(b)] Our second order approximation is not valid");
end
