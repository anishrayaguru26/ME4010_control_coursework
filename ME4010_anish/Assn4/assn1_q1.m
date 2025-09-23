clc; clear; close all;
G = zpk([-5], [-2, -4, -7, -9],[1]);

rlocus(G); hold on
zeta = 0.7;

ang = acosd(zeta);
ang = 180 - ang; 

r = 40;

plot([0, r*cosd(ang)], [0, r*sind(ang)], '--'); hold off


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

for comp_pole = -10:0.01:0
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
step(G); hold on
step(G_c); hold off
figure(3);
rlocus(G_c); hold on
plot([0, r*cosd(ang)], [0, r*sind(ang)], '--'); 
plot (real(point_to_pass_through), imag(point_to_pass_through), 'ro'); hold off
title('Root Locus with Compensator');
figure(4);
rlocus(G); hold on
plot([0, r*cosd(ang)], [0, r*sind(ang)], '--'); 
plot (real(point_to_pass_through), imag(point_to_pass_through), 'ro'); hold off
title('Root Locus without Compensator');

function output = point_on_rl(point, trans_func)
    tol = 1; % tolerance in degrees
    
    poles = point - pole(trans_func);
    pole_ang_sum = sum(rad2deg(angle(poles)));
    zeros = point - zero(trans_func);
    zero_ang_sum = sum(rad2deg(angle(zeros)));
    total = pole_ang_sum - zero_ang_sum;
    
    % Wrap into [-180, 180]
    total = mod(total + 180, 360) - 180;
    
    % Check if angle is close to ±180
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