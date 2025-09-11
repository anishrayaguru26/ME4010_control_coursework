clc; clear; close all;

g = zpk([-8], [-3 -6 -10], 1);   

figure(1);
rlocus(g); hold on

zeta = 0.456; %using second order assumption

ang = 180 - acosd(zeta);

r = 40;

plot([0, r*cosd(ang)], [0, r*sind(ang)], '--'); hold off


figure(2);
z = zpk([-55], [],[121]);
step(z*g);
%step(g);