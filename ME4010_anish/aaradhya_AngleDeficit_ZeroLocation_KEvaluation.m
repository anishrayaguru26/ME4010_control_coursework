clc; clear; close all;
g = zpk(-8,[-3 -6 -10],1);
p = -8.0445 + 15.7*1i;
fprintf("The Angle Deficit is: %.2f\n",angle_deficit(g,p))
fprintf("The Location of Zero is: %.2f\n",locate_zero(g,p))

hold on;
%rlocus(g);
gm = series(g,zpk(locate_zero(g,p),[],1));
rlocus(gm);
grid on;
plot(real(p),imag(p), '.k', MarkerSize=17);
hold off;
fprintf("The value of K (gain) is: %.2f\n", evaluate_k(gm,p));

figure(2);
hold on;
gm = add_zp_pair(gm);
plot(real(p),imag(p), '.k', MarkerSize=17);
rlocus(gm);
hold off;
grid on;

function output = add_zp_pair(g)
    gm = series(tf([1 0.01],[1 0]), g);
    output = gm;
end

function output = evaluate_k(gm,p)
    zeros = prod(abs(p - zero(gm)));
    poles = prod(abs(p - pole(gm)));
    output = poles/zeros;
end

function output = locate_zero(g,p)
    alpha = angle_deficit(g,p);
    omega = imag(p);
    sigma = real(p);
    output = -(omega - (tand(alpha) * sigma))/tand(alpha);
end

function output = angle_deficit(g,p)
    poles = p - pole(g);
    pole_sum = sum(rad2deg(angle(poles)));
    zeros = p - zero(g);
    zero_sum = sum(rad2deg(angle(zeros)));
    output = pole_sum - zero_sum;
end