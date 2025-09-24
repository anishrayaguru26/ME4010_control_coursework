clc; clear; close all;
G = zpk([-5], [-2, -4, -7, -9],[1]);
zeta = 0.7;
ang = acosd(zeta);
ang = 180 - ang; 
r = 40;

alpha = zeta / sqrt(1 - zeta^2);

for omega = 1:0.01:100
    sigma = -alpha*omega;
    p = sigma + 1i*omega;
    if point_on_rl(p, G)
        intersection_point = p;
        gain = evaluate_k(G, p); 
        fprintf("The point on the root locus is: %.2f + %.2fi\n", real(p), imag(p));
        fprintf("The gain K is: %.2f\n", gain);
        break;
    end
end

%settling time = 4/(zeta*wn) = 1
wn = 4/(zeta*1);
wd = wn*sqrt(1-zeta^2);
point_to_pass_through = -zeta*wn + 1i*wd; % casecade comp rl must pass through this point
%add a zero on the real axis to move the root locus through this point

for comp_pole = -40:0.01:0
    comp_zero = -4.5; % keep the zero to the right of the pole by 4.5 units
    cascade_comp = zpk(comp_zero, comp_pole, 1);
    G_c = series(G, cascade_comp);
    if point_on_rl(point_to_pass_through, G_c)
        fprintf("The compensator pole is at: %.2f\n", comp_pole);
        final_comp_pole = comp_pole;
        break;
    end
end

%comp_zero = 4.5; %default value 4.5
cascade_comp = zpk(comp_zero, final_comp_pole, 1);
G_c = series(G, cascade_comp);

figure(1);
title('Step response for zeta = 0.7');
z = feedback(series(G, gain), 1);
step(z); 

figure(2);
rlocus(G); hold on
plot([0, r*cosd(ang)], [0, r*sind(ang)], '--'); 
plot (real(point_to_pass_through), imag(point_to_pass_through), 'ro'); hold off
title('Root Locus without Compensator');

figure(3);
rlocus(G_c); hold on
plot([0, r*cosd(ang)], [0, r*sind(ang)], '--');
plot (real(point_to_pass_through), imag(point_to_pass_through), 'ro'); hold off
title('Root Locus with Compensator');

figure(4);
z2 = feedback(series(G, gain), 1);
z1 = feedback(series(G_c, evaluate_k(G_c, point_to_pass_through)), 1);
step(z2); hold on
step(z1); hold off
title('Step response with and without Compensator');
legend('Original G', 'G with Compensator');


%e part TBD

%% question 2
%peak time has to be half- and OS has to be 0.7 of of before- by adding a zero to G

old_peak_time = pi/wd;
new_peak_time = old_peak_time/2;
old_OS = exp((-zeta*pi)/sqrt(1-zeta^2));
new_OS = 0.7*old_OS;

%peak time = f(wn, zeta)
%   = (pi/(wn*sqrt(1-zeta^2)))

%OS = f(zeta) 
%   = exp((-zeta*pi)/sqrt(1-zeta^2))

%so if we want a new OS, we MUST alter zeta

%=> we can find new zeta from new OS
new_zeta = -log(new_OS)/sqrt(pi^2 + (log(new_OS))^2);
%=> wn is independent of zeta, 
new_wd = pi/new_peak_time;
new_wn = new_wd/sqrt(1-new_zeta^2);

%desired new point is - zeta*wn + j*wd

%new rl must pass through - 
new_operating_point = -new_zeta*new_wn + 1i*new_wd;

for added_zero = -100:0.01:50
    G_dash = series(G, zpk(added_zero, [], 1));
    if point_on_rl(new_operating_point, G_dash)
        fprintf("The added zero is at: %.2f\n", added_zero);
        final_added_zero = added_zero;
        break;
    end
end
% wd_new = pi/new_peak_time;
% wn_new = wd_new/sqrt(1-zeta^2);

fprintf("The peak time is: %.2f seconds\n", old_peak_time);
fprintf("The new peak time is: %.2f seconds\n", new_peak_time);
fprintf("The overshoot is: %.2f %%\n", old_OS*100);
fprintf("The new overshoot is: %.2f %%\n", new_OS*100);
fprintf("The new damping ratio is: %.2f\n", new_zeta);

%G_dash = series(G, zpk(final_added_zero, [], 1));

fprintf("The added zero is at: %.2f\n", final_added_zero);

figure(5);
rlocus(G_dash); hold on
plot([0, -100*cosd(acosd(new_zeta))], [0, 100*sind(acosd(new_zeta))], '--');
plot(real(new_operating_point), imag(new_operating_point), 'ro'); hold off
title('Root Locus with Added Zero');

gain2 = evaluate_k(G_dash, new_operating_point);


figure(6);
step(feedback(series(G, gain), 1)); hold on
z3 = series(G_dash, gain2);
step(feedback(z3, 1)); hold off
title('Step Response Comparison');
legend('Original G', 'G with Added Zero');


function angdeficit = angle_deficit(point, trans_func)
    poles = point - pole(trans_func);
    pole_ang_sum = sum(rad2deg(angle(poles)));
    zeros = point - zero(trans_func);
    zero_ang_sum = sum(rad2deg(angle(zeros)));
    theta_net = zero_ang_sum - pole_ang_sum;
    angdeficit = 180 - mod(theta_net, 360); 
end


function output = point_on_rl(point, trans_func)
    tol = 1; % tolerance in degrees
    
    poles = point - pole(trans_func);
    pole_ang_sum = sum(rad2deg(angle(poles)));
    zeros = point - zero(trans_func);
    zero_ang_sum = sum(rad2deg(angle(zeros)));
    total = pole_ang_sum - zero_ang_sum;

    total = mod(total + 180, 360) - 180;

    if abs(abs(total) - 180) < tol
        output = true;
    else
        output = false;
    end
end


function output = evaluate_k(trans_func, point)
    zeros = prod(abs(point - zero(trans_func)));
    poles = prod(abs(point - pole(trans_func)));
    output = poles/zeros;
end