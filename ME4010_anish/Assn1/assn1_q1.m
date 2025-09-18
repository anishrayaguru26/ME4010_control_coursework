G = zpk([-5], [-2, -4, -7, -9],[1]);

rlocus(G); hold on
zeta = 0.7;

ang = 180 - acosd(zeta);

r = 40;

plot([0, r*cosd(ang)], [0, r*sind(ang)], '--'); hold off


